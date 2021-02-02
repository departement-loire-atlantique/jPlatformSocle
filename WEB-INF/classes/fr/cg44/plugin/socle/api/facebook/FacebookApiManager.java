package fr.cg44.plugin.socle.api.facebook;

import java.io.IOException;

import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jalios.jcms.Channel;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.api.facebook.bean.FacebookReviewBean;

public class FacebookApiManager {
  
  public static JSONObject getJsonFromFacebookReview(String placeId) {
    StringBuilder urlRequest = new StringBuilder();
    urlRequest.append(Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.url"));
    urlRequest.append(placeId);
    urlRequest.append("/ratings");
    
    return ApiUtil.getJsonObjectFromApi(urlRequest.toString(), Channel.getChannel().getProperty("jcmsplugin.socle.api.places.facebook.key"));
  }
  
  public static FacebookReviewBean getFacebookReviewBeanFromId(String placeId) {
    JSONObject jsonFacebookBean = getJsonFromFacebookReview(placeId);

    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(jsonFacebookBean.toString(), FacebookReviewBean.class);
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
    
    return new FacebookReviewBean();
  }
  
}