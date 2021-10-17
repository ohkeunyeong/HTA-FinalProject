package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OrderDAO;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;

@Service
public class orderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderdao;
	
	@Override
	public int orderInsert(Order_Market order, int[] valueArr) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order", order);
		map.put("arr", valueArr);
		return orderdao.orderInsert(map);
	}
	

}
