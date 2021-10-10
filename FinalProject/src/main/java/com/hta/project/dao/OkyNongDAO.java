package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public int setReadCountUpdate(int num) {
		return sqlSession.update("Nongs.readCountUpdate",num);
	}

	public Nong getDetail(int num) {
		return sqlSession.selectOne("Nongs.detail", num);
	}

	public int boardReplyUpdate(Nong nong) {
		return sqlSession.update("Nongs.reply_update", nong);
	}

	public int baordReply(Nong nong) {
		return sqlSession.insert("Nongs.reply_insert", nong);
	}

	public Nong isBoardWriter(Map<String, Object> map) {
		return sqlSession.selectOne("Nongs.boardWriter", map);
	}

}
