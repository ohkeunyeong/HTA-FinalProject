package com.hta.project.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OkyMynongDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsSession;

	public int insert(String name) { //내 농장생성
		return sqlsSession.insert("Mynong.insert" , name);
	}

	public String isName(String MYNONG_NAME) {//내 농장 이름중복확인
		return sqlsSession.selectOne("Mynong.select", MYNONG_NAME);
	}

	public String isId(String id) {// 아이디 검색
		return sqlsSession.selectOne("Mynong.selectid", id);
	}

}
