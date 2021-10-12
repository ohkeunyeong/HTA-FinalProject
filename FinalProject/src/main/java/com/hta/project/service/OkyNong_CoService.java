package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Nong_Co;

public interface OkyNong_CoService {
	
	//글의 갯수 구하기
	public int getListCount(int num);
	
	//댓글 목록 가져오기
	public List<Nong_Co> getCommentList(int nong_num, int page, String name);

	// 댓글 입력
	public int commentsInsert(Nong_Co co);
	
	//댓글삭제
	public int commentsDelete(int num);

	//댓글수정
	public int commentsUpdate(Nong_Co co);


}
