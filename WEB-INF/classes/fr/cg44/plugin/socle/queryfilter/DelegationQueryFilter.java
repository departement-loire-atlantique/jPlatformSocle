package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.Channel;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import generated.City;
import generated.Delegation;


/**
 * Filtre pour la facette delegation.
 */
public class DelegationQueryFilter extends LuceneQueryFilter {

	
  @Override
  public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {
    if(Util.notEmpty(request.getParameter("delegationSearch"))) {
      String codeCommune = request.getParameter("commune");
      City commune = SocleUtils.getCommuneFromCode(codeCommune);
      // Récupère les communes de la delegation pour la recherche à facettes
      // Rechercher sur la delegation revient à recherche sur toutes les communes de cette délégation
      if(Util.notEmpty(commune)) {
        Delegation delegation = commune.getDelegation();
        if(Util.notEmpty(delegation)) {     
          addCitySearch(qh, request, delegation.getLinkIndexedDataSet(City.class, "delegation").stream().map(x -> String.valueOf(x.getCityCode())).toArray(String[]::new));
        }
      }
    }
    return qh;
  }
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
