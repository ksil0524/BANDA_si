package com.mvc.banda.model.vo;

import java.util.Date;
import java.util.List;

public class BoardVo {
	
	private int board_no;			//게시판번호
	private String board_cate;		//구분(물품교환  : EX / 무료나눔 : SH )
	private String id;				//아이디
	private String board_title;		//제목
	private String board_content;	//내용
	private Date board_regdate;		//작성일
	private String board_nyn;		//공지여부(Y/N)
	private String board_file;		//첨부파일
	private String board_hash;		//해시태그
	private int board_view;			//조회수
	private List<CommentVo> comment_list; //현재 게시판글의 댓글들
	
	public BoardVo() {
		// TODO Auto-generated constructor stub
	}

	public BoardVo(int board_no, String board_cate, String id, String board_title, String board_content,
			Date board_regdate, String board_nyn, String board_file, String board_hash, int board_view, List<CommentVo> comment_list) {
		super();
		this.board_no = board_no;
		this.board_cate = board_cate;
		this.id = id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_regdate = board_regdate;
		this.board_nyn = board_nyn;
		this.board_file = board_file;
		this.board_hash = board_hash;
		this.board_view = board_view;
		this.comment_list = comment_list;
	}
	

	public BoardVo(int board_no, String board_cate, String id, String board_title, String board_content,
			Date board_regdate, String board_nyn, String board_file, String board_hash, int board_view) {
		super();
		this.board_no = board_no;
		this.board_cate = board_cate;
		this.id = id;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_regdate = board_regdate;
		this.board_nyn = board_nyn;
		this.board_file = board_file;
		this.board_hash = board_hash;
		this.board_view = board_view;
		this.comment_list = null;

	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getBoard_cate() {
		return board_cate;
	}

	public void setBoard_cate(String board_cate) {
		this.board_cate = board_cate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public Date getBoard_regdate() {
		return board_regdate;
	}

	public void setBoard_regdate(Date board_regdate) {
		this.board_regdate = board_regdate;
	}

	public String getBoard_nyn() {
		return board_nyn;
	}

	public void setBoard_nyn(String board_nyn) {
		this.board_nyn = board_nyn;
	}

	public String getBoard_file() {
		return board_file;
	}

	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}

	public String getBoard_hash() {
		return board_hash;
	}

	public void setBoard_hash(String board_hash) {
		this.board_hash = board_hash;
	}

	public int getBoard_view() {
		return board_view;
	}

	public void setBoard_view(int board_view) {
		this.board_view = board_view;
	}

	public List<CommentVo> getComment_list() {
		return comment_list;
	}

	public void setComment_list(List<CommentVo> comment_list) {
		this.comment_list = comment_list;
	}

	@Override
	public String toString() {
		return "BoardVo [board_no=" + board_no + ", board_cate=" + board_cate + ", id=" + id + ", board_title="
				+ board_title + ", board_content=" + board_content + ", board_regdate=" + board_regdate + ", board_nyn="
				+ board_nyn + ", board_file=" + board_file + ", board_hash=" + board_hash + ", board_view=" + board_view
				+ ", comment_list=" + comment_list + "]";
	}

	
	
}
