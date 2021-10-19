package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Nong;

@Repository
public class NongDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount(String name) {
		return sqlSession.selectOne("Nongs.count", name);
	}

	public List<Nong> getBoardList(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.list", map);
	}

	public void insertBoard(Nong nong) {
		sqlSession.insert("Nongs.insert", nong);

	}

	public int setReadCountUpdate(int num) {
		return sqlSession.update("Nongs.readCountUpdate", num);
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

	public int boardModify(Nong nong) {
		return sqlSession.update("Nongs.modify", nong);
	}

	public int insert_deleteFile(String before_file) {
		return sqlSession.insert("Nongs.insert_deleteFile", before_file);
	}

	public int boardDelete(Nong nong) {
		return sqlSession.delete("Nongs.delete", nong);
	}

	public List<String> getDeleteFileList() {
		return sqlSession.selectList("Nongs.deleteFileList");
	}

	public List<Nong> getajaxBoardList1(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.ajaxlist1", map);
	}

	public List<Nong> getajaxBoardList2(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.ajaxlist2", map);
	}

	public List<Nong> getajaxBoardList3(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.ajaxlist3", map);
	}

	public List<Nong> getBoardSearchList1(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.searchlist1", map);
	}

	public List<Nong> getBoardSearchList2(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.searchlist2", map);
	}

	public List<Nong> getBoardSearchList3(HashMap<String, Object> map) {
		return sqlSession.selectList("Nongs.searchlist3", map);
	}

	public int getSearchListCount(HashMap<String, Object> map) {
		return sqlSession.selectOne("Nongs.searchlistcount", map);
	}

}
