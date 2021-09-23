package com.hta.project.service;

public interface OkyMynongService {
	
	//농장 이름 생성
	public int insertName(String name);

	//농장 이름 중복확인
	public int isName(String MYNONG_NAME);
	
	//아이디 검색
	public int isId(String id);



}
