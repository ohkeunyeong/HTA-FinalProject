package com.hta.project.service;

import java.util.List;
import java.util.Map;

import com.hta.project.domain.Member;

public interface MemberService {
	
	public Map<String, Object> isId(String id, String pass); // 우영님이 로그인 다 만들면 삭제
	
	public List<Member> getSearchList(String search_word,
			int page, int limit);

	public int getSearchListCount(String search_word);

	public int getListCount();

	public List<Member> getUserList(int page, int limit);

	public Member member_info(String id);

	public void delete(String id);

	//---------------------------------------chang 회원가입 작업영역--------------------
	public int isId(String id);

	public int insert(Member member);
	//---------------------------------------/chang 회원가입 작업영역--------------------
	

}
