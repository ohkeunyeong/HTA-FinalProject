
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
	public int getFree_num() {
		return free_num;
	}
	public void setFree_num(int free_num) {
		this.free_num = free_num;
	}
	public String getFree_id() {
		return free_id;
	}
	public void setFree_id(String free_id) {
		this.free_id = free_id;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getFree_subject() {
		return free_subject;
	}
	public void setFree_subject(String free_subject) {
		this.free_subject = free_subject;
	}
	public String getFree_content() {
		return free_content;
	}
	public void setFree_content(String free_content) {
		this.free_content = free_content;
	}
	public int getFree_readcount() {
		return free_readcount;
	}
	public void setFree_readcount(int free_readcount) {
		this.free_readcount = free_readcount;
	}
	public int getFree_like() {
		return free_like;
	}
	public void setFree_like(int free_like) {
		this.free_like = free_like;
	}
	public String getFree_date() {
		return free_date;
	}
	public void setFree_date(String free_date) {
		this.free_date = free_date.substring(0,10);
	}
	public String getFree_file() {
		return free_file;
	}
	public void setFree_file(String free_file) {
		this.free_file = free_file;
	}
	public String getFree_original() {
		return free_original;
	}
	public void setFree_original(String free_original) {
		this.free_original = free_original;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
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
	public String getFree_ldate() {
		return free_ldate;
	}
	public void setFree_ldate(String free_ldate) {
		this.free_ldate = free_ldate;
	}
	public int getFree_type() {
		return free_type;
	}
	public void setFree_type(int free_type) {
		this.free_type = free_type;
	}
	

	
	
}
