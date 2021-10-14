package com.hta.project.domain;

public class Order_Detail {

	private String order_de_num;
	private String order_num;
	private String product_code;
	private int order_de_count;
	private String id;
	
	
	public String getOrder_de_num() {
		return order_de_num;
	}
	public void setOrder_de_num(String order_de_num) {
		this.order_de_num = order_de_num;
	}
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getOrder_de_count() {
		return order_de_count;
	}
	public void setOrder_de_count(int order_de_count) {
		this.order_de_count = order_de_count;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
