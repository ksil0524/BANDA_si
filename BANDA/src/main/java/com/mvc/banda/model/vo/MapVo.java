package com.mvc.banda.model.vo;

public class MapVo {
	
	private int map_no;					//지도번호
	private String map_cate;			//구분(병원 / 약국 / 공원)
	private String map_name;			//상호명
	private String map_addr;			//지번주소
	private String map_naddr;			//도로명주소
	private String map_zipcode;			//우편번호
	private String map_phone;			//전화번호
	private double map_latitude;		//위도
	private double map_longitude;		//경도
	
	public MapVo() {
	}

	public MapVo(int map_no, String map_cate, String map_name, String map_addr, String map_naddr, String map_zipcode,
			String map_phone, double map_latitude, double map_longitude) {
		super();
		this.map_no = map_no;
		this.map_cate = map_cate;
		this.map_name = map_name;
		this.map_addr = map_addr;
		this.map_naddr = map_naddr;
		this.map_zipcode = map_zipcode;
		this.map_phone = map_phone;
		this.map_latitude = map_latitude;
		this.map_longitude = map_longitude;
	}

	public int getMap_no() {
		return map_no;
	}

	public void setMap_no(int map_no) {
		this.map_no = map_no;
	}

	public String getMap_cate() {
		return map_cate;
	}

	public void setMap_cate(String map_cate) {
		this.map_cate = map_cate;
	}

	public String getMap_name() {
		return map_name;
	}

	public void setMap_name(String map_name) {
		this.map_name = map_name;
	}

	public String getMap_addr() {
		return map_addr;
	}

	public void setMap_addr(String map_addr) {
		this.map_addr = map_addr;
	}

	public String getMap_naddr() {
		return map_naddr;
	}

	public void setMap_naddr(String map_naddr) {
		this.map_naddr = map_naddr;
	}

	public String getMap_zipcode() {
		return map_zipcode;
	}

	public void setMap_zipcode(String map_zipcode) {
		this.map_zipcode = map_zipcode;
	}

	public String getMap_phone() {
		return map_phone;
	}

	public void setMap_phone(String map_phone) {
		this.map_phone = map_phone;
	}

	public double getMap_latitude() {
		return map_latitude;
	}

	public void setMap_latitude(double map_latitude) {
		this.map_latitude = map_latitude;
	}

	public double getMap_longitude() {
		return map_longitude;
	}

	public void setMap_longitude(double map_longitude) {
		this.map_longitude = map_longitude;
	}

	@Override
	public String toString() {
		return "MapVo [map_no=" + map_no + ", map_cate=" + map_cate + ", map_name=" + map_name + ", map_addr="
				+ map_addr + ", map_naddr=" + map_naddr + ", map_zipcode=" + map_zipcode + ", map_phone=" + map_phone
				+ ", map_latitude=" + map_latitude + ", map_longitude=" + map_longitude + "]";
	}
	
}
