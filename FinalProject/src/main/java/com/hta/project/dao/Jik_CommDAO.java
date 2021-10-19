package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Jik_Comm;

@Repository
public class Jik_CommDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int getListCount(int jik_num) {
		return sqlSession.selectOne("Jik_Comms.count",jik_num);
	}

	public List<Jik_Comm> getCommnetList(Map<String, Integer> map) {
		
		return sqlSession.selectList("Jik_Comms.getList",map);
	}

	public int Jik_CommsInsert(Jik_Comm co) {
	
		return sqlSession.insert("Jik_Comms.insert",co);
	}
	
	public int Jik_CommsDelete(int num) {
		
		return sqlSession.delete("Jik_Comms.delete",num);
	}

	public int Jik_CommsUpdate(Jik_Comm co) {
		return sqlSession.update("Jik_Comms.update",co);
	}

	public int Jik_CommsReply(Jik_Comm co) {
		return sqlSession.insert("Jik_Comms.reply_insert", co);
	}

	public int Jik_CommsReplyUpdate(Jik_Comm co) {
		return sqlSession.update("Jik_Comms.reply_update", co);
	}

	public int Jik_comm_ref_select(int jik_comm_num) {
		return sqlSession.selectOne("Jik_Comms.ref_select", jik_comm_num);
	}

	public int Jik_comm_ref_select2(int select) {
		return sqlSession.selectOne("Jik_Comms.ref_select2", select);
	}

	public int Jik_CommsDelete2(int jik_comm_num) {
		return sqlSession.update("Jik_Comms.delete2",jik_comm_num);
	}



}
