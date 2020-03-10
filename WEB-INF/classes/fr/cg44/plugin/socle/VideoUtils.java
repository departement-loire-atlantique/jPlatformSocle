package fr.cg44.plugin.socle;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.jalios.jcms.Channel;
import com.jalios.util.URLUtils;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.policyfilter.WysiwygPolicyFilter;

public final class VideoUtils {
	private static Channel channel = Channel.getChannel();
	private static final Logger LOGGER = Logger.getLogger(VideoUtils.class);

	private VideoUtils() {
		throw new IllegalStateException("Utility class");
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
	
}
