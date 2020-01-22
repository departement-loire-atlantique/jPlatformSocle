package fr.cg44.plugin.socle.infolocale;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;

import com.jalios.jcms.Channel;

import fr.cg44.plugin.socle.infolocale.singleton.TokenManager;

public class RequestManager {
	
	private static final Logger LOGGER = Logger.getLogger(RequestManager.class);
	
	public static void generateTokens() {
		
		TokenManager tokenManager = TokenManager.getInstance();
		Channel channel = Channel.getChannel();
		
		String login = channel.getProperty("jcmsplugin.socle.infolocale.login");
		String password = channel.getProperty("jcmsplugin.socle.infolocale.password");
		
		List<BasicNameValuePair> urlParameters = new ArrayList<>();
		urlParameters.add(new BasicNameValuePair("login", login));
		urlParameters.add(new BasicNameValuePair("password", password));
		
		HttpPost post = new HttpPost("https://api.infolocale.fr/auth/signin");
		try {
			
			post.setEntity(new UrlEncodedFormEntity(urlParameters));
			HttpClient client = HttpClients.createDefault();
			HttpResponse response = client.execute(post);
			JSONObject jsonResponse = new JSONObject(EntityUtils.toString(response.getEntity()));
			
			if (jsonResponse.getInt("code") != 200) {
				LOGGER.warn("Method generateTokens => code HTTP " + jsonResponse.getInt("code") + ". Veuillez verifier la configuration.");
				return;
			}
			
			tokenManager.setAccessToken(jsonResponse.getString("access_token"));
			tokenManager.setRefreshToken(jsonResponse.getString("refresh_token"));
			tokenManager.setUsername(jsonResponse.getString("username"));
			
		} catch (UnsupportedEncodingException e) {
			LOGGER.error("Method generateTokens => une erreur est survenue", e);
		} catch (ClientProtocolException e) {
			LOGGER.error("Method generateTokens => une erreur est survenue", e);
		} catch (IOException e) {
			LOGGER.error("Method generateTokens => une erreur est survenue", e);
		} catch (ParseException e) {
			LOGGER.error("Method generateTokens => une erreur est survenue", e);
		} catch (JSONException e) {
			LOGGER.error("Method generateTokens => une erreur est survenue", e);
		}
	}
	
}