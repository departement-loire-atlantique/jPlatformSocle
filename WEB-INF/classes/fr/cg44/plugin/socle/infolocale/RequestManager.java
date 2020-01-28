package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.io.IOUtil;
import com.jalios.jcms.Channel;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;
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
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("login", login);
		params.put("password", password);
		
		HttpURLConnection connection = null;
		
		try {
			
			connection = createPostConnection("https://api.infolocale.fr/auth/signin", params, "application/x-www-form-urlencoded");			
			
			if (Util.isEmpty(connection)) {
				LOGGER.warn("Method initTokens => l'élément de connexion est vide, veuillez vérifier la configuration.");
				return;
			}
			
			connection.connect();
			
			int status = connection.getResponseCode();
						
			switch (status) {
				case 200:
					String jsonReply = SocleUtils.convertStreamToString(connection.getInputStream());
					
					JSONObject jsonResponse = new JSONObject(jsonReply);
					
					tokenManager.setAccessToken(jsonResponse.getString("access_token"));
					tokenManager.setRefreshToken(jsonResponse.getString("refresh_token"));
					tokenManager.setUsername(jsonResponse.getString("username"));
					
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
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			if (Util.notEmpty(connection)) connection.disconnect();
		}
	}
	
	/**
	 * Regénère les tokens d'authentification. En cas de token invalide, procède à l'authentification
	 */
	public static void regenerateTokens() {

		boolean invalidToken = false;
		
		TokenManager tokenManager = TokenManager.getInstance();
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("refresh_token", tokenManager.getRefreshToken());
		
		HttpURLConnection connection = null;
		
		try {
			
			connection = createPostConnection("https://api.infolocale.fr/auth/refresh-token", params, "application/x-www-form-urlencoded");
			
			if (Util.isEmpty(connection)) {
				LOGGER.warn("Method regenerateTokens => l'élément de connexion est vide, veuillez vérifier la configuration.");
				return;
			}
			
			connection.connect();
			
			int status = connection.getResponseCode();
						
			switch (status) {
				case 200:
					String jsonReply = SocleUtils.convertStreamToString(connection.getInputStream());
					
					JSONObject jsonResponse = new JSONObject(jsonReply);
					
					tokenManager.setAccessToken(jsonResponse.getString("access_token"));
					tokenManager.setRefreshToken(jsonResponse.getString("refresh_token"));
					tokenManager.setUsername(jsonResponse.getString("username"));
					
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
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			if (Util.notEmpty(connection)) connection.disconnect();
		}
		
		if (invalidToken) {
			LOGGER.debug("Token invalide. Tentative de regénération de token via authentification...");
			initTokens();
		}
	}
	
	public static JSONObject extractFluxData(String fluxId) {
		
		JSONObject fluxData = new JSONObject();
		
		TokenManager tokenManager = TokenManager.getInstance();
		boolean expiredToken = false;
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("Authorization", "Bearer " + tokenManager.getAccessToken());
		
		HttpURLConnection connection = null;
		
		try {
			fluxData.put("success", false); // sera remplacé par "true" dans les cas de requête réussie
			
			connection = createPostConnection("https://api.infolocale.fr/flux/" + fluxId + "/data", params, "application/x-www-form-urlencoded");
			
			if (Util.isEmpty(connection)) {
				LOGGER.warn("Method extractFluxData => l'élément de connexion est vide, veuillez vérifier la configuration.");
				return fluxData;
			}
			
			connection.connect();
			
			int status = connection.getResponseCode();
						
			switch (status) {
				case 200:
					String jsonReply = SocleUtils.convertStreamToString(connection.getInputStream());
					
					fluxData = new JSONObject(jsonReply);
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
		} finally {
			if (Util.notEmpty(connection)) connection.disconnect();
		}
		
		if (expiredToken) {
			LOGGER.debug("Token invalide. Tentative de regénération de token...");
			regenerateTokens();
		}
		
		return fluxData;
	}
	
	private static HttpURLConnection createPostConnection(String url, Map<String, String> params, String contentType) {
		HttpURLConnection connection = null;
		try {
			connection = IOUtil.openConnection(new URL(url), true, true, "POST");
			
			if (Util.notEmpty(contentType)) connection.setRequestProperty("Content-Type", contentType);
			if (Util.isEmpty(params)) return connection;
			
			byte[] dataPost = SocleUtils.generatePostDataFromMap(params);
			
			connection.setRequestProperty("Content-Length", String.valueOf(dataPost.length));
			
			connection.getOutputStream().write(dataPost);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
	private static HttpURLConnection createGetConnection(String url, Map<String, String> params) {
		HttpURLConnection connection = null;
		try {
			connection = IOUtil.openConnection(new URL(url), true, true, "POST");
			
			if (Util.isEmpty(params)) return connection;
			
			for (String itKey : params.keySet()) {
				connection.setRequestProperty(itKey, params.get(itKey));
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
}