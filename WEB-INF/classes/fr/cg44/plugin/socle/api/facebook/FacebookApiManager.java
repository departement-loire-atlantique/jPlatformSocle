package fr.cg44.plugin.socle.api.facebook;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.facebook.bean.FacebookReviewBean;

public class FacebookApiManager {
  
  private static final Logger LOGGER = Logger.getLogger(FacebookApiManager.class);
  
  public static JSONObject getJsonFromFacebookReview(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.url"));
    urlRequest.append(Util.isEmpty(placeId) ? Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.id") : placeId);
    urlRequest.append("/ratings");
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString(), Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.key"));
  }
  
  public static FacebookReviewBean getFacebookReviewBeanFromId(String placeId) {
    JSONObject jsonFacebookBean = getJsonFromFacebookReview(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonFacebookBean.toString(), FacebookReviewBean.class);
    } catch (Exception e) {
      LOGGER.warn("Error in getJsonFromFacebookReview : " + e.getMessage());
    }
    
    return new FacebookReviewBean();
  }
  
}