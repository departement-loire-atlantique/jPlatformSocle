package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.util.Util;

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
    
    private static String methodInitTokensError = "Method initTokens => code HTTP innatendu ";
    private static String methodRegenerateTokensError = "Method regenerateTokens => code HTTP innatendu ";
    private static String methodExtractFluxDataError = "Method extractFluxData => code HTTP innatendu ";
    private static String methodFilterFluxDataError = "Method filterFluxData => code HTTP innatendu ";
    
    private static String success = "success";
    private static String failureReason = "failure_reason";
    
    private RequestManager() {}
    
    /**
     * Envoie une requête pour s'authentifier à Infolocale et générer les tokens d'authentification
     */
    public static void initTokens() {
        
        TokenManager tokenManager = TokenManager.getInstance();
        Channel channel = Channel.getChannel();
        
        String login = channel.getProperty("jcmsplugin.socle.infolocale.login");
        String password = channel.getProperty("jcmsplugin.socle.infolocale.password");
        
        Map<String, Object> params = new HashMap<>();
        params.put("login", login);
        params.put("password", password);
        
        try {
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/auth/signin", params, false);            
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method initTokens => pas de réponse HTTP" + pleaseCheckConf);
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
                    break;
                case 400:
                    LOGGER.warn(methodInitTokensError + status + ". Il manque des paramètres.");
                    break;
                case 401:
                    LOGGER.warn(methodInitTokensError + status + ". Authentification échouée.");
                    break;
                default:
                    LOGGER.warn(methodInitTokensError + status + pleaseCheckConf);
                    break;
            }
            
        } catch (IOException e) {
            LOGGER.warn("Exception sur initTokens : " + e.getMessage());
        }
    }
    
    /**
     * Regénère les tokens d'authentification. En cas de token invalide, procède à l'authentification
     */
    public static void regenerateTokens() {

        boolean invalidToken = false;
        
        TokenManager tokenManager = TokenManager.getInstance();
        
        Map<String, Object> params = new HashMap<>();
        params.put("refresh_token", tokenManager.getRefreshToken());
        
        try {
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/auth/refresh-token", params, false);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method regenerateTokens => pas de réponse HTTP" + pleaseCheckConf);
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
                    
                    LOGGER.debug("Tokens regénérés");
                    break;
                case 400:
                    LOGGER.warn(methodRegenerateTokensError + status + ". Token non valide.");
                    invalidToken = true;
                    break;
                case 401:
                    LOGGER.warn(methodRegenerateTokensError + status + ". Authentification échouée.");
                    break;
                default:
                    LOGGER.warn(methodRegenerateTokensError + status + pleaseCheckConf);
                    break;
            }
            
        } catch (IOException e) {
            LOGGER.warn("Exception sur regenerateTokens : " + e.getMessage());
        }
        
        if (invalidToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token via authentification...");
            initTokens();
        }
    }
    
    /**
     * Extrait des données à partir d'un flux de l'API Infolocale
     */
    public static JSONObject extractFluxData(String fluxId) {
        
        JSONObject fluxData = new JSONObject();
        
        boolean expiredToken = false;
        
        Map<String, Object> params = new HashMap<>();
        
        try {
            fluxData.put(success, false); // sera remplacé par "true" dans les cas de requête réussie
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/flux/" + fluxId + "/data", params, true);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method extractFluxData => pas de réponse HTTP" + pleaseCheckConf);
                return fluxData;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 200:
                    
                    fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                    fluxData.put(success, true);
                    
                    break;
                case 401:
                    LOGGER.warn(methodExtractFluxDataError + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put(failureReason, "invalid_token");
                    break;
                case 404:
                    LOGGER.warn(methodExtractFluxDataError + status + ". Flux " + fluxId + " non trouvé.");
                    fluxData.put(failureReason, "wrong_flux");
                    break;
                default:
                    LOGGER.warn(methodExtractFluxDataError + status + pleaseCheckConf);
                    fluxData.put(failureReason, "unknown_error");
                    break;
            }
            
        } catch (Exception e) {
            LOGGER.warn("Exception sur regenerateTokens : " + e.getMessage());
        }
        
        if (expiredToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token...");
            regenerateTokens();
        }
        
        return fluxData;
    }

    /**
     * Extrait des données à partir d'un flux de l'API Infolocale en intégrant des paramètres de tri
     */
    public static JSONObject filterFluxData(String fluxId, Map<String, Object> params) {
        
        JSONObject fluxData = new JSONObject();
        
        boolean expiredToken = false;
        
        try {
            fluxData.put(success, false); // sera remplacé par "true" dans les cas de requête réussie
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/flux/" + fluxId + "/data", params, true);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method extractFluxData => pas de réponse HTTP" + pleaseCheckConf);
                return fluxData;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 200:
                    
                    fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                    fluxData.put(success, true);
                    
                    break;
                case 401:
                    LOGGER.warn(methodFilterFluxDataError + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put(failureReason, "invalid_token");
                    break;
                case 404:
                    LOGGER.warn(methodFilterFluxDataError + status + ". Flux " + fluxId + " non trouvé.");
                    fluxData.put(failureReason, "wrong_flux");
                    break;
                default:
                    LOGGER.warn(methodFilterFluxDataError + status + pleaseCheckConf);
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
     * Créée une CloseableHttpResponse avec des paramètres dans le cadre d'une requête POST
     */
    private static CloseableHttpResponse createPostConnection(String url, Map<String, Object> params, boolean useToken) {
        
        CloseableHttpClient httpClient = HttpClients.createDefault();
        
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
        
        if (useToken) {
            post.setHeader("Authorization", "Bearer " + TokenManager.getInstance().getAccessToken() );
        }
        
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(post);
        } catch (IOException e) {
            LOGGER.warn("Exception sur createPostConnection : " + e.getMessage());
        }
        
        return response;
    }
    
}