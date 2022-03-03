package com.spring.smileCase.product.model.vo;

public class Review {
	
	private int re_no; // 리뷰 번호
	private int pro_no; // 제품 번호
	private String mem_id; // 작성자 (아이디)
	private String re_date; // 리뷰 작성 날짜
	private String re_content; // 리뷰 내용
	
	public int getRe_no() {
		return re_no;
	}

	public void setRe_no(int re_no) {
		this.re_no = re_no;
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

	public String getRe_date() {
		return re_date;
	}

	public void setRe_date(String re_date) {
		this.re_date = re_date;
	}

	public String getRe_content() {
		return re_content;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	@Override
	public String toString() {
		return "Review [re_no=" + re_no + ", pro_no=" + pro_no + ", mem_id=" + mem_id + ", re_date=" + re_date
				+ ", re_content=" + re_content + "]";
	}
	
}
