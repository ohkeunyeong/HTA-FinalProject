package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Member;

public interface MynongService {
	
	//농장 이름 생성
	public int insertName(String name);

	//농장 이름 중복확인
	public int isName(String mynong_name);
	
	//아이디 검색
	public int isId(String id);
	
	//유저 아이디랑 닉네임 가져오기
	public List<Member> getUserList(Member member);
	
	//생성된 농장이름 유저 정보에 넣기
	public void insertNongName(Member member);
	
	//농장에 유저 추가 
	public int insertusertonong(Member member);

	
	//기존에 있는 유저인지 확인
	public List<Member> checkid(Member member);

	//해당 농장 유저 아이디랑 닉네임 가져오기
	public List<Member> getUserList2(Member member);
	
	//해당 농장 유저 아이디랑 닉네임 가져오기(관리자 본인 제외)
	public List<Member> getUserList3(int page, int limit, String name, String id);

	//해당 농장 모든 멤버 수 구해옴
	public int getSearchListCount(String name, String id);
	
	//MY_FARM 구하기
	public int checkmyfarm(String id);
	
	//아이디 소속됭 농장 이름 가져오기
	public String getMynong(String id);
	
	//멤버 모든 정보 가져오기
	public Member memberinfo(String id);
	
	//농장 멤버 삭제
	public void delete(String id);
	
	//농장 멤버 권한 변경
	public void changeoption(String userid, String optiontype);
	
	//농장 삭제 전 멤버 정보 기본으로 바꾸기
	public void deletenongmember(String name);

	//농장 삭제
	public void deletenong(String name);
	





	


}
