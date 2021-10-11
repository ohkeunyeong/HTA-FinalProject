package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public Nong getDetail(int num) {
		if(setReadCountUpdate(num)!=1)
			   return null;
		    return dao.getDetail(num);
		}

	private int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public int boardReply(Nong nong) {
		boardReplyUpdate(nong);
		nong.setNong_re_lev(nong.getNong_re_lev()+1);
		nong.setNong_re_seq(nong.getNong_re_seq()+1);
		return dao.baordReply(nong);
	}

	private int boardReplyUpdate(Nong nong) {
		return dao.boardReplyUpdate(nong);		
	}

	@Override
	public boolean isBoardWriter(int nong_num, String nong_pass) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", nong_num);
		map.put("pass", nong_pass);
		Nong result = dao.isBoardWriter(map);
		if (result == null)
			return false;
		else
		return true;
	}
	
}
