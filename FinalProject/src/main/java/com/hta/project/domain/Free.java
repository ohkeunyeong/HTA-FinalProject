
package com.hta.project.domain;

import org.springframework.web.multipart.MultipartFile;

public class Free {
	private int free_num;
	private String free_id;    
	private String nick;    
	private String free_subject;  
	private String free_content; 
	private int free_readcount;
	private int free_like;
	private String free_date;	
	private String free_file;  
	private String free_original;
	private MultipartFile uploadfile;
	private int cnt;
	private String profile;
	private String free_ldate;
	private int free_type;
	
	public int getfree_num() {
		return free_num;
	}
	public void setfree_num(int free_num) {
		this.free_num = free_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getfree_subject() {
		return free_subject;
	}
	public void setfree_subject(String free_subject) {
		this.free_subject = free_subject;
	}
	public String getfree_content() {
		return free_content;
	}
	public void setfree_content(String free_content) {
		this.free_content = free_content;
	}
	public int getfree_readcount() {
		return free_readcount;
	}
	public void setfree_readcount(int free_readcount) {
		this.free_readcount = free_readcount;
	}
	public int getfree_like() {
		return free_like;
	}
	public void setfree_like(int free_like) {
		this.free_like = free_like;
	}
	public String getfree_date() {
		return free_date;
	}
	public void setfree_date(String free_date) {
		this.free_date = free_date.substring(0,10);
	}
	public String getfree_file() {
		return free_file;
	}
	public void setfree_file(String free_file) {
		this.free_file = free_file;
	}
	public String getfree_original() {
		return free_original;
	}
	public void setfree_original(String free_original) {
		this.free_original = free_original;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getfree_id() {
		return free_id;
	}
	public void setfree_id(String free_id) {
		this.free_id = free_id;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getfree_ldate() {
		return free_ldate;
	}
	public void setfree_ldate(String free_ldate) {
		this.free_ldate = free_ldate;
	}
	public int getFree_type() {
		return free_type;
	}
	public void setFree_type(int free_type) {
		this.free_type = free_type;
	}


	
	
}
