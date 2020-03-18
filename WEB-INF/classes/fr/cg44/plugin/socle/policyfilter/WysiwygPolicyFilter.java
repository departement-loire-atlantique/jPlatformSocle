package fr.cg44.plugin.socle.policyfilter;

import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.policy.BasicWysiwygPolicyFilter;


public class WysiwygPolicyFilter extends BasicWysiwygPolicyFilter {

  private static final Logger LOGGER = Logger.getLogger(WysiwygPolicyFilter.class);
	
  
	@Override
	public String afterRendering(final String text, final Locale userLocale) {
		return checkExternalLinks(text, userLocale);
	}
	
	
	/**
	 * Modifie les liens externes pour qu'ils affichent la mention " - nouvelle fenêtre" dans l'attribut "title" si celui-ci n'est pas vide,
	 * et si un "target='_blank'" a été détecté.
	 */
	public String checkExternalLinks(String text, Locale userLocale) {

	  String suffixe = " "+JcmsUtil.glp(userLocale.getCountry(), "jcmsplugin.socle.accessibily.newTabLabel");		
	  Pattern patternTarget = Pattern.compile("<a(.*?) target=\"_blank\"(.*?)</a>");
	  Pattern patternTitle = Pattern.compile("<a(.*?)title=\"(.*?)\"(.*?)</a>");		
	  Matcher matcherTarget = patternTarget.matcher(text);

	  // récupération des liens contenants un target blank
	  while (matcherTarget.find()) {
	    // récupération des title
	    String url = matcherTarget.group(0);
	    Matcher matcherTitle = patternTitle.matcher(url);
	    // Si un titre et un target blank alors ajout d'un libellé pour l'ouverture dans un nouvelle fenetre
	    if (matcherTitle.find()) {		  
	      String title = matcherTitle.group(2);
	      if(!title.endsWith(suffixe)) {	
	        text = text.replaceFirst(Pattern.quote(url), url.replaceFirst(title, title + suffixe));
	        LOGGER.debug("Ajout libellé nouvelle fenetre sur le lien : " + url);
	      }			
	    }
	  }
	  return text;				
	}
 
}