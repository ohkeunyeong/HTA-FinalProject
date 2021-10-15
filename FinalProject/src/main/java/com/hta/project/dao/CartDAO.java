package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.CartList;
import com.hta.project.domain.Category;
import com.hta.project.domain.Farm;
import com.hta.project.domain.Member;
import com.hta.project.domain.Notice;
import com.hta.project.domain.Mynong;
import com.hta.project.domain.OrderDetail;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Report;

@Repository
public class CartDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insert(Map<String, Object> map) {
		return sqlSession.insert("Carts.insert", map);
	}

	public int getCartListCount(String id) {
		return sqlSession.selectOne("Carts.count", id);
	}

	public List<CartList> getCartList(Map<String, Object> map) {
		return sqlSession.selectList("Carts.list", map);
	}
}
