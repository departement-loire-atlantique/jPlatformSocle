package fr.cg44.plugin.socle;

import static com.jalios.jcms.Channel.getChannel;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeSet;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.DataSelector;
import com.jalios.jcms.JcmsUtil;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.QueryResultSet;
import com.jalios.jcms.handler.QueryHandler;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;

public final class SocleUtils {
	private static Channel channel = Channel.getChannel();
	private static final Logger LOGGER = Logger.getLogger(SocleUtils.class);
	
	// La catégorie technique qui désigne qu'un contenu est mis en avant si celui-ci y est catégorisé.
	private static final String MISE_EN_AVANT_CAT_PROP = "$id.plugin.socle.page-principale.cat";


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
	 * balise "object"
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
	
	/**
	 * Permet de récupérer le contenu principal d'une catégorie si celle-ci existe
	 * @param currentCat la catégorie courante
	 * @return La publication principale de la catégorie, sinon NULL
	 */
	public static Publication getContenuPrincipal(Category currentCat) {
		if(currentCat != null && getChannel().getCategory(MISE_EN_AVANT_CAT_PROP) != null) {
			Member loggedMember = channel.getCurrentLoggedMember();		
			QueryHandler qh = new QueryHandler();
			qh.setCids(getChannel().getProperty(MISE_EN_AVANT_CAT_PROP), currentCat.getId());
			qh.setLoggedMember(loggedMember);
			qh.setExactCat(true);
			QueryResultSet result = qh.getResultSet();
			Publication contenuPrincipal = Util.getFirst(result);		
			return contenuPrincipal;
		}	
		
		return null;
	}

	/**
	 * Retire tout ce qui n'est pas décimal de la chaine de caractère
	 * Exemple 02 40-44-85 12 devient  0240448512 ou 44 000 devient 40000
	 * @param s
	 * @return
	 */
	public static String cleanNumber(String s) {
		return s.replaceAll("\\D", "");
	}

	/**
	 * Retire tout ce qui n'est pas décimal des chaines de caractère du tableau
	 * Voir cleanNumber(String s) appliqué à chaque élément du tableau
	 * @param s
	 * @return
	 */
	public static String[] cleanNumber(String[] s) {
		String[] result = new String[0];
		if(Util.notEmpty(s)) {
			result = Arrays.stream(s).map(elt -> cleanNumber(elt)).toArray(String[]::new);
		}
		return result;
	}
	
	/**
	 * Retourne un String formaté à partir d'une date
	 * @param format
	 * @param date
	 * @return
	 */
	public static String formatDate(String format, Date date) {
		if (Util.isEmpty(date)) return "";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	/**
     * G�n�re un string � partir du contenu d'un InputStream
     * @param is
     * @return
     */
    public static String convertStreamToString(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line = null;
        
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
        return sb.toString();
    }
	
	/**
	 * 
	 * @param params
	 * @return
	 */
	public static String buildGetParams(Map<String, Object> params) {
	    if (Util.isEmpty(params)) return "";
	    
	    StringBuilder urlParams = new StringBuilder();
	    
	    urlParams.append("?");
	    
	    for (Iterator<String> iter = params.keySet().iterator(); iter.hasNext();) {
	        String key = iter.next();
	        String value = params.get(key).toString();
	        urlParams.append(key + "=" + value);
	        if (iter.hasNext()) urlParams.append("&");
	    }
	    
	    return urlParams.toString();
	}

}
