package com.hta.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.AccDAO;
import com.hta.project.domain.Account;

@Service
public class AccServiceImpl implements AccService {

	@Autowired
	private AccDAO dao;

	@Override
	public boolean insertacc(Account account) {
		return dao.insertAcc(account);
	}

	@Override
	public List<Account> accViewList(String name, String yyyyMM) {
		return dao.accViewList(name, yyyyMM);
	}

	@Override
	public Account accDetail(int seq) {
		return dao.accDetail(seq);
	}

	@Override
	public boolean accDelete(int seq) {
		return dao.accDelete(seq);
	}

	@Override
	public boolean accUpdate(Account account) {
		return dao.accUpdate(account);
	}

}
