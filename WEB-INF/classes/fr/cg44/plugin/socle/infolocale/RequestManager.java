package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
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
			
			connection = createConnection("https://api.infolocale.fr/auth/signin", "POST", params, "application/x-www-form-urlencoded");
			
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
	
	public static void regenerateTokens() {
		TokenManager tokenManager = TokenManager.getInstance();
		
		Map<String, String> params = new HashMap<String,String>();
		params.put("refresh_token", tokenManager.getRefreshToken());
		
		HttpURLConnection connection = null;
		
		try {
			
			connection = createConnection("https://api.infolocale.fr/auth/refresh-token", "POST", params, "application/x-www-form-urlencoded");
			
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
	}
	
	private static HttpURLConnection createConnection(String url, String method, Map<String, String> params, String contentType) {
		HttpURLConnection connection = null;
		try {
			connection = IOUtil.openConnection(new URL(url), true, true, method);
			
			if (Util.notEmpty(contentType)) connection.setRequestProperty("Content-Type", contentType);
			if (Util.isEmpty(params)) return connection;
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
	
}