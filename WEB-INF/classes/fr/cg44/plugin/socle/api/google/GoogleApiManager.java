package fr.cg44.plugin.socle.api.google;

import java.io.IOException;

import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.google.bean.GooglePlaceBean;

public class GoogleApiManager {
  
  public static JSONObject getJsonFromGooglePlace(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.url"));
    urlRequest.append("key=" + Channel.getChannel().getProperty("jcmsplugin.socle.api.places.google.key"));
    urlRequest.append("&");
    urlRequest.append("place_id=" + placeId);
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString());
  }
  
  public static GooglePlaceBean getGooglePlaceBeanFromId(String placeId) {
    JSONObject jsonGoogleBean = getJsonFromGooglePlace(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonGoogleBean.toString(), GooglePlaceBean.class);
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
    
    return new GooglePlaceBean();
  }
  
}