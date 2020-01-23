package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

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
	
	public static void generateTokens() {
		
		TokenManager tokenManager = TokenManager.getInstance();
		Channel channel = Channel.getChannel();
		HttpURLConnection connection = null;
		
		String login = channel.getProperty("jcmsplugin.socle.infolocale.login");
		String password = channel.getProperty("jcmsplugin.socle.infolocale.password");
		
		try {
			
			connection = IOUtil.openConnection(new URL("https://api.infolocale.fr/auth/signin"), true, true, "POST");
			
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			
			connection.setRequestProperty("login", "TEST");
			connection.setRequestProperty("password", "TEST");
			
			connection.connect();
			
			int status = connection.getResponseCode();
			
			System.out.println(status);
						
			switch (status) {
				case 200:
					String jsonReply = SocleUtils.convertStreamToString(connection.getInputStream());
					
					JSONObject jsonResponse = new JSONObject(jsonReply);
					
					tokenManager.setAccessToken(jsonResponse.getString("access_token"));
					tokenManager.setRefreshToken(jsonResponse.getString("refresh_token"));
					tokenManager.setUsername(jsonResponse.getString("username"));
					
					LOGGER.info("Tokens générés");
					break;
				case 400:
					LOGGER.warn("Method generateTokens => code HTTP 400. Veuillez verifier la configuration.");
					break;
				case 401:
					LOGGER.warn("Method generateTokens => code HTTP 401. Veuillez verifier la configuration.");
					break;
			}
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		} finally {
			if (Util.notEmpty(connection)) connection.disconnect();
		}
	}
	
}