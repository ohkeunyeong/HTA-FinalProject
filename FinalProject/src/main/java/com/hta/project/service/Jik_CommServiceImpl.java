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
	public List<Jik_Comm> getJik_CommList(int jik_num, int page, int state) {
		int startrow=1;
		int endrow=page*5;
		
		Map<String,Integer> map =new HashMap<String,Integer>();
		map.put("state", state);
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

	@Override
	public int Jik_CommsReply(Jik_Comm co) {
		Jik_CommsReplyUpdate(co);
		co.setJik_comm_re_lev(co.getJik_comm_re_lev()+1);
		co.setJik_comm_re_seq(co.getJik_comm_re_seq()+1);
		return dao.Jik_CommsReply(co);
	}

	@Override
	public int Jik_CommsReplyUpdate(Jik_Comm co) {
		return dao.Jik_CommsReplyUpdate(co);
	}

	@Override
	public int Jik_comm_ref_select(int jik_comm_num) {
		
		return dao.Jik_comm_ref_select(jik_comm_num);
	}

	@Override
	public int Jik_comm_ref_select2(int select) {
		
		return dao.Jik_comm_ref_select2(select);
	}

	@Override
	public int Jik_CommsDelete2(int jik_comm_num) {
		
		return dao.Jik_CommsDelete2(jik_comm_num);
	}

	

}
