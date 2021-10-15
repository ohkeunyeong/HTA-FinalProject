package com.hta.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.CartDAO;
import com.hta.project.domain.CartList;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartDAO cartdao;

	@Override
	public int cartInsert(String id, String product_code, int order_de_count) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("product_code", product_code);
		map.put("order_de_count", order_de_count);
		return cartdao.insert(map);
	}

	@Override
	public List<CartList> getCartList(String id, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return cartdao.getCartList(map);
	}

	@Override
	public int getCartListCount(String id) {
		return cartdao.getCartListCount(id);
	}
	
}
