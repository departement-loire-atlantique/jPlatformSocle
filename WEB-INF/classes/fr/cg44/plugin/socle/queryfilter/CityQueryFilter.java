package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.policyfilter.PublicationFacetedSearchCityEnginePolicyFilter;


/**
 * Filtre pour la facette commune.
 */
public class CityQueryFilter extends LuceneQueryFilter {

	
	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
		// Récupère la ou les communes en paramètre de recherche
		String[] citiesCodeSearchArray = request.getParameterValues("commune[value]");
		addCitySearch(qh, request, citiesCodeSearchArray);
		return qh;
	}
	
	
	/**
	 * Ajoute le filtre sur la commune
	 * Attention la query passe en syntaxe de recherche avancée
	 * @param qh
	 * @param cityData
	 */
	public void addCitySearch(QueryHandler qh, HttpServletRequest request, String... cityCode) {		
	  if(Util.notEmpty(cityCode)) {
	    // Passe la query en syntaxe avancée pour accepter les requêtes lucenes
	    qh.setMode(QueryHandler.TEXT_MODE_ADVANCED);	  
	    // Requête pour la recherche sur les communes (OR entre les communes)	
	    StringBuffer citySearchText = new StringBuffer();
	    for(String itCityCode : cityCode) {
	      if(Util.notEmpty(citySearchText.toString())) {
	        citySearchText.append(" OR ");
	      }
	      citySearchText.append(PublicationFacetedSearchCityEnginePolicyFilter.INDEX_FIELD_CITY + ":\"" + itCityCode + "\"");								
	    }
	    // Requêtes pour incrémenter la recherche des communes avec les précédants query des autres facettes						
	    addFacetQuery(qh, request, citySearchText.toString());
	  }
	}
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
