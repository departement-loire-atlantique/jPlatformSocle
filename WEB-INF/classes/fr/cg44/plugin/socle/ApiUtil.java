package fr.cg44.plugin.socle;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.jcms.HttpUtil;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.infolocale.RequestManager;

public class ApiUtil {
  
  private static final Logger LOGGER = Logger.getLogger(RequestManager.class);
  
  /**
   * Créée une CloseableHttpResponse avec des paramètres dans le cadre d'une requête POST
   * @param url
   * @param params
   * @param useToken
   * @return
   */
  public static CloseableHttpResponse createPostConnection(String url, Map<String, Object> params, String authToken) {
      
      int timeout = Channel.getChannel().getIntegerProperty("jcmsplugin.socle.connection.timeout", 5);
      RequestConfig config = RequestConfig.custom()
        .setConnectTimeout(timeout * 1000)
        .setConnectionRequestTimeout(timeout * 1000)
        .setSocketTimeout(timeout * 1000).build();
    
      CloseableHttpClient httpClient =  HttpClientBuilder.create().setDefaultRequestConfig(config).build();
      
      HttpPost post = new HttpPost(url);
      
      if (Util.notEmpty(params)) {
          List<BasicNameValuePair> urlParameters = new ArrayList<>();
          for (Entry<String, Object> entry : params.entrySet()) {
              urlParameters.add(new BasicNameValuePair(entry.getKey(), entry.getValue().toString()));
          }
          
          try {
              post.setEntity(new UrlEncodedFormEntity(urlParameters));
          } catch (UnsupportedEncodingException e) {
              LOGGER.warn("Exception sur createPostConnection : " + e.getMessage());
          }
      }
      
      if (Util.notEmpty(authToken)) {
          post.setHeader("Authorization", "Bearer " + authToken);
      }
      
      CloseableHttpResponse response = null;
      try {
        response = httpClient.execute(post);
      } catch (IOException e) {
        LOGGER.warn("Exception sur createPostConnection -> " + url + " : " + e.getMessage());
      }
      
      return response;
  }
  
  public static CloseableHttpResponse createPostConnection(String url, Map<String, Object> params) {
    return createPostConnection(url, params, null); 
  }
  
  /**
   * Créée une CloseableHttpResponse avec des paramètres dans le cadre d'une requête GET
   */
  public static CloseableHttpResponse createGetConnection(String url, String authToken) {
         
      int timeout = Channel.getChannel().getIntegerProperty("jcmsplugin.socle.connection.timeout", 5);
      RequestConfig config = RequestConfig.custom()
        .setConnectTimeout(timeout * 1000)
        .setConnectionRequestTimeout(timeout * 1000)
        .setSocketTimeout(timeout * 1000).build();
       
    
      CloseableHttpClient httpClient =  HttpClientBuilder.create().setDefaultRequestConfig(config).build();

      HttpGet get = new HttpGet(url);
      
      if (Util.notEmpty(authToken)) {
        get.setHeader("Authorization", "Bearer " + authToken);
      }
      
      CloseableHttpResponse response = null;
      try {
          response = httpClient.execute(get);
      } catch (IOException e) {
          LOGGER.warn("Exception sur createGetConnection -> " + url + " : " + e.getMessage());
      }
      
      return response;
  }
  
  public static CloseableHttpResponse createGetConnection(String url) {
    return createGetConnection(url, null);
  }
  
  /**
   * Génère une requête GET vers une URL et récupère une réponse en format JSON
   * @param token
   * @param url
   * @return
   */
  public static JSONObject getJsonObjectFromApi(String url, String token) {

      JSONObject fluxData = new JSONObject();
      
      try {
        
        CloseableHttpResponse response = ApiUtil.createGetConnection(url, token);
        
        if (Util.isEmpty(response)) {
            LOGGER.warn("Method getJsonObjectFromApi => pas de réponse HTTP");
            return fluxData;
        }
        
        int status = response.getStatusLine().getStatusCode();
                    
        switch (status) {
            case 200:
                
                fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                
                break;
            case 404:
                LOGGER.warn("Erreur 404 -> URL " + url + " non trouvée.");
                break;
            default:
                LOGGER.warn("Erreur HTTP inconnue : " + response.getStatusLine().getReasonPhrase());
                break;
        }
        
    } catch (Exception e) {
        LOGGER.warn("Exception sur getJsonObjectFromApi : " + e.getMessage());
    }
    
    return fluxData;
    
  }
  
  /**
   * Génère une requête GET vers une URL et récupère une réponse en format JSONArray
   * @param token
   * @param url
   * @return
   */
  public static JSONArray getJsonArrayFromApi(String url, String token) {

      JSONArray fluxData = new JSONArray();
      
      try {
        
        CloseableHttpResponse response = ApiUtil.createGetConnection(url, token);
        
        if (Util.isEmpty(response)) {
            LOGGER.warn("Method getJsonArrayFromApi => pas de réponse HTTP");
            return fluxData;
        }
        
        int status = response.getStatusLine().getStatusCode();
                    
        switch (status) {
            case 200:
                
                fluxData = new JSONArray(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                
                break;
            case 404:
                LOGGER.warn("Erreur 404 -> URL " + url + " non trouvée.");
                break;
            default:
                LOGGER.warn("Erreur HTTP inconnue : " + response.getStatusLine().getReasonPhrase());
                break;
        }
        
    } catch (Exception e) {
        LOGGER.warn("Exception sur getJsonArrayFromApi : " + e.getMessage());
    }
    
    return fluxData;
    
  }
  
  public static JSONObject getJsonObjectFromApi(String url) {
    return getJsonObjectFromApi(url, null);
  }
  
  public static JSONArray getJsonArrayFromApi(String url) {
      return getJsonArrayFromApi(url, null);
  }
  
}