package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.MynongDAO;
import com.hta.project.domain.Member;

@Service
public class MynongServiceImpl implements MynongService {

	@Autowired
	private MynongDAO dao;

	@Override
	public int insertName(String name) {
		return dao.insert(name);
	}

	@Override
	public int isName(String mynong_name) {
		String pan = dao.isName(mynong_name);
		int result = -1; // 중복된 이름의 농장 없을경우
		if (pan != null) { // 농장 이름 중복
			result = 0;
		}
		return result;
	}

	@Override
	public int isId(String id) {
		String pan = dao.isId(id);
		int result = -1; // 회원 아이디가 없을경우
		if (pan != null) { // 회원 아이디가 있을 경우
			result = 0;
		}
		return result;
	}

	@Override
	public List<Member> getUserList(Member member) {
		return dao.getUserList(member);
	}

	@Override
	public void insertNongName(Member member) {
		dao.insertNongName(member);

	}

	@Override
	public int insertusertonong(Member member) {
		return dao.insertusertonong(member);
	}

	@Override
	public List<Member> checkid(Member member) {
		return dao.checkid(member);
	}

	@Override
	public List<Member> getUserList2(Member member) {
		return dao.getUserList2(member);
	}

	@Override
	public List<Member> getUserList3(int page, int limit, String name, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("mynong_name", name);
		map.put("admin", id);
		return dao.getUserList3(map);
	}

	@Override
	public int getSearchListCount(String name, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("id", id);
		return dao.getSearchListCount(map);
	}

	@Override
	public int checkmyfarm(String id) {
		String pan = dao.checkmyfarm(id);
		if (pan == null) {
			pan = "0";
		}
		System.out.println("check farm은 " + pan);
		int ck = 0; // MY_FARM 값이 0인 경우
		if (pan.equals("1")) {// 관리자
			ck = 1;
		} else if (pan.equals("2")) {// 일반멤버
			ck = 2;
		} else if (pan.equals("3")) {// 가입대기멤버
			ck = 3;
		} else if (pan.equals("0")) {// 내농장 없는 멤버
			ck = 0;
		}
		return ck;
	}

	@Override
	public String getMynong(String id) {
		return dao.getMynong(id);
	}

	@Override
	public Member memberinfo(String id) {
		return dao.memberinfo(id);
	}

	@Override
	public void delete(String id) {
		dao.delete(id);
	}

	@Override
	public void changeoption(String userid, String optiontype) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", userid);
		map.put("option", optiontype);
		dao.changeoption(map);
	}

	@Override
	public void deletenongmember(String name) {
		dao.deletenongmember(name);
	}

	@Override
	public void deletenong(String name) {
		dao.deletenong(name);
	}

	@Override
	public int getSerachListAdminCount(String id, String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("id", id);
		return dao.getSerachListAdminCount(map);
	}

	@Override
	public void okinvite(String id) {
		dao.okinvite(id);

	}

}
