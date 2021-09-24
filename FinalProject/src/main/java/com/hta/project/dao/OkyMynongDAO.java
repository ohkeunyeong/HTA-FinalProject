package com.hta.project.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.OkyImsi;

@Repository
public class OkyMynongDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insert(String name) { //내 농장생성
		return sqlSession.insert("Mynong.insert" , name);
	}

	public String isName(String MYNONG_NAME) {//내 농장 이름중복확인
		return sqlSession.selectOne("Mynong.select", MYNONG_NAME);
	}

	public String isId(String id) {// 아이디 검색
		return sqlSession.selectOne("Mynong.selectid", id);
	}

	public List<OkyImsi> getUserList(String id) {//멤버 아이디와 닉 검색
		return sqlSession.selectList("Mynong.list", id);
	}


	public void insertNongName(OkyImsi okyimsi) { //농장 생성후 회원 정보에 농장 이름 넣기
		sqlSession.update("Mynong.addnong", okyimsi);
		
	}

}
