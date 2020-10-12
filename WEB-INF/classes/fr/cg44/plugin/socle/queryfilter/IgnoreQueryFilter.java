package fr.cg44.plugin.socle.queryfilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.Util;


/**
 * Filtre pour ignorer les contenus dans la catégorie "contenu non répertorié"
 */
public class IgnoreQueryFilter extends LuceneQueryFilter {

	
  @Override
  public QueryHandler doFilterQuery(QueryHandler qh, Map context, HttpServletRequest request) {	
    Channel channel = Channel.getChannel();
    if(Util.notEmpty(channel.getCurrentJcmsContext())) {
      Boolean isInFrontOffice = channel.getCurrentJcmsContext().isInFrontOffice();
      Category ignoreCat = channel.getCategory("$jcmsplugin.socle.recherche.nonrepertoriee.cat");
      if(isInFrontOffice && Util.notEmpty(ignoreCat)) {
        qh.setCidsOff(ignoreCat.getId());
      }
    }
    return qh;
  }
	
	
	@Override
	public QueryResultSet doFilterResult(QueryHandler qh, QueryResultSet set, Map context, HttpServletRequest request) {
		return set;
	}

}
