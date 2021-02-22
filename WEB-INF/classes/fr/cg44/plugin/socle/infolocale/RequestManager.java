package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;

import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.ApiUtil;
import fr.cg44.plugin.socle.SocleUtils;
import fr.cg44.plugin.socle.infolocale.fluxdata.Authentification;
import fr.cg44.plugin.socle.infolocale.singleton.TokenManager;

/**
 * Classe permettant d'effectuer les différentes requêtes vers l'API Infolocale
 * @author lchoquet
 *
 */
public class RequestManager {
    
    private static final Logger LOGGER = Logger.getLogger(RequestManager.class);
    
    private static String pleaseCheckConf = ". Veuillez verifier la configuration.";
    
    private static String httpError = "Erreur code HTTP ";
    private static String methodFilterFluxDataError = "Method filterFluxData => code HTTP innatendu ";
    
    private static String methodGetSingleEventError = "Method getSingleEvent => code HTTP innatendu ";
    
    private static String methodGetFluxMetadataError = "Method getFluxMetadata => code HTTP innatendu ";
    
    private static String success = "success";
    private static String failureReason = "failure_reason";
    
    private static String initToken = "initToken";
    private static String refreshToken = "refresh_token";
    
    private static boolean tokensOk = false;
    
    private static int attempsToRefresh = 0;
    
    private RequestManager() {}
    
    /**
     * Envoie une requête pour s'authentifier à Infolocale et générer les tokens d'authentification
     */
    public static void initTokens() {
        sendTokenRequest("https://api.infolocale.fr/auth/signin", initToken);
    }
    
    /**
     * Regénère les tokens d'authentification. En cas de token invalide, procède à l'authentification
     */
    public static void regenerateTokens() {
        sendTokenRequest("https://api.infolocale.fr/auth/refresh-token", refreshToken);
    }
    
    private static void sendTokenRequest(String url, String type) {
        boolean invalidToken = false;
        
        TokenManager tokenManager = TokenManager.getInstance();
        
        Map<String, Object> params = new HashMap<>();
        Channel channel = Channel.getChannel();
        
        try {
            
            if (initToken.equals(type)) {
                String login = channel.getProperty("jcmsplugin.socle.infolocale.login");
                String password = channel.getProperty("jcmsplugin.socle.infolocale.password");
                
                params.put("login", login);
                params.put("password", password);
            } else if (refreshToken.equals(type)) {
                params.put(refreshToken, tokenManager.getRefreshToken());
            }
            
            CloseableHttpResponse response = ApiUtil.createPostConnection(url, params);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method " + type + " => pas de réponse HTTP" + pleaseCheckConf);
                return;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 200:
                    ObjectMapper mapper = new ObjectMapper();
                    
                    Authentification auth = mapper.readValue(response.getEntity().getContent(), Authentification.class);
                    
                    tokenManager.setAccessToken(auth.getAccess_token());
                    tokenManager.setRefreshToken(auth.getRefresh_token());
                    tokenManager.setUsername(auth.getUsername());
                    
                    LOGGER.debug("Tokens générés");
                    resetTokenRefreshCounter();
                    break;
                case 400:
                    LOGGER.warn(type + " : " + httpError + status + ". Token non valide.");
                    invalidToken = true;
                    break;
                case 401:
                    LOGGER.warn(type + " : " + httpError + status + ". Authentification échouée.");
                    break;
                default:
                    LOGGER.warn(type + " : " + httpError + status + pleaseCheckConf + response.getStatusLine().getReasonPhrase());
                    break;
            }
            
        } catch (IOException e) {
            LOGGER.warn("Exception sur " + type + " : " + e.getMessage());
        }
        
        // Si la requête consistait à refresh les tokens, en cas d'échec, demander une initialisation des tokens
        if (invalidToken && "refresh_token".equals(type)) {
            LOGGER.debug("Token invalide. Tentative de regénération de token via authentification...");
            initTokens();
        }
    }

    private static void resetTokenRefreshCounter() {
      attempsToRefresh = 0;
      tokensOk = true;
    }
    
    /**
     * Renvoie "false" si 3 essais ou plus ont été exécutés pour regénérer les tokens
     * @return
     */
    private static boolean iterateTokenRefreshCounter() {
      attempsToRefresh++;
      return attempsToRefresh >= 3;
    }

    /**
     * Extrait des données à partir d'un flux de l'API Infolocale en intégrant des paramètres de tri
     */
    public static JSONObject filterFluxData(String fluxId, Map<String, Object> params) {
        
        JSONObject fluxData = new JSONObject();
        
        boolean expiredToken = false;
        
        try {
            fluxData.put(success, false); // sera remplacé par "true" dans les cas de requête réussie
            
            CloseableHttpResponse response = ApiUtil.createPostConnection(Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.flux.url") + fluxId + "/data", params, TokenManager.getInstance().getAccessToken());
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method filterFluxData => pas de réponse HTTP" + pleaseCheckConf);
                return fluxData;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 401:
                    tokensOk = false;
                    while ((attempsToRefresh > 0 || !iterateTokenRefreshCounter()) && !tokensOk) {
                      regenerateTokens();
                    }
                    if (!tokensOk) {
                      LOGGER.warn(methodFilterFluxDataError + status + ". Token expiré.");
                      expiredToken = true;
                      fluxData.put(failureReason, "invalid_token");
                    } else {
                      return filterFluxData(fluxId, params);
                    }
                    break;
                case 400:
                    generateError400Logger(new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent())));
                    break;
                case 200:
                    
                    fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                    fluxData.put(success, true);
                    
                    break;
                case 404:
                    LOGGER.warn(methodFilterFluxDataError + status + ". Flux " + fluxId + " non trouvé.");
                    fluxData.put(failureReason, "wrong_flux");
                    break;
                default:
                    LOGGER.warn(methodFilterFluxDataError + status + pleaseCheckConf + response.getStatusLine().getReasonPhrase());
                    fluxData.put(failureReason, "unknown_error");
                    break;
            }
            
        } catch (Exception e) {
            LOGGER.warn("Exception sur extractFluxData : " + e.getMessage());
        }
        
        if (expiredToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token...");
            regenerateTokens();
        }
        
        return fluxData;
    }
    
    /**
     * Extrait des données à partir d'un flux de l'API Infolocale sans paramètre
     */
    public static JSONObject filterFluxData(String fluxId) {
        return filterFluxData(fluxId, null);
    }
    
    /**
     * Renvoie l'objet JSON associé à un unique événement selon un ID. L'objet renvoyé peut être vide
     * @param idEvent
     * @return
     */
    public static JSONObject getSingleEvent(String idEvent, String token) {
      
      String extractUrl = Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.extract.url") + idEvent;
      
      JSONObject fluxData = new JSONObject();
      
      boolean expiredToken = false;
      
      try {
          fluxData.put(success, false); // sera remplacé par "true" dans les cas de requête réussie
          
          CloseableHttpResponse response = ApiUtil.createGetConnection(extractUrl, token);
          
          if (Util.isEmpty(response)) {
              LOGGER.warn("Method extractFluxData => pas de réponse HTTP" + pleaseCheckConf);
              return fluxData;
          }
          
          int status = response.getStatusLine().getStatusCode();
                      
          switch (status) {
              case 401:
                  tokensOk = false;
                  while ((attempsToRefresh > 0 || !iterateTokenRefreshCounter()) && !tokensOk) {
                    regenerateTokens();
                  }
                  if (!tokensOk) {
                    LOGGER.warn(methodGetSingleEventError + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put(failureReason, "invalid_token");
                  } else {
                    return getSingleEvent(idEvent, TokenManager.getInstance().getAccessToken());
                  }
                  break;
              case 400:
                  generateError400Logger(new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent())));
                  break;
              case 200:
                  
                  fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                  fluxData.put(success, true);
                  
                  break;
              case 404:
                  LOGGER.warn(methodGetSingleEventError + status + ". Evenement " + idEvent + " non trouvé.");
                  fluxData.put(failureReason, "wrong_flux");
                  break;
              default:
                  LOGGER.warn(methodGetSingleEventError + status + pleaseCheckConf + response.getStatusLine().getReasonPhrase());
                  fluxData.put(failureReason, "unknown_error");
                  break;
          }
          
      } catch (Exception e) {
          LOGGER.warn("Exception sur extractFluxData : " + e.getMessage());
      }
      
      if (expiredToken) {
          LOGGER.debug("Token invalide. Tentative de regénération de token...");
          regenerateTokens();
      }
      
      return fluxData;
    }
    
    /**
     * Renvoie un simple logger en cas d'erreur 400 infolocale
     * @param jsonObject
     */
    private static void generateError400Logger(JSONObject jsonObject) {
      try {
        LOGGER.warn("Erreur 400 : " + jsonObject.getString("message"));
      } catch (JSONException e) {
        LOGGER.warn("Erreur 400 : l'API Infolocale ne peut pas traiter une requête.");
      }
    }

    /**
    /**
     * Renvoie les métadata d'un flux en précisant la métadata. Celle-ci peut être vide, et renverra alors l'ensemble des metadatas possibles pour le flux
     * @return
     * @param idEvent
     */
    public static JSONObject getFluxMetadata(String fluxId, String metadata) {
      JSONObject fluxData = new JSONObject();
      
      boolean expiredToken = false;
      
      try {
          
          fluxData.put(success, false); // sera remplacé par "true" dans les cas de requête réussie
          
          CloseableHttpResponse response = ApiUtil.createGetConnection(Channel.getChannel().getProperty("jcmsplugin.socle.infolocale.flux.url") + fluxId + "/meta/" + metadata, TokenManager.getInstance().getAccessToken());
          
          if (Util.isEmpty(response)) {
              LOGGER.warn("Method getFluxMetadata => pas de réponse HTTP" + pleaseCheckConf);
              return fluxData;
          }
              
          int status = response.getStatusLine().getStatusCode();
          
          switch (status) {
                      
              case 401:
                  tokensOk = false;
                  while ((attempsToRefresh > 0 || !iterateTokenRefreshCounter()) && !tokensOk) {
                    regenerateTokens();
                  }
                  if (!tokensOk) {
                    LOGGER.warn(methodGetFluxMetadataError + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put(failureReason, "invalid_token");
                  } else {
                    return getFluxMetadata(fluxId, metadata);
                  }
                  break;
              case 200:
                  String responseContent = SocleUtils.convertStreamToString(response.getEntity().getContent());
                  if (responseContent.equals("[]\n")) {
                    fluxData = new JSONObject();
                    fluxData.put("listMetadata", new JSONObject());
                  }
                  else if (Util.isEmpty(metadata) || Util.notEmpty(responseContent)) {
                    fluxData = new JSONObject();
                    if (responseContent.startsWith("[")) {
                      fluxData.put("listMetadata", new JSONObject(responseContent.replaceFirst("\\[", "").replace("}]}]", "}]}")));
                    } else {
                      fluxData.put("listMetadata", new JSONObject(responseContent));
                    }
                  } else {
                    fluxData = new JSONObject(responseContent);
                  }
                  fluxData.put(success, true);
                  
                  fluxData.put("dataType", Util.isEmpty(metadata) ? "list" : "single"); // pour déterminer si on a eu le résultat attendu
                  break;
              case 404:
                  LOGGER.warn(methodGetFluxMetadataError + status + ". Flux " + fluxId + " non trouvé.");
                  fluxData.put(failureReason, "wrong_flux");
                  break;
              default:
                  LOGGER.warn(methodGetFluxMetadataError + status + pleaseCheckConf + response.getStatusLine().getReasonPhrase());
                  fluxData.put(failureReason, "unknown_error");
                  break;
          }
          
      } catch (Exception e) {
          LOGGER.warn("Exception sur extractFluxData : " + e.getMessage());
      }
      
          LOGGER.debug("Token invalide. Tentative de regénération de token...");
      if (expiredToken) {
          regenerateTokens();
      }
      return fluxData;
      
    }

    
}