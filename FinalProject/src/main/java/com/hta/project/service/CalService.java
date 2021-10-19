package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.MyCalendar;

public interface CalService {

	// 일정추가하기 : insert문 ,파라미터 id, title, content, mdate 4개의 값을 받는다
	public boolean insertCal(MyCalendar calendar);

	// 일정목록조회하기: select문, 결과:List, 파라미터 id, yyyyMMdd
	public List<MyCalendar> calboardList(String name, String yyyyMMdd);

	// 일정상세보기: select문, 결과:CalDto, 파라미터 :seq
	public MyCalendar calDetail(int seq);

	// 일정수정하기
	public boolean calUpdate(MyCalendar calednar);

	// 일정삭제하기(여러개/한개 삭제하기)
	public boolean calMuldel(String[] seq);

	// 일정의 개수조회하기: select문, 파라미터 : id, yyyyMMdd
	public int calCount(String name, String yyyyMMdd);

	// 달력에 존재하는 일정조회하기(일일별 최대 3개씩 가져오기)
	public List<MyCalendar> calViewList(String name, String yyyyMM);

}
