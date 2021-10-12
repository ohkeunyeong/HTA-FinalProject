package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Jik;

@Repository
public class JikDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getListCount() {
		return sqlSession.selectOne("Jiks.count");
	}

	public void insertJik(Jik jik) {
		sqlSession.insert("Jiks.insert", jik);
	}

	public List<Jik> getJikList(HashMap<String, Integer> map) {
		return sqlSession.selectList("Jiks.list", map);
	}

	public Jik getDetail(HashMap<String, Object> map) {
		return sqlSession.selectOne("Jiks.detail", map);
		
	}

	public int setReadCountUpdate(int num) {
		return sqlSession.update("Jiks.readCountUpdate", num);
	}

	public int jikReply(Jik jik) {
		return sqlSession.insert("Jiks.reply_insert", jik);
	}

	public int jikReplyUpdate(Jik jik) {
		return sqlSession.update("Jiks.reply_update", jik);
	}

	public Jik isJikWriter(Map<String, Object> map) {
		return sqlSession.selectOne("Jiks.jikWriter", map);
	}

	public int jikModify(Jik modifyjik) {
		
		return sqlSession.update("Jiks.modify",modifyjik);
	}

	public int jikDelete(Jik jik) {
		
		return sqlSession.delete("Jiks.delete",jik);
	}

	public int insert_deleteFile(String before_file) {
		return sqlSession.insert("Jiks.insert_deleteFile", before_file);
		
	}

	public Jik getDetail(int num) {
		return sqlSession.selectOne("Jiks.detail2", num);
	}
	
	
}
