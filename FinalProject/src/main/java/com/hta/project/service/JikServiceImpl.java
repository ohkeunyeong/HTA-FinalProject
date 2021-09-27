package com.hta.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.JikDAO;
import com.hta.project.domain.Jik;

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
	public Jik getDetail(int num) {
		if(setReadCountUpdate(num)!=1)
			return null;
		return dao.getDetail(num);
	}

	
	@Override
	public int jikModify(Jik modifyjik) {
		return dao.jikModify(modifyjik);
	}

	@Override
	public int jikDelete(int num) {
		int result = 0;
		Jik jik = dao.getDetail(num);
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



}
