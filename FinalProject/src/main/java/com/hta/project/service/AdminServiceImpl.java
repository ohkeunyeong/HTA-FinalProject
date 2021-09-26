package com.hta.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.AdminDAO;
import com.hta.project.domain.Member;
import com.hta.project.domain.Notice;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDAO dao = new AdminDAO();
	
	@Override
	public void insert(Notice notice) {
		dao.insert(notice);
	}

	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public Notice getDetail(int num) {
		if(setReadCountUpdate(num) != 1) {
			return null;
		}
		
		return dao.getDetail(num);
	}

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Notice> getNoticeList(int page, int limit) {
		List<Notice> list = new ArrayList<Notice>();
		Map<String, Integer> map = new HashMap<String, Integer>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		
		list = dao.getNoticeList(map);
		
		return list;
	}

	@Override
	public int noticeFixUpdate(int num, String fix) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("fix", fix);
		return dao.noticeFixUpdate(map);
	}

	@Override
	public Notice noticeSelect(int num) {
		return dao.noticeSelect(num);
	}

	@Override
	public int getSearchListCount(String search_word) {
		String word = "%" + search_word + "%";
		return dao.getSearchListCount(word);
	}

	@Override
	public List<Notice> getSearchNoticeList(int page, int limit, String search_word) {
		List<Notice> list = new ArrayList<Notice>();
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		String word = "%" + search_word + "%";
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("word", word);
		
		list = dao.getSearchNoticeList(map);
		
		return list;
	}

	@Override
	public int noticeSelectionDel(int[] noticeArr) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("arr", noticeArr);
		return dao.noticeSelectionDel(map);
	}

	@Override
	public int noticeDelete(int num) {
		return dao.noticeDelete(num);
	}

	@Override
	public int noticeModify(Notice notice) {
		return dao.noticeModify(notice);
	}


}
