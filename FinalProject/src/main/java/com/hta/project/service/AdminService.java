package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Notice;

public interface AdminService {

	void insert(Notice notice);

	Notice getDetail(int num);
	
	public int setReadCountUpdate(int num);

	int getListCount();

	List<Notice> getNoticeList(int page, int limit);

	int noticeFixUpdate(int num, String fix);
	
	Notice noticeSelect(int num);

	int getSearchListCount(String search_word);

	List<Notice> getSearchNoticeList(int page, int limit, String search_word);

	int noticeSelectionDel(int[] noticeArr);

	int noticeDelete(int num);

	int noticeModify(Notice notice);
	
}
