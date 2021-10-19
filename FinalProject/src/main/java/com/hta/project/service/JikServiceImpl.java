package com.hta.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.JikDAO;
import com.hta.project.domain.Jik;
import com.hta.project.domain.Jik_File;

@Service
public class JikServiceImpl implements JikService{

	@Autowired
	private JikDAO dao;

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Jik> getJikList(int page, int limit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getJikList(map);
	}

	@Override
	public Jik getDetail(int num, String id) {
		if(setReadCountUpdate(num)!=1)
			return null;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("id", id);
		return dao.getDetail(map);
	}

	
	@Override
	public int jikModify(Jik modifyjik) {
		return dao.jikModify(modifyjik);
	}

	@Override
	public int jikDelete(int jik_num) {
		int result = 0;
		Jik jik = dao.getDetail(jik_num);
		if(jik != null) {
			result=dao.jikDelete(jik);
		}
		return result;
	}

	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public void insertJik(Jik jik) {
		dao.insertJik(jik);
	}

	@Override
	public int insert_deleteFile(String before_file) {
		return dao.insert_deleteFile(before_file);
		
	}

	@Override
	public Jik getDetail2(int num) {
		if(setReadCountUpdate(num)!=1)
			return null;
		return dao.getDetail(num);
	}

	@Override
	public List<Jik> getJikListSearchList(int page, int limit, int type, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow + limit -1 ;
		
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("type", type);
		
		if(type!=-1) {
			String[] search_field = new String[] {"(jik_subject || jik_content)","jik_subject", "jik_content", "nick"};
			map.put("search_field", search_field[type]);
			map.put("search_word", "%" + search + "%");
		}
		return dao.getJikListSearchList(map);
	}

	@Override
	public int getSearchListCount(int type, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(type!=-1) {
			String[] search_field = new String[] {"(jik_subject || jik_content)","jik_subject", "jik_content", "nick"};
			map.put("search_field", search_field[type]);
			map.put("search_word", "%" + search + "%");
		}
		return dao.getSearchListCount(map);
	}

	@Override
	public int isLike(String id, int num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		return dao.isLike(map);
	}

	@Override
	public int like(int num, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		return dao.Like(map);
	}
	
	@Override
	public int dlike(int num, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("num", num);
		return dao.dLike(map);
	}

	@Override
	public void LikeUp(int num) {
		dao.LikeUp(num);
	}

	@Override
	public void LikeDown(int num) {
		dao.LikeDown(num);
	}

	@Override
	public void insert_JikFile(int jik_num, String originalFileName, String savedFileName) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("jik_num",jik_num);
		map.put("jik_file", savedFileName);
		map.put("jik_original", originalFileName);
		dao.insert_JikFile(map);
	}

	@Override
	public List<Jik_File> getFile(int num) {
		return 	dao.getFile(num);
	}


}
