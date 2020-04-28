package fr.cg44.plugin.socle.queryfilter;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.io.IOUtil;
import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.bean.SectorResult;
import generated.Canton;
import generated.City;
import generated.FicheLieu;


/**
 * Filtre pour la sectorisation.
 */
public class SectorisationQueryFilter extends LuceneQueryFilter {

	private static final Logger LOGGER = Logger.getLogger(SectorisationQueryFilter.class);

	private static String SECTORISATION_URL_COMMUNE_PROP = "jcmsplugin.socle.sectorisation.commune.url";
	private static String SECTORISATION_URL_POINT_PROP = "jcmsplugin.socle.sectorisation.point.url";
	private static String SECTORISATION_URL_RECTANGLE_PROP = "jcmsplugin.socle.sectorisation.rectangle.url";
	
	private static int TIMEOUT = Integer.parseInt(getChannel().getProperty("jcmsplugin.socle.rest.timeout", "2000"));


	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {
		return qh;
	}


	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {			
		String commune = HttpUtil.getAlphaNumParameter(request, "commune", "");		
		String lng = HttpUtil.getStringParameter(request, "longitude", "", ".*");
		String lat = HttpUtil.getStringParameter(request, "latitude", "", ".*");
		String lng_1 = HttpUtil.getStringParameter(request, "map[nw][long]", "", ".*");
		String lat_1 = HttpUtil.getStringParameter(request, "map[nw][lat]", "", ".*");
		String lng_2 = HttpUtil.getStringParameter(request, "map[se][long]", "", ".*");
		String lat_2 = HttpUtil.getStringParameter(request, "map[se][lat]", "", ".*");
		Boolean sectorisation = HttpUtil.getBooleanParameter(request, "sectorisation", false);
		
		if(sectorisation) {				
			String url = "";						
			if(Util.notEmpty(lng_1) && Util.notEmpty(lat_1) && Util.notEmpty(lng_2) && Util.notEmpty(lat_2)) {
				// Sectorisation par zone
				url = getChannel().getProperty(SECTORISATION_URL_RECTANGLE_PROP) + "?p_lat_1=" + lat_1 +"&p_lon_1=" + lng_1 +"&p_lat_2=" + lat_2 + "&p_lon_2=" + lng_2;
			}else if(Util.notEmpty(lng) && Util.notEmpty(lat)) {
				// Sectorisation par adresse
				url = getChannel().getProperty(SECTORISATION_URL_POINT_PROP) + "p_lat=" + lat + "&p_lon=" + lng;
			}else if(Util.notEmpty(commune)) {
				// Sectorisation par commune
				url = getChannel().getProperty(SECTORISATION_URL_COMMUNE_PROP) + "p_commune=" + commune;						
			}
			
			// Suppression des fiches lieu avec un identifiant solis non présent dans le retour du service rest		
			if(Util.notEmpty(url)) {
				LOGGER.debug("Apell du service de sectorisation : " + url);
				set.removeAll(getNotInSctorisationPublication(set, url));
			}
		}
		return set;
	}

	
	/**
	 * Retourne les publications qui ont une reférence mais qui ne sont pas dans la sectorisation
	 * Il s'agit donc d'une liste de publications a à exclure des résultats
	 * @param set
	 * @param url
	 * @return
	 */
	public List<Publication> getNotInSctorisationPublication(QueryResultSet set, String url) {	
		List<SectorResult> sectorResultSet = getSectorisation(url);			
		List<Publication> notInSectorisation = new ArrayList<>(); 
		if(sectorResultSet != null) {
			List<String> sectorResultMatriculeSet = sectorResultSet.stream().map(SectorResult::getUniqueId).collect(Collectors.toList());		
			for(Publication itPub : set) {
				String idRef = "";
				if(itPub instanceof FicheLieu) {
					FicheLieu itFiche = (FicheLieu) itPub;
					idRef = itFiche.getIdReferentiel();						
				}else if(itPub instanceof Canton) {
					Canton canton = (Canton) itPub;
					idRef = String.valueOf(canton.getCantonCode());							
				}else if(itPub instanceof City) {
					City city = (City) itPub;
					idRef = String.valueOf(city.getCityCode());
				}
				if(Util.notEmpty(idRef) && !sectorResultMatriculeSet.contains(idRef)){
					notInSectorisation.add(itPub);
				}
			}			
		}
		return notInSectorisation;
	}
	

	/**
	 * Retourne le résultat du service de sectorisation suivant l'url demandée
	 * @param urlString
	 * @return
	 */
	public List<SectorResult> getSectorisation(String urlString) {
		try {
			URL url = new URL(urlString);
			HttpURLConnection urlConnection = IOUtil.openConnection(url, true, true, "GET");
			urlConnection.setRequestProperty("Content-Type", "application/json; charset=utf8");
			urlConnection.setReadTimeout(TIMEOUT);
			urlConnection.setConnectTimeout(TIMEOUT);
			int codeRetour = urlConnection.getResponseCode();
			if (codeRetour == 200) {
				InputStream is = IOUtil.getInputStream(urlConnection);
				BufferedReader in = new BufferedReader(new InputStreamReader(is));
				String inputLine;
				StringBuffer response = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				ObjectMapper mapper = new ObjectMapper();
				// Retoune la liste de SectorResult trouvé par le service rest
				LOGGER.debug("réponse du service de sectorisation : " + response.toString());
				return Arrays.asList(mapper.readValue(response.toString(), SectorResult[].class));
			} else {
				LOGGER.warn("Erreur sur le code retour de la recherche par sectorisation " + codeRetour);
			}
		} catch (IOException e) {
			LOGGER.warn("Erreur sur l'appel de la recherche sur la sectorisation avec le référentiel externe", e);
		}
		return null;
	}


}
