package com.hta.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OkyMycalDAO;
import com.hta.project.domain.MyCalendar;

@Service
public class OkyCalServiceImpl implements OkyCalService{
	
	@Autowired
	private OkyMycalDAO dao;
	
	@Override
	public boolean insertCal(MyCalendar calendar) {
		return dao.insertCal(dao);
	}

	@Override
	public List<MyCalendar> calboardList(String name, String yyyyMMdd) {
		return dao.calboardList(name, yyyyMMdd);
	}

	@Override
	public MyCalendar calDetail(int seq) {
		return null;
	}

	@Override
	public boolean calUpdate(MyCalendar dto) {
		return false;
	}

	@Override
	public boolean calMuldel(String[] seq) {
		return false;
	}

	@Override
	public int calCount(String name, String yyyyMMdd) {
		return 0;
	}

	@Override
	public List<MyCalendar> calViewList(String name, String yyyyMM) {
		return null;
	}
	


}
