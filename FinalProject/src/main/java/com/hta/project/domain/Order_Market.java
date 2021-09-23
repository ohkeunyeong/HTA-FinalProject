package com.hta.project.domain;

import java.util.Date;

public class Order_Market {

	private String order_num;
	private String id;
	private String order_name;
	private int user_address1;
	private String user_address2;
	private String order_phone;
	private int order_totalprice;
	private String order_payment;
	private Date order_date;
	private String order_delievery;
	
	
	public String getOrder_num() {
		return order_num;
	}
	public void setOrder_num(String order_num) {
		this.order_num = order_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public int getUser_address1() {
		return user_address1;
	}
	public void setUser_address1(int user_address1) {
		this.user_address1 = user_address1;
	}
	public String getUser_address2() {
		return user_address2;
	}
	public void setUser_address2(String user_address2) {
		this.user_address2 = user_address2;
	}
	public String getOrder_phone() {
		return order_phone;
	}
	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}
	public int getOrder_totalprice() {
		return order_totalprice;
	}
	public void setOrder_totalprice(int order_totalprice) {
		this.order_totalprice = order_totalprice;
	}
	public String getOrder_payment() {
		return order_payment;
	}
	public void setOrder_payment(String order_payment) {
		this.order_payment = order_payment;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getOrder_delievery() {
		return order_delievery;
	}
	public void setOrder_delievery(String order_delievery) {
		this.order_delievery = order_delievery;
	}
	
	
}
