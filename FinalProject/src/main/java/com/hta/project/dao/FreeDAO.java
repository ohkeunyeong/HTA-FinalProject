package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Free;
import com.hta.project.domain.Free_File;

@Repository
public class FreeDAO {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getListCount() {
		return sqlSession.selectOne("Frees.count");
	}

	public void insertFree(Free free) {
		sqlSession.insert("Frees.insert", free);
	}

	public List<Free> getFreeList(HashMap<String, Integer> map) {
		return sqlSession.selectList("Frees.list", map);
	}

	public Free getDetail(HashMap<String, Object> map) {
		return sqlSession.selectOne("Frees.detail", map);
		
	}

	public int setReadCountUpdate(int num) {
		return sqlSession.update("Frees.readCountUpdate", num);
	}

	public int FreeReply(Free free) {
		return sqlSession.insert("Frees.reply_insert", free);
	}

	public int FreeReplyUpdate(Free free) {
		return sqlSession.update("Frees.reply_update", free);
	}

	public Free isFreeWriter(Map<String, Object> map) {
		return sqlSession.selectOne("Frees.freeWriter", map);
	}

	public int FreeModify(Free modifyfree) {
		
		return sqlSession.update("Frees.modify",modifyfree);
	}

	public int FreeDelete(Free free) {
		
		return sqlSession.delete("Frees.delete",free);
	}

	public int insert_deleteFile(String before_file) {
		return sqlSession.insert("Frees.insert_deleteFile", before_file);
		
	}

	public Free getDetail(int num) {
		return sqlSession.selectOne("Frees.detail2", num);
	}

	public List<Free> getFreeListSearchList(HashMap<String, Object> map) {
		return sqlSession.selectList("Frees.list2", map);
	}

	public int getSearchListCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("Frees.count2",map);
	}

	public int isLike(HashMap<String, Object> map) {
		return sqlSession.selectOne("Frees.isLike",map);
	}

	public int Like(HashMap<String, Object> map) {
		return sqlSession.insert("Frees.like", map);
	}

	public int dLike(HashMap<String, Object> map) {
		return sqlSession.delete("Frees.dlike", map);
	}

	public void LikeUp(int num) {
		sqlSession.update("Frees.LikeUp", num);
	}

	public void LikeDown(int num) {
		sqlSession.update("Frees.LikeDown", num);
	}


	public void insert_FreeFile(HashMap<String, Object> map) {
		sqlSession.insert("Frees.insertFile", map);
	}

	public List<Free_File> getFile(int num) {
		return sqlSession.selectList("Frees.getFile", num);
	}


	
	
}
