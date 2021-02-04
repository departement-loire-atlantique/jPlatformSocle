package fr.cg44.plugin.socle.api.tripadvisor;

import org.apache.log4j.Logger;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.tripadvisor.bean.TripadvisorPlaceBean;

public class TripadvisorApiManager {
  
  private static final Logger LOGGER = Logger.getLogger(TripadvisorApiManager.class);
  
  public static JSONObject getJsonFromTripadvisorPlace(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.url"));
    urlRequest.append(Util.isEmpty(placeId) ? Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.id") : placeId);
    urlRequest.append("/?key=");
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.key"));
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString());
  }
  
  public static TripadvisorPlaceBean getTripAdvisorPlaceBeanFromId(String placeId) {
    JSONObject jsonTripAdvisorBean = getJsonFromTripadvisorPlace(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonTripAdvisorBean.toString(), TripadvisorPlaceBean.class);
    }  catch (Exception e) {
      LOGGER.warn("Error in getJsonFromTripadvisorPlace : " + e.getMessage());
    }
    
    return new TripadvisorPlaceBean();
  }
  
}