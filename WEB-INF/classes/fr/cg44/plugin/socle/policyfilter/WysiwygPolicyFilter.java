package fr.cg44.plugin.socle.policyfilter;

import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.BodyContent;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Publication;
import com.jalios.jcms.context.JcmsJspContext;
import com.jalios.jcms.policy.BasicWysiwygPolicyFilter;
import com.jalios.jcms.portlet.PortalManager;
import com.jalios.jcms.taglib.IncludeTag;
import com.jalios.util.Util;

public class WysiwygPolicyFilter extends BasicWysiwygPolicyFilter {

  private static final Logger LOGGER = Logger.getLogger(WysiwygPolicyFilter.class);
  private static final String PREFIX_TAG_NAME = "<div";

	/**
	 * Modifie les liens externes pour qu'ils affichent la mention " - nouvelle fenêtre" dans l'attribut "title",
	 * si un "target='_blank'" a été détecté.
	 */
	@Override
	public String afterRendering(final String text, final Locale userLocale) {

		String result = text;
		String prefix = JcmsUtil.getDisplayUrl();
		String userLang = Channel.getChannel().getCurrentJcmsContext().getUserLang();
		String suffixe = " "+JcmsUtil.glp(userLang, "jcmsplugin.socle.accessibily.newTabLabel");
		Pattern patternTarget = Pattern.compile("<a(.*?) target=\"_blank\"(.*?)</a>");
		Pattern patternTitle = Pattern.compile("<a(.*?)title=\"(.*?)\"(.*?)</a>");
		Matcher matcherTarget = patternTarget.matcher(result);

		String url = "";
		String title = "";
		String titleOK = "";
		
		// récupération des liens contenant un target blank
		while (matcherTarget.find()) {
			url = matcherTarget.group(0);
			LOGGER.warn("URL : "+url);
			
			Matcher matcherTitle = patternTitle.matcher(matcherTarget.group(0));
			// récupération des title
			while (matcherTitle.find()) {
				title = matcherTitle.group(2);
				LOGGER.warn("TITLE : "+title );
			}
			
			if (title.endsWith(suffixe)) {
				continue;
			}
			
			// TODO : si pas de title trouvé, alors le générer
			
			titleOK=title+suffixe;
			LOGGER.warn("TITLE corrigé : "+titleOK);
			url = url.replaceFirst(title, titleOK);
			
			// Intégration dans le wysiwyg
			String before = result.substring(0, matcherTarget.start());
			String after = result.substring(matcherTarget.end(), result.length());

			result = before + url + after;
			matcherTarget = patternTarget.matcher(result);

			

		}
		return result;
	}

  
  
}