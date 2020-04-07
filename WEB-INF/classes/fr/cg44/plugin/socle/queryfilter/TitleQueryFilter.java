package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.jcms.search.LucenePublicationSearchEngine;
import com.jalios.util.Util;


/**
 * Filtre pour la facette titre.
 */
public class TitleQueryFilter extends LuceneQueryFilter {

	
	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
		// Récupère le ou les cantons en paramètre de recherche
		String titre = request.getParameter("titre");
		addTitleSearch(qh, request, titre);
		return qh;
	}
	
		
	/**
	 * Ajoute le filtre sur le titre
	 * Attention la query passe en syntaxe de recherche avancée
	 * @param qh
	 * @param request
	 * @param titre
	 */
	public void addTitleSearch(QueryHandler qh, HttpServletRequest request, String titre) {		
	  if(Util.notEmpty(titre)) {
	    // Passe la query en syntaxe avancée pour accepter les requêtes lucenes
	    qh.setMode(QueryHandler.TEXT_MODE_ADVANCED);	 			
	    String searchText = LucenePublicationSearchEngine.TITLE_FIELD + ":\"" + titre + "\"";
	    // Requêtes pour incrémenter la recherche par titre avec les précédants query des autres facettes						
	    addFacetQuery(qh, request, searchText);
	  }						
	}
	
		
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
