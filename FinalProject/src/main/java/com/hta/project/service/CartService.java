package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.CartList;

public interface CartService {
	public int cartInsert(String id, String product_code, int order_de_count);

	public List<CartList> getCartList(String id);

	public int getCartListCount(String id);

	public int cartDelete(int cart_num);

	public int cartSelectionDelete(int[] valueArr);
}
