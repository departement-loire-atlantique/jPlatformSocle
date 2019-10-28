package fr.cg44.plugin.socle;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	private static final Logger LOGGER = Logger.getLogger(SocleUtils.class);


	/**
	 * A partir d'une catégorie parent, retourne un TreeSet de ses enfants, trié et filtré en fonction des droits de l'utilisateur.
	 * 
	 * @param cat La catégorie parent pour laquelle on doit récupérer les enfants.
	 * @return Un TreeSet de catégories enfants, filtré et trié. Null si la catégorie n'existe pas.
	 */
	public static TreeSet<Category> getOrderedAuthorizedChildrenSet(Category cat) {
		Member loggedMember = channel.getCurrentLoggedMember();
		String userLang = channel.getCurrentJcmsContext().getUserLang();
		if(Util.notEmpty(cat)) {
			DataSelector authorizedCategoriesSelector = Category.getAuthorizedSelector(loggedMember);
			TreeSet<Category> childrenSet = new TreeSet<Category>(cat.getOrderComparator(userLang));
			childrenSet.addAll(cat.getChildrenSet());
			JcmsUtil.applyDataSelector(childrenSet, authorizedCategoriesSelector);
			return childrenSet;
		}
		return null;
		
	}
	
	/**
	 * Méthode qui retourne le nombre de seconde pour le timecode passé en paramètre
	 * @param timecode timecode au format hh:mm:ss
	 * @return le nombre de seconde
	 */
	public static int getSecondesByTimecode(String timecode){
		int retourSecondes = 0;
		if(Util.notEmpty(timecode)){
			String heureStr = "";
			String minuteStr = "";
			String secondeStr = "";

			heureStr = timecode.substring(0, 2);
			minuteStr = timecode.substring(3, 5);
			secondeStr = timecode.substring(6); 

			int heure = 0;
			int minute = 0;
			int seconde = 0;

			heure = Integer.parseInt(heureStr);
			heure = heure * 3600;

			minute = Integer.parseInt(minuteStr);
			minute = minute * 60;

			seconde = Integer.parseInt(secondeStr);

			retourSecondes = heure + minute + seconde;
		}

		return retourSecondes;
	}


	/**
	 * Transforme une URL Youtube du type :
	 * http://www.youtube.com/watch?v=6_I70KACh4o en :
	 * http://www.youtube.com/embed/6_I70KACh4o pour permettre l'utilisation de la
	 * balise <object>
	 * 
	 * @param url
	 *          L'URL Youtube
	 * @return Le lien http vers la vidéo
	 * @throws UnsupportedEncodingException 
	 * @throws NoFormatPossibleException
	 *           Impossible de formatter l'URL
	 */
	public static String buildYoutubeUrl(String url)  {
		String builtUrl = "https://www.youtube.com/embed/" + getYoutubeVideoId(url);
		
		String webappUrl = Channel.getChannel().getUrl();
		webappUrl = webappUrl.substring(0, webappUrl.length()-1);
		
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("enablejsapi", new String[] { "1" });
		map.put("frameborder", new String[] { "0" });
		map.put("html5", new String[] { "1" });
		map.put("origin", new String[] { webappUrl });
		map.put("rel", new String[] { "0" });

		builtUrl = URLUtils.buildUrl(builtUrl, map);

		return builtUrl;
	}

	/**
	 * Méthode récupérant l'identifiant Youtube d'une vidéo
	 * 
	 * @param url
	 *          L'URL Youtube
	 * @return L'identifiant de la vidéo
	 * @throws NoFormatPossibleException
	 *           Impossible de formatter l'URL
	 */
	public static String getYoutubeVideoId(String url) {
		String idVideo="";

		// Test nullité ? Pas possible en principe.
		if (url.isEmpty()) {
			String path = Channel.getChannel().getCurrentJcmsContext().getRequest().getRequestURI();
			LOGGER.warn("Could not determine the id of the Youtube video. Url : " + url + " (" + path + ")");
			return idVideo;
		}

		Map<String,String[]> urlParams = URLUtils.parseUrlQueryString(url);

		// On récupère la valeur du paramètre "v" (on prend le 1er s'il en existe plusieurs)
		if(urlParams.containsKey("v")){
			idVideo = urlParams.get("v")[0];
		}

		/*
		for (Map.Entry mapentry : urlParams.entrySet()) {
			String key = (String) mapentry.getKey();
			String[] values = (String[]) mapentry.getValue();
	           System.out.println("clé: "+key+ " | valeur: " + values[0]);
	        }
		 */

		return idVideo;
	}	  	

}
