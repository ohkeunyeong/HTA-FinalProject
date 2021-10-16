package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Member;

@Repository
public class MynongDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insert(String name) { // 내 농장생성
		return sqlSession.insert("Mynong.insert", name);
	}

	public String isName(String mynong_name) {// 내 농장 이름중복확인
		return sqlSession.selectOne("Mynong.select", mynong_name);
	}

	public String isId(String id) {// 아이디 검색
		return sqlSession.selectOne("Mynong.selectid", id);
	}

	public List<Member> getUserList(Member member) {// 멤버 아이디와 닉 검색
		return sqlSession.selectList("Mynong.list", member);
	}

	public void insertNongName(Member member) { // 농장 생성후 회원 정보에 농장 이름 넣기
		sqlSession.update("Mynong.addnong", member);

	}

	public int insertusertonong(Member member) {
		return sqlSession.update("Mynong.insertusertonong", member);
	}

	public List<Member> checkid(Member member) {
		return sqlSession.selectList("Mynong.checkid", member);
	}

	public List<Member> getUserList2(Member member) {
		return sqlSession.selectList("Mynong.list2", member);
	}

	public List<Member> getUserList3(Map<String, Object> map) {
		return sqlSession.selectList("Mynong.list3", map);
	}

	public int getSearchListCount(Map<String, Object> map) {
		return sqlSession.selectOne("Mynong.searchCount", map);
	}

	public String checkmyfarm(String id) {
		return sqlSession.selectOne("Mynong.checkmyfarm", id);
	}

	public String getMynong(String id) {
		return sqlSession.selectOne("Mynong.getmynong", id);
	}

	public Member memberinfo(String id) {
		return sqlSession.selectOne("Mynong.memberinfo", id);
	}

	public void delete(String id) {
		sqlSession.update("Mynong.deletenongmen", id);
	}

	public void changeoption(Map<String, Object> map) {
		sqlSession.update("Mynong.changeoption", map);

	}

	public void deletenongmember(String name) {
		sqlSession.update("Mynong.deletenongmember", name);
	}

	public void deletenong(String name) {
		sqlSession.delete("Mynong.deletenong", name);
	}

	public int getSerachListAdminCount(Map<String, Object> map) {
		return sqlSession.selectOne("Mynong.searchAdminCount", map);
	}

	public void okinvite(String id) {
		sqlSession.update("Mynong.okinvite", id);

	}

}
