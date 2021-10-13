package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.MyCalendar;

@Repository
public class MycalDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//일정추가하기 : insert문 ,파라미터 id, title, content, mdate 4개의 값을 받는다
	public boolean insertCal(MyCalendar calendar) {
	int count= sqlSession.insert("Calendars.insertCal", calendar);	
		return count>0?true:false;	
	}
	
	
	//일정목록조회하기: select문, 결과:List, 파라미터 id, yyyyMMdd
	public List<MyCalendar> calboardList(String name, String yyyyMMdd){
	//mapper.xml에 전달할 파라미터가 2개 이상이면 Map에 담아서 전달한다.
	Map<String, String> map = new HashMap<>();
	map.put("name", name);
	map.put("yyyyMMdd", yyyyMMdd);
	List<MyCalendar>list = sqlSession.selectList("Calendars.calBoardList", map);
	return list;
	}	
		
	//일정상세보기: select문, 결과:CalDto, 파라미터 :seq
	public MyCalendar calDetail(int seq) {
	MyCalendar dao= sqlSession.selectOne("Calendars.calDetail", seq);		
	return dao;	
	}	
	
	//일정수정하기
	public boolean calUpdate(MyCalendar dao) {
	int count = sqlSession.update("Calendars.calUpdate", dao);
	return count>0?true:false;	
	}	
	
	//일정삭제하기(여러개/한개 삭제하기)
	public boolean calMuldel(String[] seq) {
		Map<String, String[]>map = new HashMap<>();
		map.put("seqs", seq);
		int count= sqlSession.delete("Calendars.calMuldel", map);
		return count>0?true:false;
	}		
	
	//일정의 개수조회하기: select문, 파라미터 : id, yyyyMMdd
	public int calCount(String name, String yyyyMMdd) {
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("yyyyMMdd", yyyyMMdd);
		int count=sqlSession.selectOne("Calendars.calCount", map);
		return count;
	}		
	
	//달력에 존재하는 일정조회하기(일일별 최대 3개씩 가져오기)
	public List<MyCalendar> calViewList(String name, String yyyyMM) {
	Map<String, String>map = new HashMap<>();
	map.put("name", name);
	map.put("yyyyMM", yyyyMM);
	return sqlSession.selectList("Calendars.calViewList", map);	
	}




}
