package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Jik;

public interface JikService {
	
	// 글의 갯수 구하기
	public int getListCount();
	
	// 글 목록 보기
	public List<Jik> getJikList(int page, int limit);
	
	// 글 내용 보기
	public Jik getDetail(int num);
	
	// 글 답변
	public int jikReply(Jik jik);
	
	// 글 수정
	public int jikModify(Jik modifyjik);
	
	// 글 삭제
	public int jikDelete(int num);
	
	// 조회수 업데이트
	public int setReadCountUpdate(int num);
	
	// 글쓴이인지 확인
	public boolean isJikWriter(int num, String pass);
	
	// 글 등록하기
	public void insertJik(Jik jik);

	//Jik_RE_SEQ값 수정
	public int jikReplyUpdate(Jik jik);

	
}
