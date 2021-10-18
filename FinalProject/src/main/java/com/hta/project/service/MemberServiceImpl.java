package com.hta.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hta.project.dao.MemberDAO;
import com.hta.project.domain.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public Map<String, Object> isId(String id, String password) { 
		Map<String, Object> member = new HashMap<String, Object>();
		Member rmember = dao.isId(id);
		int result = -1;
		if(rmember != null) {
			if(passwordEncoder.matches(password, rmember.getPass())){
				result = 1;
			}else {
				result = 0;
			}
		}
		
		member.put("result", result);
		member.put("member", rmember);
		
		return member;
	}

	@Override
	public List<Member> getSearchList(String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("search_word", "%" + search_word + "%");
		
		return dao.getSearchList(map);
	}

	@Override
	public int getSearchListCount(String search_word) {
		String word = "%" + search_word + "%";
		return dao.getSearchListCount(word);
	}

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Member> getUserList(int page, int limit) {
		List<Member> list = new ArrayList<Member>();
		Map<String, Integer> map = new HashMap<String, Integer>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		
		list = dao.getUserList(map);
		
		return list;
	}

	@Override
	public Member member_info(String id) {
		return dao.member_info(id);
	}

	@Override
	public void delete(String id) {
		dao.userDelete(id);
	}
//-----------------chang 회원가입 작업 영역---------------------------
	@Override
	public int isId(String id) {
		Member rmember = dao.isId(id);
		return (rmember==null) ? -1 : 1; // -1은 아이디가 존재하지 않는 경우
										  // 1은 아이디가 존재하는 경우
	}

	@Override
	public int insert(Member member) {
		return dao.insert(member);
	}
//-----------------/chang 회원가입 작업 영역 ---------------------------
	
//-----------------/hyun 회원수정 작업 영역 ---------------------------
	
	@Override
	public int update(Member m) {
		return dao.update(m);
	}

//---------------------------------------/oky 아이디/비밀번호 찾기 작업영역--------------------
	@Override
	public String findid(String name, String tel, String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("tel", tel);
		map.put("email", email);
		return dao.findid(map);
	}

	@Override
	public int findpw(String name, String tel, String email, String encPassword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("tel", tel);
		map.put("email", email);
		map.put("pass", encPassword);
		return dao.findpw(map);
	}

	@Override
	public int isPass(String id, String pass) {
		Member member = dao.isId(id);
		int result = -1;
		if(member != null) {
			if(passwordEncoder.matches(pass, member.getPass())){
				result = 1;
			}else {
				result = 0;
			}
		}
		return result;
	}

	@Override
	public String OriginPass(String id , String pass) {
		Member member = dao.isId(id);
		String result = null;
		if(member != null) {
				result = member.getPass();
		}
		return result;
	}
}
