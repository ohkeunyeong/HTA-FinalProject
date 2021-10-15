package com.hta.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.OrderDAO;
import com.hta.project.domain.Order_Market;

@Service
public class orderServiceImpl implements OrderService{

	@Autowired
	private OrderDAO orderdao;
	
	@Override
	public void orderInsert(Order_Market order) {
		orderdao.orderInsert(order);
	}
	

}
