package com.hta.project.domain;

public class Notice {
	private int	NOTICE_NUM;
	private String NOTICE_SUBJECT;
	private String NOTICE_CONTENT;
	private int NOTICE_READCOUNT;
	private String NOTICE_DATE;
	private String NOTICE_FIX;
	
	public int getNOTICE_NUM() {
		return NOTICE_NUM;
	}
	
	public void setNOTICE_NUM(int nOTICE_NUM) {
		NOTICE_NUM = nOTICE_NUM;
	}
	
	public String getNOTICE_SUBJECT() {
		return NOTICE_SUBJECT;
	}
	
	public void setNOTICE_SUBJECT(String nOTICE_SUBJECT) {
		NOTICE_SUBJECT = nOTICE_SUBJECT;
	}
	
	public String getNOTICE_CONTENT() {
		return NOTICE_CONTENT;
	}
	
	public void setNOTICE_CONTENT(String nOTICE_CONTENT) {
		NOTICE_CONTENT = nOTICE_CONTENT;
	}
	
	public int getNOTICE_READCOUNT() {
		return NOTICE_READCOUNT;
	}
	
	public void setNOTICE_READCOUNT(int nOTICE_READCOUNT) {
		NOTICE_READCOUNT = nOTICE_READCOUNT;
	}
	
	public String getNOTICE_DATE() {
		return NOTICE_DATE;
	}
	
	public void setNOTICE_DATE(String nOTICE_DATE) {
		NOTICE_DATE = nOTICE_DATE;
	}
	
	public String getNOTICE_FIX() {
		return NOTICE_FIX;
	}
	
	public void setNOTICE_FIX(String nOTICE_FIX) {
		NOTICE_FIX = nOTICE_FIX;
	}
	
}
