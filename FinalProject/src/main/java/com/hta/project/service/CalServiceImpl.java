package com.hta.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.MycalDAO;
import com.hta.project.domain.MyCalendar;

@Service
public class CalServiceImpl implements CalService {

	@Autowired
	private MycalDAO dao;

	@Override
	public boolean insertCal(MyCalendar calendar) {
		return dao.insertCal(calendar);
	}

	@Override
	public List<MyCalendar> calboardList(String name, String yyyyMMdd) {
		return dao.calboardList(name, yyyyMMdd);
	}

	@Override
	public MyCalendar calDetail(int seq) {
		return dao.calDetail(seq);
	}

	@Override
	public boolean calUpdate(MyCalendar dto) {
		return dao.calUpdate(dto);
	}

	@Override
	public boolean calMuldel(String[] seq) {
		return dao.calMuldel(seq);
	}

	@Override
	public int calCount(String name, String yyyyMMdd) {
		return dao.calCount(name, yyyyMMdd);
	}

	@Override
	public List<MyCalendar> calViewList(String name, String yyyyMM) {
		return dao.calViewList(name, yyyyMM);
	}

}
