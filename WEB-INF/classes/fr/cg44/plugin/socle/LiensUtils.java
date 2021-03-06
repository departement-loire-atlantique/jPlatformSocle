package fr.cg44.plugin.socle;

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

}
