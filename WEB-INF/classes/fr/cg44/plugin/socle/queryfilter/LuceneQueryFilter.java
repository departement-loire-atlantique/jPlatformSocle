package fr.cg44.plugin.socle.queryfilter;

import static com.jalios.jcms.Channel.getChannel;

import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.QueryFilter;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.policyfilter.PublicationFacetedSearchCityEnginePolicyFilter;


/**
 * Classe mère pour les filtres
 */
public abstract class LuceneQueryFilter extends QueryFilter {

	
	public abstract QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request);
	
	
	public abstract QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request);
	
	
	/**
	 * Ne pas surcharger (Surcharger la méthode doFilterQuery)
	 */
	@Override
    public QueryHandler filterQueryHandler(QueryHandler qh, Map context) {
        HttpServletRequest request = Util.notEmpty(getChannel().getCurrentServletRequest()) ? getChannel().getCurrentServletRequest() : qh.getRequest() ;   
        if(Util.isEmpty(request) || Util.notEmpty(qh.getAttribute("localisation"))) {
            return qh;
        }            
        return doFilterQuery(qh, context, request);
    }
    
       
    /**
	 * Ne pas surcharger (Surcharger la méthode doFilterQuery)
	 */
    @Override
    public QueryResultSet filterResultSet(QueryHandler qh, QueryResultSet set, Map context) {
        HttpServletRequest request = Util.notEmpty(getChannel().getCurrentServletRequest()) ? getChannel().getCurrentServletRequest() : qh.getRequest() ;   
        if(Util.isEmpty(request)) {
            return set;
        }  
    	return doFilterResult(qh, set, context, request);   	
    }
    
       
    /**
     * Ajoute la requete lucene à la query en intersection (AND) ou en union (OR) suivant le paramètre de requete 'facetOperator'
     * @param qh
     * @param request
     * @return
     */
    public QueryHandler addFacetQuery(QueryHandler qh, HttpServletRequest request, String query) {
    	// Opérateur de la requete entre les facettes
    	boolean isfacetOrOperator = HttpUtil.getBooleanParameter(request, "facetOperatorUnion", false);
    	String operator = isfacetOrOperator ? " OR " : " AND ";
    	// Requêtes pour incrémenter la recherche des communes avec les précédants query des autres facettes	
    	String prevSearchText = "";
    	if(Util.notEmpty(qh.getText())) {
    		prevSearchText = qh.getText() + operator;
    	}
    	// La nouvelle requêtes est settée dans la query
    	qh.setText(prevSearchText + "(" + query +")");	  
    	return qh;
    }
    
      
    /**
     * Ajoute le filtre sur la commune
     * Attention la query passe en syntaxe de recherche avancée
     * @param qh
     * @param request
     * @param cityCode
     */
    public void addCitySearch(QueryHandler qh, HttpServletRequest request, String... cityCode) {    
      if(Util.notEmpty(cityCode) && !Arrays.stream(cityCode).anyMatch("allCity"::equalsIgnoreCase)) {
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
    
    
}
