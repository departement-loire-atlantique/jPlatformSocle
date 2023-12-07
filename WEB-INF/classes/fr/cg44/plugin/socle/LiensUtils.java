package fr.cg44.plugin.socle;

import java.util.HashMap;
import java.util.LinkedHashMap;

import com.jalios.jcms.Channel;
import com.jalios.jcms.HttpUtil;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Publication;

public final class LiensUtils {
	private static Channel channel = Channel.getChannel();
	
	private LiensUtils() {
		throw new IllegalStateException("Utility class");
	}

	/**
	 * Création du lien de partage
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createLink(String socialNetwork, String urlPub, Publication pubCourante) {
		switch (socialNetwork.toLowerCase()) {
			case "facebook" :
				return createFacebookLink(urlPub);
			case "twitter" :
				return createTwitterLink(urlPub);
			case "pinterest" :
				return createPinterestLink(urlPub);
			case "linkedin" :
				return createLinkedinLink(urlPub);	    	  
			case "mail" :
				return createEmailLink(urlPub, pubCourante.getTitle());
			default:
        return null;
			}

	}

	/**
	 * Création du lien Facebook
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createFacebookLink(String url) {
		StringBuffer link = new StringBuffer("https://www.facebook.com/sharer/sharer.php?u=");
		link.append(HttpUtil.encodeForURL(url));
		return link.toString();
	}

	/**
	 * Création du lien Twitter
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createTwitterLink(String url) {
		StringBuffer link = new StringBuffer("https://twitter.com/intent/tweet?url=");
		link.append(HttpUtil.encodeForURL(url));
		link.append("&amp;tw_p=tweetbutton");
		link.append("&amp;via=");
		link.append(channel.getProperty("jcmsplugin.socle.socialnetwork.twitter.account"));

		return link.toString();
	}

	/**
	 * Création du lien Pinterest
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createPinterestLink(String url) {
		StringBuffer link = new StringBuffer("https://pinterest.com/pin/create/button/?url=");
		link.append(HttpUtil.encodeForURL(url));
		return link.toString();
	}

	/**
	 * Création du lien Linkedin
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createLinkedinLink(String url) {
		StringBuffer link = new StringBuffer("https://www.linkedin.com/shareArticle?mini=true&url=");
		link.append(HttpUtil.encodeForURL(url));
		return link.toString();
	}

	/**
	 * Création du lien Email
	 * 
	 * @param url L'url à partager
	 * @return le lien de partage
	 */
	public static String createEmailLink(String url, String titrePub) {
	  return JcmsUtil.glp(channel.getCurrentUserLang(), "jcmsplugin.socle.socialnetwork.share.mail.link", channel.getName(), HttpUtil.encodeForURL(titrePub), HttpUtil.encodeForURL(url));
	}
	
	/**
	 * @param isGPLA , sort les sites de grands patrimoines ( gpla ) ou tout les autres ?
	 * @return sites et applis du département de Loire-Atlantique
	 */
	public static HashMap<String, String[]> getLinkOtherSites(boolean isGPLA) {
	  HashMap<String, String[]> mapThemes = new LinkedHashMap<String, String[]>();
	  if(isGPLA) {
	    mapThemes.put("gpla", new String[] {"garenne-lemot", "chateau-clisson","chateau-chateaubriant", 
	        "folies-siffait", "eglise-vieux-bourg", "blanche-couronne", "archeo", "arcantique"});
	  } else {
	    mapThemes.put("citoyennete", new String[] {"institutionnel", "budget","participer"});
	    mapThemes.put("enfance-famille", new String[] {"parents", "assmat"});
	    mapThemes.put("handicap", new String[] {"handicap"});
	    mapThemes.put("education", new String[] {"stages3"});
	    mapThemes.put("sport", new String[] {"rando"});
	    mapThemes.put("environnement", new String[] {"grandlieu"});
	    mapThemes.put("culture", new String[] {"bdla", "archives", "dobree", "ressources-edu", "chateau-chateaubriant", "chateau-clisson", "garenne-lemot", "folies-siffait", "blanche-couronne", "eglise-vieux-bourg"});
	    mapThemes.put("deplacements", new String[] {"inforoutes", "pont-st-naz", "bacs"});
	    mapThemes.put("developpement-innovation", new String[] {"opendata", "numerique", "lad", "tourisme", "imagine-la"});
	    mapThemes.put("territoire", new String[] {"vuduciel", "observatoire","atlas"});
	  }
	  return mapThemes;
  }

}
