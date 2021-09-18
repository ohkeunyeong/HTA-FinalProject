package com.hta.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyMynongDAO;

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
		int result = -1;
		if(pan !=null) {
			result = 0;
		}
		return result;
	}

}
