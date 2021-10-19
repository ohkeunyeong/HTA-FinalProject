package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.Free_CommDAO;
import com.hta.project.domain.Free_Comm;



@Service
public class Free_CommServiceImpl implements Free_CommService{

	@Autowired
	private Free_CommDAO dao;
	
	@Override
	public int getListCount(int board_num) {
		return dao.getListCount(board_num);
	}

	@Override
	public List<Free_Comm> getFree_CommList(int free_num, int page, int state) {
		int startrow=1;
		int endrow=page*5;
		
		Map<String,Integer> map =new HashMap<String,Integer>();
		map.put("state", state);
		map.put("free_num",free_num);
		map.put("start",startrow);
		map.put("end",endrow);
		return dao.getCommnetList(map);
	}

	@Override
	public int Free_CommsInsert(Free_Comm co) {
		
		return dao.Free_CommsInsert(co);
	}

	@Override
	public int Free_CommsDelete(int free_comm_num) {
		return dao.Free_CommsDelete(free_comm_num);
	}

	@Override
	public int Free_CommsUpdate(Free_Comm co) {
		return dao.Free_CommsUpdate(co);
	}

	@Override
	public int Free_CommsReply(Free_Comm co) {
		Free_CommsReplyUpdate(co);
		co.setFree_comm_re_lev(co.getFree_comm_re_lev()+1);
		co.setFree_comm_re_seq(co.getFree_comm_re_seq()+1);
		return dao.Free_CommsReply(co);
	}

	@Override
	public int Free_CommsReplyUpdate(Free_Comm co) {
		return dao.Free_CommsReplyUpdate(co);
	}

	@Override
	public int Free_comm_ref_select(int free_comm_num) {
		
		return dao.Free_comm_ref_select(free_comm_num);
	}

	@Override
	public int Free_comm_ref_select2(int select) {
		
		return dao.Free_comm_ref_select2(select);
	}

	@Override
	public int Free_CommsDelete2(int free_comm_num) {
		
		return dao.Free_CommsDelete2(free_comm_num);
	}

	

}
