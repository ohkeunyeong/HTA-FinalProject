package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Nong_Co;

@Repository
public class Nong_CoDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount(int num) {
		return sqlSession.selectOne("Nong_Cos.count", num);
	}

	public List<Nong_Co> getCommentList(Map<String, Object> map) {
		return sqlSession.selectList("Nong_Cos.getList", map);
	}

	public int commentsInsert(Nong_Co co) {
		return sqlSession.insert("Nong_Cos.insert", co);
	}

	public int commentDelete(int num) {
		return sqlSession.delete("Nong_Cos.delete", num);
	}

	public int commentUpdate(Nong_Co co) {
		return sqlSession.update("Nong_Cos.update", co);
	}

}
