package com.hta.project.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OkyNong_CoDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;	
	
	public int getListCount(int num) {
		return sqlSession.selectOne("Nong_Cos.count", num);
	}

}
