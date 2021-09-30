package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.Jik_CommDAO;
import com.hta.project.domain.Jik_Comm;



@Service
public class Jik_CommServiceImpl implements Jik_CommService{

	@Autowired
	private Jik_CommDAO dao;
	
	@Override
	public int getListCount(int board_num) {
		return dao.getListCount(board_num);
	}

	@Override
	public List<Jik_Comm> getJik_CommList(int jik_num, int page) {
		int startrow=1;
		int endrow=page*3;
		
		Map<String,Integer> map =new HashMap<String,Integer>();
		map.put("jik_num",jik_num);
		map.put("start",startrow);
		map.put("end",endrow);
		return dao.getCommnetList(map);
	}

	@Override
	public int Jik_CommsInsert(Jik_Comm co) {
		
		return dao.Jik_CommsInsert(co);
	}

	@Override
	public int Jik_CommsDelete(int jik_comm_num) {
		return dao.Jik_CommsDelete(jik_comm_num);
	}

	@Override
	public int Jik_CommsUpdate(Jik_Comm co) {
		return dao.Jik_CommsUpdate(co);
	}

}
