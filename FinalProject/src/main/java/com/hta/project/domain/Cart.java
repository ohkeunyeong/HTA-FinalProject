package com.hta.project.domain;

import java.util.Date;

public class Cart {

	private int cart_num;
	private String product_code;
	private String id;
	private int order_de_count;
	private Date add_date;
	
	
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getOrder_de_count() {
		return order_de_count;
	}
	public void setOrder_de_count(int order_de_count) {
		this.order_de_count = order_de_count;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
}
