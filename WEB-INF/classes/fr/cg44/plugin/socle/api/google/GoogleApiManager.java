package fr.cg44.plugin.socle.api.google;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;

public class GoogleApiManager {
  
  private static final Logger LOGGER = Logger.getLogger(GoogleApiManager.class);
  
  public static JSONObject getJsonFromGooglePlace(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.url"));
    urlRequest.append("?key=" + Channel.getChannel().getProperty(""));
    urlRequest.append("&");
    urlRequest.append("place_id=" + (Util.isEmpty(placeId) ? Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.id") : placeId));
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString());
  }
  
  public static GooglePlaceBean getGooglePlaceBeanFromId(String placeId) {
    JSONObject jsonGoogleBean = getJsonFromGooglePlace(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonGoogleBean.toString(), GooglePlaceBean.class);
    }  catch (Exception e) {
      LOGGER.warn("Error in getJsonFromGooglePlace : " + e.getMessage());
    }
    
    return new GooglePlaceBean();
  }
  
}