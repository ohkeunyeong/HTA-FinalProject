package com.hta.project.domain;

import org.springframework.web.multipart.MultipartFile;

public class Nong {
	private int nong_num;         //글번호
	private String name;          //농장이름
	private String id;            //작성자
	private String nong_pass;     //글 비밀번호
	private String nong_sub;      //글 제목
	private String nong_con;      //글 내용
	private String nong_file;     //실제 저장된 파일의 이름
	private int    nong_re_ref;   //답변 글 작성시 참조되는 글의 번호
	private int    nong_re_lev;   //답변 글의 깊이
	private int    nong_re_seq;   //답변 글의 순서
	private int    nong_read;     //글의 조회수
	
	private MultipartFile uploadfile;
	
	private String nong_ori;   //첨부될 파일 이름
	private String nong_date;  //글 작성날짜
	
	private int cnt; //글의 댓글 수 

	public int getNong_num() {
		return nong_num;
	}

	public void setNong_num(int nong_num) {
		this.nong_num = nong_num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNong_pass() {
		return nong_pass;
	}

	public void setNong_pass(String nong_pass) {
		this.nong_pass = nong_pass;
	}

	public String getNong_sub() {
		return nong_sub;
	}

	public void setNong_sub(String nong_sub) {
		this.nong_sub = nong_sub;
	}

	public String getNong_con() {
		return nong_con;
	}

	public void setNong_con(String nong_con) {
		this.nong_con = nong_con;
	}

	public String getNong_file() {
		return nong_file;
	}

	public void setNong_file(String nong_file) {
		this.nong_file = nong_file;
	}

	public int getNong_re_ref() {
		return nong_re_ref;
	}

	public void setNong_re_ref(int nong_re_ref) {
		this.nong_re_ref = nong_re_ref;
	}

	public int getNong_re_lev() {
		return nong_re_lev;
	}

	public void setNong_re_lev(int nong_re_lev) {
		this.nong_re_lev = nong_re_lev;
	}

	public int getNong_re_seq() {
		return nong_re_seq;
	}

	public void setNong_re_seq(int nong_re_seq) {
		this.nong_re_seq = nong_re_seq;
	}

	public int getNong_read() {
		return nong_read;
	}

	public void setNong_read(int nong_read) {
		this.nong_read = nong_read;
	}

	public MultipartFile getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}

	public String getNong_ori() {
		return nong_ori;
	}

	public void setNong_ori(String nong_ori) {
		this.nong_ori = nong_ori;
	}

	public String getNong_date() {
		return nong_date;
	}

	public void setNong_date(String nong_date) {
		this.nong_date = nong_date.substring(0, 10);
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
}
