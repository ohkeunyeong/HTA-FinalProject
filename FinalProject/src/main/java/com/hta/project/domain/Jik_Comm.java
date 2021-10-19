
package com.hta.project.domain;

public class Jik_Comm {
	private int jik_comm_num;
	private String jik_board_num;    
	private String id;
	private String nick;  
	private String jik_comm_content; 
	private String jik_comm_date;
	private int jik_comm_re_ref;
	private int jik_comm_re_lev;	
	private int jik_comm_re_seq;  
	private String jik_comm_secret;
	private int state;
	private String jik_id;
	private String comm_nick;
	
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getJik_comm_num() {
		return jik_comm_num;
	}
	public void setJik_comm_num(int jik_comm_num) {
		this.jik_comm_num = jik_comm_num;
	}
	public String getJik_board_num() {
		return jik_board_num;
	}
	public void setJik_board_num(String jik_board_num) {
		this.jik_board_num = jik_board_num;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getJik_comm_content() {
		return jik_comm_content;
	}
	public void setJik_comm_content(String jik_comm_content) {
		this.jik_comm_content = jik_comm_content;
	}
	public String getJik_comm_date() {
		return jik_comm_date;
	}
	public void setJik_comm_date(String jik_comm_date) {
		this.jik_comm_date = jik_comm_date;
	}
	public int getJik_comm_re_ref() {
		return jik_comm_re_ref;
	}
	public void setJik_comm_re_ref(int jik_comm_re_ref) {
		this.jik_comm_re_ref = jik_comm_re_ref;
	}
	public int getJik_comm_re_lev() {
		return jik_comm_re_lev;
	}
	public void setJik_comm_re_lev(int jik_comm_re_lev) {
		this.jik_comm_re_lev = jik_comm_re_lev;
	}
	public int getJik_comm_re_seq() {
		return jik_comm_re_seq;
	}
	public void setJik_comm_re_seq(int jik_comm_re_seq) {
		this.jik_comm_re_seq = jik_comm_re_seq;
	}
	public String getJik_comm_secret() {
		return jik_comm_secret;
	}
	public void setJik_comm_secret(String jik_comm_secret) {
		this.jik_comm_secret = jik_comm_secret;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getJik_id() {
		return jik_id;
	}
	public void setJik_id(String jik_id) {
		this.jik_id = jik_id;
	}
	public String getComm_nick() {
		return comm_nick;
	}
	public void setComm_nick(String comm_nick) {
		this.comm_nick = comm_nick;
	}
	
	
}
