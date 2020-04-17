package com.mvc.banda.model.vo;

import java.util.Date;

public class ChatVo {
	
	//빈 객체로 만들어서 사용할 것
	
	private int chat_no;				//채팅번호
	private String s_id;				//보낸사람
	private String g_id;				//받는사람
	private String chat_content;		//내용
	private String chat_fyn;			//파일여부
	private Date chat_regdate;				//보낸시간

	public ChatVo() {
	}

	public ChatVo(int chat_no, String s_id, String g_id, String chat_content, String chat_fyn, Date chat_regdate) {
		super();
		this.chat_no = chat_no;
		this.s_id = s_id;
		this.g_id = g_id;
		this.chat_content = chat_content;
		this.chat_fyn = chat_fyn;
		this.chat_regdate = chat_regdate;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	public String getG_id() {
		return g_id;
	}

	public void setG_id(String g_id) {
		this.g_id = g_id;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

	public String getChat_fyn() {
		return chat_fyn;
	}

	public void setChat_fyn(String chat_fyn) {
		this.chat_fyn = chat_fyn;
	}

	public Date getChat_regdate() {
		return chat_regdate;
	}

	public void setChat_regdate(Date chat_regdate) {
		this.chat_regdate = chat_regdate;
	}

	@Override
	public String toString() {
		return "ChatVo [chat_no=" + chat_no + ", s_id=" + s_id + ", g_id=" + g_id + ", chat_content=" + chat_content
				+ ", chat_fyn=" + chat_fyn + ", chat_regdate=" + chat_regdate + "]";
	}

	
	
}
