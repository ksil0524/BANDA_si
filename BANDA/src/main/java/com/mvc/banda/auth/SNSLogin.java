package com.mvc.banda.auth;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.mvc.banda.model.vo.User;

public class SNSLogin {
	
	private OAuth20Service oauthService;
	private String profileUrl;
	
	public SNSLogin(Snsvalue sns) {
		//oauth서비스 생성
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile")
				.build(sns.getApi20Instance());
		
		this.profileUrl = sns.getProfileUrl();
	}

	public String getNaverAuthURL() {
		// TODO Auto-generated method stub
		return this.oauthService.getAuthorizationUrl();
	}

	public User getUserProfile(String code) throws Exception {
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.profileUrl);
		oauthService.signRequest(accessToken, request);
		
		Response response = oauthService.execute(request);
		
		return parseJson(response.getBody());
	}
	
	private User parseJson(String body) throws Exception {
		
		User user = new User();
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		
		JsonNode resNode = rootNode.get("response");
		user.setNaverid(resNode.get("id").asText());
		user.setEmail(resNode.get("email").asText());
		
		return user;
	}
	

}
