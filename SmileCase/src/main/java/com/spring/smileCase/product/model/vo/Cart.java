package com.spring.smileCase.product.model.vo;

public class Cart {
	
	private int ca_no; // 장바구니 번호
	private int pro_no; // 상품 번호
	private String mem_id; // 아이디
	private int ca_count; // 개수
	private String pro_name; // 상품명
	private int pro_price; // 상품 가격
	private String pro_originFileName; // 이미지 파일명
	
	
	public String getPro_name() {
		return pro_name;
	}

	public int getCa_no() {
		return ca_no;
	}

	public void setCa_no(int ca_no) {
		this.ca_no = ca_no;
	}

	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}

	public int getPro_price() {
		return pro_price;
	}

	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}

	public String getPro_originFileName() {
		return pro_originFileName;
	}

	public void setPro_originFileName(String pro_originFileName) {
		this.pro_originFileName = pro_originFileName;
	}

	public int getPro_no() {
		return pro_no;
	}
	
	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public int getCa_count() {
		return ca_count;
	}
	
	public void setCa_count(int ca_count) {
		this.ca_count = ca_count;
	}

	@Override
	public String toString() {
		return "Cart [ca_no=" + ca_no + ", pro_no=" + pro_no + ", mem_id=" + mem_id + ", ca_count=" + ca_count
				+ ", pro_name=" + pro_name + ", pro_price=" + pro_price + ", pro_originFileName=" + pro_originFileName
				+ "]";
	}
	
}
