package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Category;
import com.hta.project.domain.Farm;
import com.hta.project.domain.Notice;
import com.hta.project.domain.OrderDetail;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Report;

public interface AdminService {

	public void insert(Notice notice);

	public Notice getDetail(int num);
	
	public int setReadCountUpdate(int num);

	public int getListCount();

	public List<Notice> getNoticeList(int page, int limit);

	public int noticeFixUpdate(int num, String fix);
	
	public Notice noticeSelect(int num);

	public int getSearchListCount(String search_word);

	public List<Notice> getSearchNoticeList(int page, int limit, String search_word);

	public int noticeSelectionDel(int[] noticeArr);

	public int noticeDelete(int num);

	public int noticeModify(Notice notice);

	public List<Category> getCategoryList();

	public void productAdd(Product product);

	public int getProductListCount(int index, String search_word);

	public List<Product> getProductList(int index, String search_word, int page, int limit);

	public Product getProductDetail(String code);

	public int productModify(Product product);

	public int insert_deleteFile(String before_file);

	public int productDelete(String code);

	public int productSelectionDel(String[] productArr);

	public int getProductCategoryCount(String category_name);

	public List<Product> getProductCategoryList(int page, int limit, String category_name);

	public List<Farm> farmList(int page, int limit);

	public int getfarmListCount();

	public List<Farm> getFarmSelectList(int page, int limit, int farmSelect);

	public int getOrderListCount();

	public List<Order_Market> getOrderList(int page, int limit);

	public int getSearchOrderListCount(String search_word);

	public List<Order_Market> getSearchOrderList(String search_word, int page, int limit);

	public OrderDetail getOrderDetail(String order_num);

	public List<OrderDetailList> getOrderDetailList(String order_num);

	public int orderDeliveryUpdate(String order_num, String deliveryStatus);

	public List<Report> getReportList(int page, int limit);

	public int getReportListCount();

	public Report getReportDetail(int num);

	public int reportDelete(int num, String table, int board_num);

	public void numReportDelete(int board_num, String board_table);

	public int reportInsert(Report report);

	public int getUserOrderListCount(String id);

	public List<Order_Market> getUserOrderList(String id, int page, int limit);

	public OrderDetail getUserOrderDetail(String id, String order_num);

	public List<OrderDetailList> getUserOrderDetailList(String id, String order_num);

	
}
