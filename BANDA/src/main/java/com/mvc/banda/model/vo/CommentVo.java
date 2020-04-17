package com.mvc.banda.model.vo;

import java.util.Date;

public class CommentVo {
	
	private int com_no;				//댓글번호
	private String com_cate;		//구분(게시판 B / 피드 F / 댓글 C)
	private String id;				//아이디
	private String com_content;		//내용
	private Date com_regdate;		//작성일
	private int com_pno;			//부모글번호
	
	public CommentVo() {
		// TODO Auto-generated constructor stub
	}

	public CommentVo(int com_no, String com_cate, String id, String com_content, Date com_regdate, int com_pno) {
		super();
		this.com_no = com_no;
		this.com_cate = com_cate;
		this.id = id;
		this.com_content = com_content;
		this.com_regdate = com_regdate;
		this.com_pno = com_pno;
	}
	

	public CommentVo(String com_cate, String id, String com_content, int com_pno) {
		super();
		this.com_cate = com_cate;
		this.id = id;
		this.com_content = com_content;
		this.com_pno = com_pno;
	}

	public int getCom_no() {
		return com_no;
	}

	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}

	public String getCom_cate() {
		return com_cate;
	}

	public void setCom_cate(String com_cate) {
		this.com_cate = com_cate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCom_content() {
		return com_content;
	}

	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}

	public Date getCom_regdate() {
		return com_regdate;
	}

	public void setCom_regdate(Date com_regdate) {
		this.com_regdate = com_regdate;
	}

	public int getCom_pno() {
		return com_pno;
	}

	public void setCom_pno(int com_pno) {
		this.com_pno = com_pno;
	}

	@Override
	public String toString() {
		return "CommentVo [com_no=" + com_no + ", com_cate=" + com_cate + ", id=" + id + ", com_content=" + com_content
				+ ", com_regdate=" + com_regdate + ", com_pno=" + com_pno + "]";
	}
	
	
	
}
