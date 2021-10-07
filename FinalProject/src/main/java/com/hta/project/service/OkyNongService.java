package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Nong;

public interface OkyNongService {

	// 글의 갯수 구하기
	int getListCount(String name);
	
	// 글 목록 보기
	List<Nong> getBoardList(String name, int page, int limit);
	
	// 글 등록하기
	void insertBoard(Nong nong);

}
