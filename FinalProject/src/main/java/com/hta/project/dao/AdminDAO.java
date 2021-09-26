package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Member;
import com.hta.project.domain.Notice;
import com.hta.project.domain.OkyMynong;

@Repository
public class AdminDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insert(Notice notice) {
		return sqlSession.insert("Notices.insert", notice);
	}

	public int setReadCountUpdate(int num) {
		return sqlSession.update("Notices.readCountUpdate", num);
	}

	public Notice getDetail(int num) {
		return sqlSession.selectOne("Notices.detail", num);
	}

	public int getListCount() {
		return sqlSession.selectOne("Notices.count");
	}

	public List<Notice> getNoticeList(Map<String, Integer> map) {
		return sqlSession.selectList("Notices.list", map);
	}

	public int noticeFixUpdate(Map<String, Object> map) {
		return sqlSession.update("Notices.fixUpdate", map);
	}

	public Notice noticeSelect(int num) {
		return sqlSession.selectOne("Notices.select", num);
	}

	public int getSearchListCount(String word) {
		return sqlSession.selectOne("Notices.searchListCount", word);
	}

	public List<Notice> getSearchNoticeList(Map<String, Object> map) {
		return sqlSession.selectList("Notices.searchList", map);
	}

	public int noticeSelectionDel(Map<String, Object> map) {
		return sqlSession.delete("Notices.selectionDel", map);
	}

	public int noticeDelete(int num) {
		return sqlSession.delete("Notices.delete", num);
	}

	public int noticeModify(Notice notice) {
		return sqlSession.update("Notices.noticeModify", notice);
	}

}
