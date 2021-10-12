package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Nong;

public interface OkyNongService {

	// 글의 갯수 구하기
	public int getListCount(String name);
	
	// 글 목록 보기
	public List<Nong> getBoardList(String name, int page, int limit);
	
	// 글 등록하기
	public void insertBoard(Nong nong);

	// 게시물 상세보기
	public Nong getDetail(int num);
	
	// 글 답변
	public int boardReply(Nong nong);
	
	// 글쓴이인지 확인
	public boolean isBoardWriter(int nong_num, String nong_pass);
	
	// 글 수정
	public int boardModify(Nong nong);

	//삭제할 파일을 삽입
	public int insert_deleteFile(String before_file);
	
	// 글 삭제
	public int boardDelete(int num);
	
	// 삭제할 파일 리스트 가져오기
	public List<String> getDeleteFileList();
	
	// 검색어 적용 안된 정렬 순 보여주기
	public List<Nong> getBoardList(int page, int limit, String view, String name);
	
	// 검색어 적용 된 정렬 순 보여주기
	public List<Nong> getBoardSearchList(int page, int limit, String type, String search, String view, String name);
	
	// 검색어 적용 된 게시물 전체 갯수 구하기
	public int getSearchListCount(String type, String search, String name);

}
