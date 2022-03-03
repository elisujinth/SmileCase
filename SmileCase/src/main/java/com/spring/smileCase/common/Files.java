package com.spring.smileCase.common;

public class Files {
	
	private int file_no; // 파일 번호
	private int pro_no; // 제품 번호
	private String origin_name; // 원본 파일명
	private String change_name; // 바꾼 파일명
	private String file_path; // 파일 경로
	private String file_delete_yn; // 파일 삭제 여부
	
	public Files() {}

	public Files(int file_no, int pro_no, String origin_name, String change_name, String file_path,
			String file_delete_yn) {
		super();
		this.file_no = file_no;
		this.pro_no = pro_no;
		this.origin_name = origin_name;
		this.change_name = change_name;
		this.file_path = file_path;
		this.file_delete_yn = file_delete_yn;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}

	public int getPro_no() {
		return pro_no;
	}

	public void setPro_no(int pro_no) {
		this.pro_no = pro_no;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getChange_name() {
		return change_name;
	}

	public void setChange_name(String change_name) {
		this.change_name = change_name;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public String getFile_delete_yn() {
		return file_delete_yn;
	}

	public void setFile_delete_yn(String file_delete_yn) {
		this.file_delete_yn = file_delete_yn;
	}

	@Override
	public String toString() {
		return "Files [file_no=" + file_no + ", pro_no=" + pro_no + ", origin_name=" + origin_name + ", change_name="
				+ change_name + ", file_path=" + file_path + ", file_delete_yn=" + file_delete_yn + "]";
	}
	
}
