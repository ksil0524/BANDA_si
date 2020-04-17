package com.mvc.banda.model.vo;

import java.util.Date;

import lombok.Data;

@Data
//@Builder
public class User {

	private String email;
	private String naverid;
	private String nickname;
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}
	public User(String email, String naverid, String nickname) {
		super();
		this.email = email;
		this.naverid = naverid;
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNaverid() {
		return naverid;
	}
	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	@Override
	public String toString() {
		return "User [email=" + email + ", naverid=" + naverid + ", nickname=" + nickname + "]";
	}

	
	
	
	
	
}
