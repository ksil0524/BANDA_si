package com.mvc.banda.model.vo;

import java.util.List;

public class AccountVo {

	private String id;						//아이디
	private String password;				//비밀번호
	private String email;					//이메일
	private String phone;					//전화번호
	private List<PetVo> pet_list;			//현 계정의 반려동물 리스트
	private List<FeedVo> feed_list;			//현 계정의 피드 리스트
	private List<ChatVo> chat_list;			//현 계정의 채팅 리스트
	private List<FollowVo> follow_list;		//현 계정의 팔로우 리스트
	
	public AccountVo() {}

	public AccountVo(String id, String password, String email, String phone, List<PetVo> pet_list,
			List<FeedVo> feed_list, List<ChatVo> chat_list, List<FollowVo> follow_list) {
		super();
		this.id = id;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.pet_list = pet_list;
		this.feed_list = feed_list;
		this.chat_list = chat_list;
		this.follow_list = follow_list;
	}

	public AccountVo(String id, String password, String email, String phone) {
		super();
		this.id = id;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.pet_list = null;
		this.feed_list = null;
		this.chat_list = null;
		this.follow_list = null;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public List<PetVo> getPet_list() {
		return pet_list;
	}

	public void setPet_list(List<PetVo> pet_list) {
		this.pet_list = pet_list;
	}

	public List<FeedVo> getFeed_list() {
		return feed_list;
	}

	public void setFeed_list(List<FeedVo> feed_list) {
		this.feed_list = feed_list;
	}

	public List<ChatVo> getChat_list() {
		return chat_list;
	}

	public void setChat_list(List<ChatVo> chat_list) {
		this.chat_list = chat_list;
	}

	public List<FollowVo> getFollow_list() {
		return follow_list;
	}

	public void setFollow_list(List<FollowVo> follow_list) {
		this.follow_list = follow_list;
	}

	@Override
	public String toString() {
		return "AccountVo [id=" + id + ", password=" + password + ", email=" + email + ", phone=" + phone
				+ ", pet_list=" + pet_list + ", feed_list=" + feed_list + ", chat_list=" + chat_list + ", follow_list="
				+ follow_list + "]";
	}
	
	
	
	
	
	
	
}
