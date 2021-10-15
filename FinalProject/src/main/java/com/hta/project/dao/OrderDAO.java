package com.hta.project.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Order_Market;

@Repository
public class OrderDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public void orderInsert(Order_Market order) {
		sqlSession.insert("Orders.insert", order);
	}
}
