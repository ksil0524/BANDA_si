package com.mvc.banda.model.vo;

import java.util.Date;
import java.util.List;

public class FeedVo {
	
	private int feed_no;					//피드번호
	private String id;						//아이디
	private String feed_content;			//내용
	private String feed_ptag;				//반려동물태그
	private String feed_hteg;				//해시태그
	private Date feed_regdate;				//작성일
	private String feed_file;				//첨부파일
	private List<LikesVo> like_list;		//현재 피드의 좋아요들
	private List<CommentVo> comment_list;	//현재 피드의 댓글들
	
	public FeedVo() {}

	public FeedVo(int feed_no, String id, String feed_content, String feed_ptag, String feed_hteg, Date feed_regdate,
			String feed_file, List<LikesVo> like_list, List<CommentVo> comment_list) {
		super();
		this.feed_no = feed_no;
		this.id = id;
		this.feed_content = feed_content;
		this.feed_ptag = feed_ptag;
		this.feed_hteg = feed_hteg;
		this.feed_regdate = feed_regdate;
		this.feed_file = feed_file;
		this.like_list = like_list;
		this.comment_list = comment_list;
	}
	

	public FeedVo(int feed_no, String id, String feed_content, String feed_ptag, String feed_hteg, Date feed_regdate,
			String feed_file) {
		super();
		this.feed_no = feed_no;
		this.id = id;
		this.feed_content = feed_content;
		this.feed_ptag = feed_ptag;
		this.feed_hteg = feed_hteg;
		this.feed_regdate = feed_regdate;
		this.feed_file = feed_file;
		this.like_list = null;
		this.comment_list = null;
		
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

	public String getFeed_content() {
		return feed_content;
	}

	public void setFeed_content(String feed_content) {
		this.feed_content = feed_content;
	}

	public String getFeed_ptag() {
		return feed_ptag;
	}

	public void setFeed_ptag(String feed_ptag) {
		this.feed_ptag = feed_ptag;
	}

	public String getFeed_hteg() {
		return feed_hteg;
	}

	public void setFeed_hteg(String feed_hteg) {
		this.feed_hteg = feed_hteg;
	}

	public Date getFeed_regdate() {
		return feed_regdate;
	}

	public void setFeed_regdate(Date feed_regdate) {
		this.feed_regdate = feed_regdate;
	}

	public String getFeed_file() {
		return feed_file;
	}

	public void setFeed_file(String feed_file) {
		this.feed_file = feed_file;
	}

	public List<LikesVo> getLike_list() {
		return like_list;
	}

	public void setLike_list(List<LikesVo> like_list) {
		this.like_list = like_list;
	}

	public List<CommentVo> getComment_list() {
		return comment_list;
	}

	public void setComment_list(List<CommentVo> comment_list) {
		this.comment_list = comment_list;
	}

	@Override
	public String toString() {
		return "FeedVo [feed_no=" + feed_no + ", id=" + id + ", feed_content=" + feed_content + ", feed_ptag="
				+ feed_ptag + ", feed_hteg=" + feed_hteg + ", feed_regdate=" + feed_regdate + ", feed_file=" + feed_file
				+ ", like_list=" + like_list + ", comment_list=" + comment_list + "]";
	}
	
	
	
}
