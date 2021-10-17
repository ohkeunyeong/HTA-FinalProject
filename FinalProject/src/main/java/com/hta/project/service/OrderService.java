package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Order_Market;

public interface OrderService {
	public int orderInsert(Order_Market order, int[] valueArr);
}
