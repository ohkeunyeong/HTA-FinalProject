package com.hta.project.domain;

public class CartList {
	private int cart_num;
	private String product_code;
	private String user_id;
	private int order_de_count;
	private String adddate;
	private int category_code;
	private String product_name;
	private int product_price;
	private String product_img;

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
	
	public String getUser_id() {
		return user_id;
	}
	
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getOrder_de_count() {
		return order_de_count;
	}
	
	public void setOrder_de_count(int order_de_count) {
		this.order_de_count = order_de_count;
	}
	
	public String getAdddate() {
		return adddate;
	}
	
	public void setAdddate(String adddate) {
		this.adddate = adddate;
	}
	

	public int getCategory_code() {
		return category_code;
	}

	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	
	public String getProduct_name() {
		return product_name;
	}
	
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public String getProduct_img() {
		return product_img;
	}

	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	
	
}
