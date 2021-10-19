package com.hta.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.FreeDAO;
import com.hta.project.domain.Free;
import com.hta.project.domain.Free_File;

@Service
public class FreeServiceImpl implements FreeService{

	@Autowired
	private FreeDAO dao;

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Free> getFreeList(int page, int limit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getFreeList(map);
	}

	@Override
	public Free getDetail(int num, String id) {
		if(setReadCountUpdate(num)!=1)
			return null;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("id", id);
		return dao.getDetail(map);
	}

	
	@Override
	public int FreeModify(Free modifyfree) {
		return dao.FreeModify(modifyfree);
	}

	@Override
	public int FreeDelete(int free_num) {
		int result = 0;
		Free free = dao.getDetail(free_num);
		if(free != null) {
			result=dao.FreeDelete(free);
		}
		return result;
	}

	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public void insertFree(Free free) {
		dao.insertFree(free);
	}

	@Override
	public int insert_deleteFile(String before_file) {
		return dao.insert_deleteFile(before_file);
		
	}

	@Override
	public Free getDetail2(int num) {
		if(setReadCountUpdate(num)!=1)
			return null;
		return dao.getDetail(num);
	}

	@Override
	public List<Free> getFreeListSearchList(int page, int limit, int type, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow + limit -1 ;
		
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("type", type);
		
		if(type!=-1) {
			String[] search_field = new String[] {"(free_subject || free_content)","free_subject", "free_content", "nick"};
			map.put("search_field", search_field[type]);
			map.put("search_word", "%" + search + "%");
		}
		return dao.getFreeListSearchList(map);
	}

	@Override
	public int getSearchListCount(int type, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(type!=-1) {
			String[] search_field = new String[] {"(free_subject || free_content)","free_subject", "free_content", "nick"};
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
	public void insert_FreeFile(int free_num, String originalFileName, String savedFileName) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("free_num",free_num);
		map.put("free_file", savedFileName);
		map.put("free_original", originalFileName);
		dao.insert_FreeFile(map);
	}

	@Override
	public List<Free_File> getFile(int num) {
		return 	dao.getFile(num);
	}


}
