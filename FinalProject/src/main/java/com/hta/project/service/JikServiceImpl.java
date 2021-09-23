package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int jikReply(Jik jik) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int jikModify(Jik modifyjik) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int jikDelete(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int setReadCountUpdate(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean isJikWriter(int num, String pass) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void insertJik(Jik jik) {
		dao.insertJik(jik);
	}

	@Override
	public int jikReplyUpdate(Jik jik) {
		// TODO Auto-generated method stub
		return 0;
	}
	


}
