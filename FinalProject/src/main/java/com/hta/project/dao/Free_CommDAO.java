package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Free_Comm;

@Repository
public class Free_CommDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int getListCount(int free_num) {
		return sqlSession.selectOne("Free_Comms.count",free_num);
	}

	public List<Free_Comm> getCommnetList(Map<String, Integer> map) {
		
		return sqlSession.selectList("Free_Comms.getList",map);
	}

	public int Free_CommsInsert(Free_Comm co) {
	
		return sqlSession.insert("Free_Comms.insert",co);
	}
	
	public int Free_CommsDelete(int num) {
		
		return sqlSession.delete("Free_Comms.delete",num);
	}

	public int Free_CommsUpdate(Free_Comm co) {
		return sqlSession.update("Free_Comms.update",co);
	}

	public int Free_CommsReply(Free_Comm co) {
		return sqlSession.insert("Free_Comms.reply_insert", co);
	}

	public int Free_CommsReplyUpdate(Free_Comm co) {
		return sqlSession.update("Free_Comms.reply_update", co);
	}

	public int Free_comm_ref_select(int free_comm_num) {
		return sqlSession.selectOne("Free_Comms.ref_select", free_comm_num);
	}

	public int Free_comm_ref_select2(int select) {
		return sqlSession.selectOne("Free_Comms.ref_select2", select);
	}

	public int Free_CommsDelete2(int free_comm_num) {
		return sqlSession.update("Free_Comms.delete2",free_comm_num);
	}



}
