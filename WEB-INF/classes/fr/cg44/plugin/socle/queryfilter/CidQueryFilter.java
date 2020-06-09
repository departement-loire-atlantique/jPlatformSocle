package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;


/**
 * Filtre pour les catégories spécifiques
 */
public class CidQueryFilter extends LuceneQueryFilter {

	
  @Override
  public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	    
    if(Util.notEmpty(request.getParameter("cidTypeLieu"))) {
      qh.setCids(request.getParameter("cidTypeLieu"));
    }
    return qh;
  }
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
