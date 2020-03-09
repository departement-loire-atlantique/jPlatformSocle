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
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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

	private static String SECTORISATION_URL_COMMUNE = "https://rec-oreco.loire-atlantique.fr/entites/V1/rpc/get_entites_commune?";
	private static String SECTORISATION_URL_POINT = "https://rec-oreco.loire-atlantique.fr/entites/V1/rpc/get_entites_point?";
	private static String SECTORISATION_URL_RECTANGLE = "https://rec-oreco.loire-atlantique.fr/entites/V1/rpc/get_entites_rectangle?";
	
	private static int TIMEOUT = Integer.parseInt(getChannel().getProperty("jcmsplugin.socle.rest.timeout", "2000"));


	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {
		return qh;
	}


	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {			
		String commune = HttpUtil.getAlphaNumParameter(request, "commune", "");
		String lng = HttpUtil.getAlphaNumParameter(request, "long", "");
		String lat = HttpUtil.getAlphaNumParameter(request, "lat", "");
		String lng_1 = HttpUtil.getAlphaNumParameter(request, "long_1", "");
		String lat_1 = HttpUtil.getAlphaNumParameter(request, "lat_1", "");
		String lng_2 = HttpUtil.getAlphaNumParameter(request, "long_2", "");
		String lat_2 = HttpUtil.getAlphaNumParameter(request, "lat_2", "");
		String sectorisation = HttpUtil.getAlphaNumParameter(request, "sectorisation", "");
		
		if(Util.notEmpty(sectorisation)) {
			Set<Publication> removeSolis = new HashSet<>();
			List<String> sectorResultMatriculeSet = new ArrayList<>();			
			String url = "";
						
			if(Util.notEmpty(lng_1) && Util.notEmpty(lat_1) && Util.notEmpty(lng_2) && Util.notEmpty(lat_2)) {
				// Sectorisation par zone
				url = SECTORISATION_URL_RECTANGLE;
			}else if(Util.notEmpty(lng) && Util.notEmpty(lat)) {
				// Sectorisation par adresse
				url = SECTORISATION_URL_POINT + "p_lat=" + lat + "&p_lon" + lng;
			}else if(Util.notEmpty(commune)) {
				// Sectorisation par commune
				url = SECTORISATION_URL_COMMUNE + "p_commune=" + commune;						
			}
			
			// Suppression des fiches lieu avec un identifiant solis non présent dans le retour du service rest		
			if(Util.notEmpty(url)) {
				sectorResultMatriculeSet = getSectorisation(url).stream().map(SectorResult::getUniqueId).collect(Collectors.toList());				
				if(sectorResultMatriculeSet != null) {
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
							removeSolis.add(itPub);
						}
					}
					set.removeAll(removeSolis);
				}
			}
		}		
		return set;
	}


	/**
	 * Retourne le résultat du service de sectorisation
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
				List<SectorResult> sectorResult = Arrays.asList(mapper.readValue(response.toString(), SectorResult[].class));
				return sectorResult;
			}
		} catch (IOException e) {
			LOGGER.warn("Erreur sur l'appel de la recherche sur la sectorisation avec le référentiel externe", e);
		}
		return null;
	}


}
