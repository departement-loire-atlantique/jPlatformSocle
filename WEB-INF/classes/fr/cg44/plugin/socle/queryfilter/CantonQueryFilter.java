package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.policyfilter.PublicationFacetedSearchCantonEnginePolicyFilter;


/**
 * Filtre pour la facette canton.
 */
public class CantonQueryFilter extends LuceneQueryFilter {

	
	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
		// Récupère la ou les cantons en paramètre de recherche
		String[] citiesCodeSearchArray = request.getParameterValues("canton");
		addCantonSearch(qh, request, citiesCodeSearchArray);
		return qh;
	}
	
		
	/**
	 * Ajoute le filtre sur la canton
	 * Attention la query passe en syntaxe de recherche avancée
	 * @param qh
	 * @param cantonCode
	 */
	public void addCantonSearch(QueryHandler qh, HttpServletRequest request, String... cantonCode) {		
		if(Util.notEmpty(cantonCode)) {
			// Passe la query en syntaxe avancée pour accepter les requêtes lucenes
			qh.setMode("advanced");	  
			// Requête pour la recherche sur les cantosn (OR entre les cantons)	
			String cantonSearchText = "";
			for(String itCantonCode : cantonCode) {
				if(Util.notEmpty(cantonSearchText)) {
					cantonSearchText += " OR ";
				}
				cantonSearchText += PublicationFacetedSearchCantonEnginePolicyFilter.INDEX_FIELD_CANTON + ":\"" + itCantonCode + "\"";								
			}
			// Requêtes pour incrémenter la recherche des canton avec les précédants query des autres facettes						
	    	addFacetQuery(qh, request, cantonSearchText);
		}
	}
	
		
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
