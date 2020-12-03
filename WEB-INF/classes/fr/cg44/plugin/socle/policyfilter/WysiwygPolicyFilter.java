package fr.cg44.plugin.socle.policyfilter;

import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.policy.BasicWysiwygPolicyFilter;
import com.jalios.util.HtmlUtil;


public class WysiwygPolicyFilter extends BasicWysiwygPolicyFilter {

  private static final Logger LOGGER = Logger.getLogger(WysiwygPolicyFilter.class);
	
  
	@Override
	public String afterRendering(final String text, final Locale userLocale) {
		return generateNewRenderedWysiwyg(text, userLocale);
	}
	
	/**
	 * Modifie le WYSIWYG de diverses façons avant de passer au rendu
	 * @param text
	 * @param userLocale
	 * @return
	 */
	private String generateNewRenderedWysiwyg(String text, Locale userLocale) {
	  String formattedText = checkExternalLinks(text, userLocale);
	  formattedText = removeParagraphsAroundLinks(formattedText);
	  formattedText = removeEmptyParagraphs(formattedText);
	  formattedText = removeDoubleSpaces(formattedText);
	  formattedText = deleteEmptyTitle(formattedText);
	  formattedText = deleteEmptyAriaLabelse(formattedText);
	  formattedText = removeDoubleBr(formattedText);
	  formattedText = removeUselessSpacesLink(formattedText);
	  return formattedText;
	}
	
	/**
	 * Retire les balises <p> qui ne contiennent qu'une balise <a>
	 * @param text
	 * @return
	 */
	private String removeParagraphsAroundLinks(String text) {
    return text.replaceAll("<p><a", "<a").replaceAll("</a></p>", "</a>");
  }
	
	/**
	 * Retire les balises <p> vides
	 * @param text
	 * @return
	 */
	private String removeEmptyParagraphs(String text) {
	  String txtClone = text;
	  txtClone = txtClone.replaceAll("<p>&#xa0;</p>", "");
	  txtClone = txtClone.replaceAll("<p></p>", "");
	  txtClone = txtClone.replaceAll("<p>&nbsp;</p>", "");
	  txtClone = txtClone.replaceAll("<p> </p>", "");
	  return txtClone;
	}
	
	/**
	 * Retire tous les doubles &nbsp; jusqu'à ce qu'il n'y en ait plus
	 * @param text
	 * @return
	 */
	private String removeDoubleSpaces(String text) {
	  String doubleSpace = "&nbsp;&nbsp;";
	  String doubleSpaceBis = "&#xa0;&#xa0;";
	  String txtClone = text;
	  while (txtClone.indexOf(doubleSpace) >= 0) {
      txtClone = txtClone.replaceAll(doubleSpace, "&nbsp;");
    }
	  while (txtClone.indexOf(doubleSpaceBis) >= 0) {
      txtClone = txtClone.replaceAll(doubleSpaceBis, "&#xa0;");
    }
	  return txtClone;
	}
	
	/**
	 * Retire les attributs title vides
	 * @param text
	 * @return
	 */
	private String deleteEmptyTitle(String text) {
	  return text.replaceAll("title=\"\"", "");
	}
	
	/**
   * Retire les attributs aria-label vides
   * @param text
   * @return
   */
  private String deleteEmptyAriaLabelse(String text) {
    return text.replaceAll("aria-label=\"\"", "");
  }
  
  /**
   * Retire tous les doubles <br> jusqu'à ce qu'il n'y en ait plus
   * @param text
   * @return
   */
  private String removeDoubleBr(String text) {
    String doubleBr = "<br><br>";
    String txtClone = text;
    while (txtClone.indexOf(doubleBr) >= 0) {
      txtClone = txtClone.replaceAll(doubleBr, "<br>");
    }
    return txtClone;
  }
  
  /**
   * Retire les espaces en trop au début et à la fin des tags <a>
   * @param text
   * @return
   */
  private String removeUselessSpacesLink(String text) {
    String txtClone = text.replaceAll(" *(?=(<\\/a>))", "</a>").replaceAll("(&nbsp;)*(?=(<\\/a>))", "</a>").replaceAll("(&#xa0;)*(?=(<\\/a>))", "</a>"); // espaces à la fin
    txtClone = text.replaceAll("(?<=(<a [^>]+>)) *", "").replaceAll("(?<=(<a [^>]+>))(&nbsp;)*", "").replaceAll("(?<=(<a [^>]+>))(&#xa0;)*", ""); // espaces au début
    return txtClone;
  }

  /**
	 * Modifie les liens externes pour qu'ils affichent la mention " - nouvelle fenêtre" dans l'attribut "title" si celui-ci n'est pas vide,
	 * et si un "target='_blank'" a été détecté.
	 */
	public String checkExternalLinks(String text, Locale userLocale) {

	  String suffixe = " "+JcmsUtil.glp(userLocale.getCountry(), "jcmsplugin.socle.accessibily.newTabLabel");		
	  Pattern patternTarget = Pattern.compile("<a(.*?) target=\"_blank\"(.*?)>(.*?)</a>");
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
	    }else {
	      // Si pas de titre, alors on le génère avec le texte du lien, en supprimant les éventuelles balises HTML.	      
	      String texteDuLien = HtmlUtil.html2text(matcherTarget.group(3));
        String newUrl = url.replaceFirst("blank\"", "blank\"" + " title=\"" +  HttpUtil.encodeForHTMLAttribute(texteDuLien + suffixe) + "\"");
        text = text.replaceFirst(Pattern.quote(url), newUrl);       
	    }
	  }
	  return text;				
	}
 
}