package com.hta.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyNong_CoDAO;

@Service
public class OkyNong_CoServiceImpl implements OkyNong_CoService{
	
	@Autowired
	private OkyNong_CoDAO dao;

	@Override
	public int getListCount(int num) {
		return dao.getListCount(num);
	}
}
