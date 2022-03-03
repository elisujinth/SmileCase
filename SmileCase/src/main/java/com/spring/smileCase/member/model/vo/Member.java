package com.spring.smileCase.member.model.vo;

public class Member {
	
	private String mem_id; // 아이디
	private String mem_name; // 회원 이름
	private String mem_pwd; // 비밀번호
	private String mem_phone; // 전화번호
	private String mem_email; // 이메일 - @ 앞부분
	private String mem_email2; // 이메일 - @ 뒷부분
	private String mem_zipcode; // 우편번호
	private String mem_address; // 주소 - 검색된 주소
	private String mem_detail_addr; // 주소 - 상세주소
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_email2() {
		return mem_email2;
	}
	public void setMem_email2(String mem_email2) {
		this.mem_email2 = mem_email2;
	}
	public String getMem_zipcode() {
		return mem_zipcode;
	}
	public void setMem_zipcode(String mem_zipcode) {
		this.mem_zipcode = mem_zipcode;
	}
	public String getMem_address() {
		return mem_address;
	}
	public void setMem_address(String mem_address) {
		this.mem_address = mem_address;
	}
	public String getMem_detail_addr() {
		return mem_detail_addr;
	}
	public void setMem_detail_addr(String mem_detail_addr) {
		this.mem_detail_addr = mem_detail_addr;
	}
	@Override
	public String toString() {
		return "Member [mem_id=" + mem_id + ", mem_name=" + mem_name + ", mem_pwd=" + mem_pwd + ", mem_phone="
				+ mem_phone + ", mem_email=" + mem_email + ", mem_email2=" + mem_email2 + ", mem_zipcode=" + mem_zipcode
				+ ", mem_address=" + mem_address + ", mem_detail_addr=" + mem_detail_addr + "]";
	}

}
