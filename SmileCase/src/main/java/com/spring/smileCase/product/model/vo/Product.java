package com.spring.smileCase.product.model.vo;

import org.springframework.web.multipart.MultipartFile;

public class Product {
	
	private int pro_no; // 상품 번호
	private String pro_name; // 상품명
	private int pro_price; // 가격
	private int pro_stock; // 재고
	private String pro_category; // 카테고리(GALAXY, IPHONE)
	private MultipartFile pro_image; // 이미지 파일 그자체
	private String pro_originFileName; // 이미지 파일명

	public int getPro_no() {
		return pro_no;
	}
	
	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}
	
	public String getPro_name() {
		return pro_name;
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
	
	public int getPro_stock() {
		return pro_stock;
	}
	
	public void setPro_stock(int pro_stock) {
		this.pro_stock = pro_stock;
	}
	
	public String getPro_category() {
		return pro_category;
	}
	
	public void setPro_category(String pro_category) {
		this.pro_category = pro_category;
	}
	
	public MultipartFile getPro_image() {
		return pro_image;
	}
	
	public void setPro_image(MultipartFile pro_image) {
		this.pro_image = pro_image;
	}
	
	public String getPro_originFileName() {
		return pro_originFileName;
	}
	
	public void setPro_originFileName(String pro_originFileName) {
		this.pro_originFileName = pro_originFileName;
	}
	
	@Override
	public String toString() {
		return "Product [pro_no=" + pro_no + ", pro_name=" + pro_name + ", pro_price=" + pro_price + ", pro_stock="
				+ pro_stock + ", pro_category=" + pro_category + ", pro_image=" + pro_image + ", pro_originFileName="
				+ pro_originFileName + "]";
	}
	
}
