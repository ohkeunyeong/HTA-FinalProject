package com.hta.project.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OkyMynongDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsSession;

	public int insert(String name) {
		return sqlsSession.insert("Mynong.insert" , name);
	}

	public String isName(String MYNONG_NAME) {
		return sqlsSession.selectOne("Mynong.select", MYNONG_NAME);
	}

}
