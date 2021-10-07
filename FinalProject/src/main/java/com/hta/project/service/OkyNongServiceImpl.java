package com.hta.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyNongDAO;
import com.hta.project.domain.Nong;

@Service
public class OkyNongServiceImpl implements OkyNongService{
	
	@Autowired
	private OkyNongDAO dao;
	
	@Override
	public int getListCount(String name) {
		return dao.getListCount(name);
	}

	@Override
	public List<Nong> getBoardList(String name, int page, int limit) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow + limit -1 ;
		map.put("name", name);
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getBoardList(map);
	}

	@Override
	public void insertBoard(Nong nong) {
		dao.insertBoard(nong);
		
	}
}
