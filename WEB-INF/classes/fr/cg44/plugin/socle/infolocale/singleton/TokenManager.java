package fr.cg44.plugin.socle.infolocale.singleton;

public class TokenManager {
	
	private TokenManager() {}
	
	private String accessToken = "";
	private String refreshToken = "";
	private String username = "";
	
	private static class TokenManagerHolder {
		
		private final static TokenManager instance = new TokenManager();
		
	}
	
	public static TokenManager getInstance() {
		return TokenManagerHolder.instance;
	}
	
	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	
	public String getRefreshToken() {
		return refreshToken;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}

	public void regenerateTokens() {
		
	}
	
}