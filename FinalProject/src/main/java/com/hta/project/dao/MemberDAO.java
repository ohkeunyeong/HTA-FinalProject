package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Member;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getSearchListCount(String word) {
		return sqlSession.selectOne("Members.searchListCount", word);
	}
	
	public List<Member> getSearchList(Map<String, Object> map){
		return sqlSession.selectList("Members.searchList", map);
	}

	public int getListCount() {
		return sqlSession.selectOne("Members.count");
	}

	public List<Member> getUserList(Map<String, Integer> map) {
		return sqlSession.selectList("Members.list", map);
	}

	public Member member_info(String id) {
		return sqlSession.selectOne("Members.idcheck", id);
	}

	public void userDelete(String id) {
		sqlSession.delete("Members.delete", id);
	}

	public Member isId(String id) {
		return sqlSession.selectOne("Members.idcheck",id);
	}
	
	public Member isNick(String nick) {
		return sqlSession.selectOne("Members.nickcheck",nick);
	}

	public int insert(Member member) {
		return sqlSession.insert("Members.insert",member);
	}
	
	public int update(Member m) {
		return sqlSession.update("Members.update", m);
	}

	public String findid(Map<String, Object> map) {
		return sqlSession.selectOne("Members.findid", map);
	}

	public int findpw(Map<String, Object> map) {
		return sqlSession.update("Members.findpw", map);
	}

	

}
