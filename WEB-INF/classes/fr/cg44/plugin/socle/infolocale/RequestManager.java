package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
import fr.cg44.plugin.socle.infolocale.fluxdata.Authentification;
import fr.cg44.plugin.socle.infolocale.singleton.TokenManager;

public class RequestManager {
    
    private static final Logger LOGGER = Logger.getLogger(RequestManager.class);
    
    /**
     * Envoie une requête pour s'authentifier à Infolocale et générer les tokens d'authentification
     */
    public static void initTokens() {
        
        TokenManager tokenManager = TokenManager.getInstance();
        Channel channel = Channel.getChannel();
        
        String login = channel.getProperty("jcmsplugin.socle.infolocale.login");
        String password = channel.getProperty("jcmsplugin.socle.infolocale.password");
        
        Map<String, Object> params = new HashMap<String,Object>();
        params.put("login", login);
        params.put("password", password);
        
        try {
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/auth/signin", params, "application/x-www-form-urlencoded", false);            
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method initTokens => l'élément de connexion est vide, veuillez vérifier la configuration.");
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
                    LOGGER.warn("Method initTokens => code HTTP innatendu " + status + ". Il manque des paramètres.");
                    break;
                case 401:
                    LOGGER.warn("Method initTokens => code HTTP innatendu " + status + ". Authentification échouée.");
                    break;
                default:
                    LOGGER.warn("Method initTokens => code HTTP innatendu " + status + ". Veuillez verifier la configuration.");
                    break;
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Regénère les tokens d'authentification. En cas de token invalide, procède à l'authentification
     */
    public static void regenerateTokens() {

        boolean invalidToken = false;
        
        TokenManager tokenManager = TokenManager.getInstance();
        
        Map<String, Object> params = new HashMap<String,Object>();
        params.put("refresh_token", tokenManager.getRefreshToken());
        
        try {
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/auth/refresh-token", params, "application/x-www-form-urlencoded", false);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method regenerateTokens => l'élément de connexion est vide, veuillez vérifier la configuration.");
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
                    LOGGER.warn("Method regenerateTokens => code HTTP innatendu " + status + ". Token non valide.");
                    invalidToken = true;
                    break;
                case 401:
                    LOGGER.warn("Method regenerateTokens => code HTTP innatendu " + status + ". Authentification échouée.");
                    break;
                default:
                    LOGGER.warn("Method regenerateTokens => code HTTP innatendu " + status + ". Veuillez verifier la configuration.");
                    break;
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        if (invalidToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token via authentification...");
            initTokens();
        }
    }
    
    public static JSONObject extractFluxData(String fluxId) {
        
        JSONObject fluxData = new JSONObject();
        
        boolean expiredToken = false;
        
        Map<String, Object> params = new HashMap<String,Object>();        
        
        try {
            fluxData.put("success", false); // sera remplacé par "true" dans les cas de requête réussie
            
            CloseableHttpResponse response = createPostConnection("https://api.infolocale.fr/flux/" + fluxId + "/data", params, "application/x-www-form-urlencoded", true);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method extractFluxData => l'élément de connexion est vide, veuillez vérifier la configuration.");
                return fluxData;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 200:
                    
                    fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                    fluxData.put("success", true);
                    
                    LOGGER.debug("Tokens regénérés");
                    break;
                case 401:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put("failure_reason", "invalid_token");
                    break;
                case 404:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Flux " + fluxId + " non trouvé.");
                    fluxData.put("failure_reason", "wrong_flux");
                    break;
                default:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Veuillez verifier la configuration.");
                    fluxData.put("failure_reason", "unknown_error");
                    break;
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        
        if (expiredToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token...");
            regenerateTokens();
        }
        
        return fluxData;
    }

    public static JSONObject filterFluxData(String fluxId, Map<String, Object> params) {
        
        JSONObject fluxData = new JSONObject();
        
        boolean expiredToken = false;
        
        try {
            fluxData.put("success", false); // sera remplacé par "true" dans les cas de requête réussie
            
            CloseableHttpResponse response = createGetConnection("https://api.infolocale.fr/flux/" + fluxId + "/data", params, true);
            
            if (Util.isEmpty(response)) {
                LOGGER.warn("Method extractFluxData => l'élément de connexion est vide, veuillez vérifier la configuration.");
                return fluxData;
            }
            
            int status = response.getStatusLine().getStatusCode();
                        
            switch (status) {
                case 200:
                    
                    fluxData = new JSONObject(SocleUtils.convertStreamToString(response.getEntity().getContent()));
                    fluxData.put("success", true);
                    
                    LOGGER.debug("Tokens regénérés");
                    break;
                case 401:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Token expiré.");
                    expiredToken = true;
                    fluxData.put("failure_reason", "invalid_token");
                    break;
                case 404:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Flux " + fluxId + " non trouvé.");
                    fluxData.put("failure_reason", "wrong_flux");
                    break;
                default:
                    LOGGER.warn("Method extractFluxData => code HTTP innatendu " + status + ". Veuillez verifier la configuration.");
                    fluxData.put("failure_reason", "unknown_error");
                    break;
            }
            
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        }
        
        if (expiredToken) {
            LOGGER.debug("Token invalide. Tentative de regénération de token...");
            regenerateTokens();
        }
        
        return fluxData;
    }
    
    private static CloseableHttpResponse createPostConnection(String url, Map<String, Object> params, String contentType, boolean useToken) {
        
        CloseableHttpClient httpClient = HttpClients.createDefault();
        
        HttpPost post = new HttpPost(url);
        
        if (Util.notEmpty(params)) {
            List<BasicNameValuePair> urlParameters = new ArrayList<>();
            for (String key : params.keySet()) {
                urlParameters.add(new BasicNameValuePair(key, params.get(key).toString()));
            }
            
            try {
                post.setEntity(new UrlEncodedFormEntity(urlParameters));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        
        if (useToken) {
            post.setHeader("Authorization", "Bearer " + TokenManager.getInstance().getAccessToken() );
        }
        
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(post);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return response;
    }
    
    private static CloseableHttpResponse createGetConnection(String url, Map<String, Object> params, boolean useToken) {
        
        CloseableHttpClient httpClient = HttpClients.createDefault();
        
        HttpGet request = new HttpGet(url + SocleUtils.buildGetParams(params));
        
        if (useToken) {
            request.setHeader("Authorization", "Bearer " + TokenManager.getInstance().getAccessToken() );
        }
        
        CloseableHttpResponse response = null;
        try {
            response = httpClient.execute(request);
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return response;
    }
    
}