package fr.cg44.plugin.socle.queryfilter;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;

import com.jalios.io.IOUtil;
import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.bean.SectorResult;
import generated.City;
import generated.FicheLieu;


/**
 * Filtre pour la sectorisation.
 */
public class SectorisationQueryFilter extends LuceneQueryFilter {

	private static final Logger LOGGER = Logger.getLogger(SectorisationQueryFilter.class);

	private static int TIMEOUT = Integer.parseInt(getChannel().getProperty("jcmsplugin.socle.rest.timeout", "2000"));


	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {
		return qh;
	}


	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		City cityData = HttpUtil.getDataParameter(request, "commune", City.class);
		
		List<String> sectorResultId = getSectorisation().stream().map(SectorResult::getMatricule).collect(Collectors.toList());
		System.out.println(sectorResultId);
		// Suppression des fiches lieu avec un identifiant solis non présent dans le retour du service rest
		Set<Publication> removeSolis = new HashSet<Publication>();
		for(Publication itPub : set) {
			if(itPub instanceof FicheLieu) {
				FicheLieu itFiche = (FicheLieu) itPub;
				String idRef = itFiche.getIdReferentiel();
				if(Util.notEmpty(idRef) && !sectorResultId.contains(idRef)){
					//System.out.println("remove " + idRef);
					removeSolis.add(itPub);
				}
			}
		}
		set.removeAll(removeSolis);
		return set;
	}
	

	/**
	 * Retourne le résulatat du service de sectorisation
	 * @return
	 */
	public List<SectorResult> getSectorisation() {
		try {
			URL url = new URL("https://rec-oreco.loire-atlantique.fr/entites/V1/rpc/get_sectorisations_geojson?p_geojson=%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B-1.77286755433447%2C47.5803362635946%5D%2C%22crs%22%3A%7B%22type%22%3A%22name%22%2C%22properties%22%3A%7B%22name%22%3A%22EPSG%3A4326%22%7D%7D%7D&sectorisation=in.%28EDS,Canton,Commune%29&select=sectorisation%2Cmatricule%2Clibelle");
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
				//System.out.println(response.toString());
				ObjectMapper mapper = new ObjectMapper();
				List<SectorResult> sectorResult = Arrays.asList(mapper.readValue(response.toString(), SectorResult[].class));
				return sectorResult;
			}
		} catch (IOException e) {
			LOGGER.warn("Erreur sur l'appel de la recherche avec le référentiel externe", e);
		}
		return null;
	}

}
