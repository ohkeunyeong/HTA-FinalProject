package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.OkyImsi;

public interface OkyMynongService {
	
	//농장 이름 생성
	public int insertName(String name);

	//농장 이름 중복확인
	public int isName(String MYNONG_NAME);
	
	//아이디 검색
	public int isId(String id);
	
	//유저 아이디랑 닉네임 가져오기
	public List<OkyImsi> getUserList(String id);
	
	//생성된 농장이름 유저 정보에 넣기
	public void insertNongName(OkyImsi okyimsi);
	



}
