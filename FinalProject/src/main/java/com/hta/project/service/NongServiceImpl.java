package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.NongDAO;
import com.hta.project.domain.Nong;

@Service
public class NongServiceImpl implements NongService{
	
	@Autowired
	private NongDAO dao;
	
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

	@Override
	public int boardModify(Nong nong) {
		return dao.boardModify(nong);
	}

	@Override
	public int insert_deleteFile(String before_file) {
		return dao.insert_deleteFile(before_file);
	}

	@Override
	public int boardDelete(int num) {
		int result = 0;
		Nong nong = dao.getDetail(num);
		if(nong != null) {
			result=dao.boardDelete(nong);
			
		   //추가 - 삭제할 파일 목록들을 저장하기 위한 메서드 호출
			if(nong.getNong_file()!=null)
				dao.insert_deleteFile(nong.getNong_file());
		}
		return result;
	}

	@Override
	public List<String> getDeleteFileList() {
		return dao.getDeleteFileList();
	}

	@Override
	public List<Nong> getBoardList(int page, int limit, String view, String name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow + limit -1 ;
		map.put("name", name);
		map.put("start", startrow);
		map.put("end", endrow);
		if(view.equals("1")) {//최신순
			return dao.getajaxBoardList1(map);
		}else if(view.equals("2")) {//등록순
			return dao.getajaxBoardList2(map);
		}else if(view.equals("3")) {//조회순
			return dao.getajaxBoardList3(map);
		}
		return null;		
	}

	@Override
	public List<Nong> getBoardSearchList(int page, int limit, String type, String search, String view, String name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow + limit -1 ;
		map.put("name", name);
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("search", search);
		map.put("type", type);
		if(view.equals("1")) {//최신순
		return dao.getBoardSearchList1(map);
		}else if(view.equals("2")){//등록순
		return dao.getBoardSearchList2(map);	
		}else if(view.equals("3")){//조회순
		return dao.getBoardSearchList3(map);	
		}
		return null;
	}

	@Override
	public int getSearchListCount(String type, String search, String name) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		map.put("search", search);
		map.put("type", type);
		return dao.getSearchListCount(map);
	}
	
}
