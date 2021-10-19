
package com.hta.project.domain;

public class Jik {
	private int jik_num;
	private String jik_id;    
	private String nick;    
	private String jik_subject;  
	private String jik_content; 
	private int jik_readcount;
	private int jik_like;
	private String jik_date;
	private int cnt;
	private String profile;
	private String jik_ldate;
	
	public int getJik_num() {
		return jik_num;
	}
	public void setJik_num(int jik_num) {
		this.jik_num = jik_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getJik_subject() {
		return jik_subject;
	}
	public void setJik_subject(String jik_subject) {
		this.jik_subject = jik_subject;
	}
	public String getJik_content() {
		return jik_content;
	}
	public void setJik_content(String jik_content) {
		this.jik_content = jik_content;
	}
	public int getJik_readcount() {
		return jik_readcount;
	}
	public void setJik_readcount(int jik_readcount) {
		this.jik_readcount = jik_readcount;
	}
	public int getJik_like() {
		return jik_like;
	}
	public void setJik_like(int jik_like) {
		this.jik_like = jik_like;
	}
	public String getJik_date() {
		return jik_date;
	}
	public void setJik_date(String jik_date) {
		this.jik_date = jik_date.substring(0,10);
	}
	public String getJik_id() {
		return jik_id;
	}
	public void setJik_id(String jik_id) {
		this.jik_id = jik_id;
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
	public String getJik_ldate() {
		return jik_ldate;
	}
	public void setJik_ldate(String jik_ldate) {
		this.jik_ldate = jik_ldate;
	}
	


	
	
}
