package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Nong;

@Repository
public class OkyNongDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getListCount(String name) {
		return sqlSession.selectOne("Nongs.count" ,name);
	}

	public List<Nong> getBoardList(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.list", map);
	}

	public void insertBoard(Nong nong) {
		sqlSession.insert("Nongs.insert", nong);
		
	}

}
