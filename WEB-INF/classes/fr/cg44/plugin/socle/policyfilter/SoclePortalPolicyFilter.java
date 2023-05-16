package fr.cg44.plugin.socle.policyfilter;

import org.apache.log4j.Logger;

import static com.jalios.jcms.Channel.getChannel;

import java.util.Locale;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Publication;
import com.jalios.jcms.context.JcmsContext;
import com.jalios.jcms.plugin.Plugin;
import com.jalios.jcms.policy.BasicPortalPolicyFilter;
import com.jalios.jcms.portlet.PortalManager;
import com.jalios.util.ServletUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleConstants;
import fr.cg44.plugin.socle.SocleUtils;
import generated.ContenuRedirection;


public class SoclePortalPolicyFilter extends BasicPortalPolicyFilter {

	private static final Logger logger = Logger.getLogger(SoclePortalPolicyFilter.class);
	
	@Override
	public boolean init(Plugin plugin){
		return true;
	}


	/** 
	 * Pour une catégorie donnée, renvoie vers la publication si celle-ci est mise en avant.
	 * Selection le portal d'affichage pour les full display des contenus 
	 **/
	@Override
	public void filterDisplayContext(PortalManager.DisplayContextParameters dcp) {

	  
	  HttpServletRequest request = getChannel().getCurrentServletRequest();
	  HttpServletResponse response = getChannel().getCurrentServletResponse();   
	  Locale userLocale = getChannel().getCurrentUserLocale();  

	  JcmsContext ctxt = getChannel().getCurrentJcmsContext();
	  
	  // AS-196 Permet de cacher le menu d'action d'une publication si l'utilsateur n'a pas la topbar 
    if(ctxt.isLogged() && !ctxt.getLoggedMember().belongsToGroup(getChannel().getGroup(SocleConstants.VISIBLE_TOPBAR_GROUP_PROP))) {
      Channel.getChannel().getCurrentServletRequest().setAttribute("jcms.publication.actions.hide", true);
    }  

	  // Redirection d'un contenu vers un autre contenu
	  // Géré par le contenu : Contenu redirection
	  Set<ContenuRedirection> redirectionSet = Channel.getChannel().getAllPublicationSet(ContenuRedirection.class, Channel.getChannel().getDefaultAdmin() , true);
	  if(Util.notEmpty(redirectionSet)) {
	    for(ContenuRedirection itRedirect : redirectionSet) {
	      if(dcp.id.equalsIgnoreCase(itRedirect.getIdDeLaPublicationSource())) {
	        Publication redirectPub = itRedirect.getPublicationCible();
	        response.setStatus(Integer.parseInt(itRedirect.getTypeDeRedirection()));
	        response.setHeader("Location", ServletUtil.toAbsoluteUrl(request, redirectPub.getDisplayUrl(userLocale)));
	        return;
	      }
	    }
	  }

	  
		// Redirection pour les catégorie avec un contenu "mis en avant" (Contenu appartenant à la catégorie "mis en avant")
		Category currentCat = getChannel().getCategory(dcp.id);
		Publication redirectPub = SocleUtils.getContenuPrincipal(currentCat);
	
		if(Util.notEmpty(redirectPub)) {
			logger.debug("Publication affichée pour la catégorie " + currentCat.getId() + " : " + redirectPub.getId());																		
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
			response.setHeader("Location", ServletUtil.toAbsoluteUrl(request, redirectPub.getDisplayUrl(userLocale)));				
		}
		
	}

	
}
