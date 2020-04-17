package com.mvc.banda.model.vo;

public class FeedNoVo {
	
	private String name;
	private int feedno;
	
	public FeedNoVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FeedNoVo(String name, int feedno) {
		super();
		this.name = name;
		this.feedno = feedno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getFeedno() {
		return feedno;
	}

	public void setFeedno(int feedno) {
		this.feedno = feedno;
	}

	@Override
	public String toString() {
		return "FeedNoVo [name=" + name + ", feedno=" + feedno + "]";
	}
	
	

}
