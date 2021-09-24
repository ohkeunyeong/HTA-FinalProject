package com.hta.project.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyMynongDAO;
import com.hta.project.domain.OkyImsi;

@Service
public class OkyMynongServiceImpl implements OkyMynongService {
	
	@Autowired
	private OkyMynongDAO dao;
	
	
	@Override
	public int insertName(String name) {
		return dao.insert(name);
	}


	@Override
	public int isName(String MYNONG_NAME) {
		String pan = dao.isName(MYNONG_NAME);
		int result = -1; //중복된 이름의 농장 없을경우
		if(pan !=null) { //농장 이름 중복
			result = 0;
		}
		return result;
	}


	@Override
	public int isId(String id) {
		String pan = dao.isId(id);
		int result = -1; //회원 아이디가 없을경우
		if(pan !=null) { //회원 아이디가 있을 경우
			result = 0;
		}
		return result;
	}


	@Override
	public List<OkyImsi> getUserList(String id) {
		return dao.getUserList(id);
	}


	@Override
	public void insertNongName(OkyImsi okyimsi) {
		dao.insertNongName(okyimsi);
		
	}
}
