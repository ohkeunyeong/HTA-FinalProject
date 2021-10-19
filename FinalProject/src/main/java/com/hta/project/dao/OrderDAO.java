package com.hta.project.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int orderInsert(Map<String, Object> map) {
		sqlSession.insert("Orders.insert", map.get("order"));
		sqlSession.insert("Orders.orderDetailInsert", map);
		return sqlSession.delete("Carts.userCartDelete", map);
	}
}
