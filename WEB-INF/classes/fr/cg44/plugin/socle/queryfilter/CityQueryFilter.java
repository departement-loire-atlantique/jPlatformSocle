package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;


/**
 * Filtre pour la facette commune.
 */
public class CityQueryFilter extends LuceneQueryFilter {

	
	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
		// Récupère la ou les communes en paramètre de recherche
		String[] citiesCodeSearchArray = request.getParameterValues("commune");
		addCitySearch(qh, request, citiesCodeSearchArray);
		return qh;
	}
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
