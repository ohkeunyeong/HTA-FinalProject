package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Account;

public interface AccService {

	// 가계부추가하기
	boolean insertacc(Account account);

	// 가계부 목록 조회하기
	List<Account> accViewList(String name, String yyyyMM);

	// 선택된 가계부 정보 보기
	Account accDetail(int seq);

	// 가계부 삭제
	boolean accDelete(int seq);

	// 가게부 수정하기
	boolean accUpdate(Account account);

}
