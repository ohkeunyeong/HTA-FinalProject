package com.hta.project.domain;



public class Nong_Co {
	private int nong_co_num;      //댓글번호
	private String name;          //농장이름
	private String id;            //작성자
	private String nong_co_con;   //댓글 내용
	private String nong_co_date;  //댓글 작성날짜
	private int nong_num;    //원문 글 번호
	public int getNong_co_num() {
		return nong_co_num;
	}
	public void setNong_co_num(int nong_co_num) {
		this.nong_co_num = nong_co_num;
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
	public String getNong_co_con() {
		return nong_co_con;
	}
	public void setNong_co_con(String nong_co_con) {
		this.nong_co_con = nong_co_con;
	}
	public String getNong_co_date() {
		return nong_co_date;
	}
	public void setNong_co_date(String nong_co_date) {
		this.nong_co_date = nong_co_date;
	}
	public int getNong_num() {
		return nong_num;
	}
	public void setNong_num(int nong_num) {
		this.nong_num = nong_num;
	}
	
	
}
