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
	public List<OkyImsi> getUserList(OkyImsi okyimsi);
	
	//생성된 농장이름 유저 정보에 넣기
	public void insertNongName(OkyImsi okyimsi);
	
	//농장에 유저 추가 
	public int insertusertonong(OkyImsi okyimsi);

	
	//기존에 있는 유저인지 확인
	public List<OkyImsi> checkid(OkyImsi okyimsi);

	//해당 농장 유저 아이디랑 닉네임 가져오기
	public List<OkyImsi> getUserList2(OkyImsi okyimsi);
	
	//해당 농장 유저 아이디랑 닉네임 가져오기
	public List<OkyImsi> getUserList3(int page, int limit, String name);

	//해당 농장 모든 멤버 수 구해옴
	public int getSearchListCount(String name);




	



}
