package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Cart;
import com.hta.project.domain.Category;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Detail;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Review;

public interface ShopService<ReviewList, CartList> {

	public List<Category> getCategoryList();

	public int getProductListCount();

	public Product getShopProductDetail(String code);
	
	public int getProductCategoryCount(String category_name);

	public List<Product> getProductCategoryList(int page, int limit, String category_name);
	
	public List<Product> getProductList(int page, int limit);

	public List<Product> getToolsList(int index, String search_word, int page, int limit );

	public List<Product> getGoodsList(int index, String search_word, int page, int limit );

	public List<Product> getReviewProductList(int index, String search_word, int page, int limit);
	
	public List<Product> getReviewList(int index, String search_word, int page, int limit );
	
 	//상품 소감(댓글)작성
	public void registReview(Review review)throws Exception;

	//상품 소감 조회 
	public List<ReviewList> reviewList(String product_code)throws Exception;

	//상품 소감 삭제
	public void deleteReview(Review review)throws Exception;

	//상품 소감 삭제를 위한 nick 일치 여부 체크 
	public String nickCheck(String member_nick)throws Exception;

	//상품 소감(댓글) 수정
	void modifyReview(Review review) throws Exception;
	
	//장바구니 리스트 
	public List<CartList> cartList(String userId)throws Exception;

	//장바구니 담기 
	public void addCart(Cart cart)throws Exception;

	//장바구니 삭제 
	public void deleteCart(Cart cart)throws Exception;

	//주문 정보 
	public void orderInfo(Order_Market ordermarket)throws Exception;

	//주문 정보 디테일 
	public void orderInfo_Details(Order_Detail orderDetail)throws Exception;

	//주문 정보 목록 
	public List<OrderDetailList> orderView(Order_Market ordermarket)throws Exception;

	//주문 목록 
	public List<Order_Market> orderList(Order_Market ordermarket)throws Exception;

	//id 일치 여부 체크 
	public String idCheck(String id)throws Exception;

	//주문 테이블, 주문 상세 테이블에 데이터를 전송하고, 카트 비우기
	public void cartAllDelete(String userId)throws Exception;



	

	

	
	
	
	

	

}
