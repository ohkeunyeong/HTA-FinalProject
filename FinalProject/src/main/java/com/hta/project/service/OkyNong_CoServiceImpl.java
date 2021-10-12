package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyNong_CoDAO;
import com.hta.project.domain.Nong_Co;

@Service
public class OkyNong_CoServiceImpl implements OkyNong_CoService{
	
	@Autowired
	private OkyNong_CoDAO dao;

	@Override
	public int getListCount(int num) {
		return dao.getListCount(num);
	}

	@Override
	public List<Nong_Co> getCommentList(int nong_num, int page, String name) {
		int startrow = 1;
		int endrow = page*3;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nong_num", nong_num);
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("name", name);
		return dao.getCommentList(map);
	}

	@Override
	public int commentsInsert(Nong_Co co) {
		return dao.commentsInsert(co);
	}

	@Override
	public int commentsDelete(int num) {
		return dao.commentDelete(num);
	}

	@Override
	public int commentsUpdate(Nong_Co co) {
		return dao.commentUpdate(co);
	}


}
