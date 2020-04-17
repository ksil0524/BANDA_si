package com.mvc.banda.model.vo;

import java.util.Date;

public class PetVo {
	
	private int p_no;					//반려동물 번호
	private int class_no;				//대분류
	private int species_no;				//소분류
	private String id;					//아이디
	private String p_Name;				//이름
	private String p_kind;				//품종
	private Date p_birth;				//출생일
	private String p_character;			//성격
	private String p_like;				//좋아하는것
	private String p_hate;				//싫어하는것
	private String p_about;				//소개
	
	public PetVo() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "PetVo [p_no=" + p_no + ", class_no=" + class_no + ", species_no=" + species_no + ", id=" + id
				+ ", p_Name=" + p_Name + ", p_kind=" + p_kind + ", p_birth=" + p_birth + ", p_character=" + p_character
				+ ", p_like=" + p_like + ", p_hate=" + p_hate + ", p_about=" + p_about + "]";
	}

	public PetVo(int p_no, int class_no, int species_no, String id, String p_Name, String p_kind, Date p_birth,
			String p_character, String p_like, String p_hate, String p_about) {
		super();
		this.p_no = p_no;
		this.class_no = class_no;
		this.species_no = species_no;
		this.id = id;
		this.p_Name = p_Name;
		this.p_kind = p_kind;
		this.p_birth = p_birth;
		this.p_character = p_character;
		this.p_like = p_like;
		this.p_hate = p_hate;
		this.p_about = p_about;
	}

	public int getP_no() {
		return p_no;
	}

	public void setP_no(int p_no) {
		this.p_no = p_no;
	}

	public int getClass_no() {
		return class_no;
	}

	public void setClass_no(int class_no) {
		this.class_no = class_no;
	}

	public int getSpecies_no() {
		return species_no;
	}

	public void setSpecies_no(int species_no) {
		this.species_no = species_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getP_Name() {
		return p_Name;
	}

	public void setP_Name(String p_Name) {
		this.p_Name = p_Name;
	}

	public String getP_kind() {
		return p_kind;
	}

	public void setP_kind(String p_kind) {
		this.p_kind = p_kind;
	}

	public Date getP_birth() {
		return p_birth;
	}

	public void setP_birth(Date p_birth) {
		this.p_birth = p_birth;
	}

	public String getP_character() {
		return p_character;
	}

	public void setP_character(String p_character) {
		this.p_character = p_character;
	}

	public String getP_like() {
		return p_like;
	}

	public void setP_like(String p_like) {
		this.p_like = p_like;
	}

	public String getP_hate() {
		return p_hate;
	}

	public void setP_hate(String p_hate) {
		this.p_hate = p_hate;
	}

	public String getP_about() {
		return p_about;
	}

	public void setP_about(String p_about) {
		this.p_about = p_about;
	}
	
	
}
