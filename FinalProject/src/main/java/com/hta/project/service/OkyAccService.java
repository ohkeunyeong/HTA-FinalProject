package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Account;


public interface OkyAccService {
	
	//가계부추가하기
	boolean insertacc(Account account);
	
	//가계부 목록 조회하기
	List<Account> accViewList(String name, String yyyyMM);



}
