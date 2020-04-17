package com.mvc.banda.model.vo;

public class FollowVo {
	
	private String fr_id;		//팔로우 한 사람
	private String fd_id;		//팔로우 당한 사람
	
	public FollowVo() {
		// TODO Auto-generated constructor stub
	}

	public FollowVo(String fr_id, String fd_id) {
		super();
		this.fr_id = fr_id;
		this.fd_id = fd_id;
	}

	public String getFr_id() {
		return fr_id;
	}

	public void setFr_id(String fr_id) {
		this.fr_id = fr_id;
	}

	public String getFd_id() {
		return fd_id;
	}

	public void setFd_id(String fd_id) {
		this.fd_id = fd_id;
	}

	@Override
	public String toString() {
		return "FollowVo [fr_id=" + fr_id + ", fd_id=" + fd_id + "]";
	}
	
	
}
