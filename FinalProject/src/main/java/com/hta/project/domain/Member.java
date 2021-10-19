package com.hta.project.domain;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	private String id;
	private String pass;
	private String name;
	private String nick;
	private String mail;
	private String tel;
	private String my_farm;
	private String persnacon;
	private int point;
	private String mynong_name;
	private MultipartFile uploadfile;
	private String original;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPass() {
		return pass;
	}
	
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public String getMail() {
		return mail;
	}
	
	public void setMail(String mail) {
		this.mail = mail;
	}
	
	public String getTel() {
		return tel;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getMy_farm() {
		return my_farm;
	}
	
	public void setMy_farm(String my_farm) {
		this.my_farm = my_farm;
	}
	
	public String getPersnacon() {
		return persnacon;
	}
	
	public void setPersnacon(String persnacon) {
		this.persnacon = persnacon;
	}
	
	public int getPoint() {
		return point;
	}
	
	public void setPoint(int point) {
		this.point = point;
	}
	
	public String getMynong_name() {
		return mynong_name;
	}
	
	public void setMynong_name(String mynong_name) {
		this.mynong_name = mynong_name;
	}

	public MultipartFile getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}

	public String getOriginal() {
		return original;
	}

	public void setOriginal(String original) {
		this.original = original;
	}


}
