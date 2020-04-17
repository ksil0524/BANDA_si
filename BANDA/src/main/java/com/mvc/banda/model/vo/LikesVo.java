package com.mvc.banda.model.vo;

public class LikesVo {
	
	private int feed_no;		//피드번호
	private String id;			//아이디
	
	public LikesVo() {
		// TODO Auto-generated constructor stub
	}

	public LikesVo(int feed_no, String id) {
		super();
		this.feed_no = feed_no;
		this.id = id;
	}

	public int getFeed_no() {
		return feed_no;
	}

	public void setFeed_no(int feed_no) {
		this.feed_no = feed_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "LikesVo [feed_no=" + feed_no + ", id=" + id + "]";
	}
	
	
	
}
