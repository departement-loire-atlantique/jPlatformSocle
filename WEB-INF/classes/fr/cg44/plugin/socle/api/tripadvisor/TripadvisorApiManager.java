package fr.cg44.plugin.socle.api.tripadvisor;

import java.io.IOException;

import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;
import fr.cg44.plugin.socle.api.tripadvisor.bean.TripadvisorPlaceBean;

public class TripadvisorApiManager {
  
  public static JSONObject getJsonFromTripadvisorPlace(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.url"));
    urlRequest.append(placeId);
    urlRequest.append("/?key=");
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.tripadvisor.key"));
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString());
  }
  
  public static TripadvisorPlaceBean getTripAdvisorPlaceBeanFromId(String placeId) {
    JSONObject jsonTripAdvisorBean = getJsonFromTripadvisorPlace(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonTripAdvisorBean.toString(), TripadvisorPlaceBean.class);
    } catch (JsonParseException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (JsonMappingException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    
    return new TripadvisorPlaceBean();
  }
  
}