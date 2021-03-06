package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;


/**
 * Filtre pour la facette commune.
 */
public class CityQueryFilter extends LuceneQueryFilter {

	
	@Override
	public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
		// Récupère la ou les communes en paramètre de recherche
	  // Ignore la recherche par commune si recherche par delegation (la recherche sur delegation recherche sur une liste de communes)
	  // Ignore la recherche par commune si recherche sur sectorisation (un résultat par secteur peut se trouver dans la commune limitrophe et pas seulement sur la commune recherché)
	  Boolean isSectorisation = HttpUtil.getBooleanParameter(request, "sectorisation", false);
	  if(Util.notEmpty(request.getAttribute("communeHorsSectorisation")) || (!isSectorisation && Util.isEmpty(request.getParameter("delegationSearch")))) {
	    String[] citiesCodeSearchArray = request.getParameterValues("commune");
		  addCitySearch(qh, request, citiesCodeSearchArray);	
	  }
		return qh;
	}
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
