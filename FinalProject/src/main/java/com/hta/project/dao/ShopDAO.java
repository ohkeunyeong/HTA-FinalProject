package com.hta.project.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Cart;
import com.hta.project.domain.Category;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Detail;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Review;

@Repository
public class ShopDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 매퍼 
	private static String namespace = "Products1";
	
	public List<Category> getCategoryList() {
		return sqlSession.selectList("Products.categoryList");
	}
	
	public int getProductListCount() {
		return sqlSession.selectOne("Products.shopProductCount");
	}

	public Product getShopProductDetail(String code) {
		return sqlSession.selectOne("Products.getShopProductDetail", code);
	}
	
	public int getProductCategoryCount(String word) {
		return sqlSession.selectOne("Products.productCategoryListCount", word);
	}

	public List<Product> getProductCategoryList(Map<String, Object> map) {
		return sqlSession.selectList("Products.productCategoryList", map);
	}

	public List<Product> getProductList(Map<String, Object> map) {
		return sqlSession.selectList("Products.productList", map);
	}


	public List<Product> getToolsList(Map<String, Object> map) {
		return sqlSession.selectList("Products.tools", map);
	}

	public List<Product> getGoodsList(Map<String, Object> map) {
		return sqlSession.selectList("Products.goods", map);
	}

	public List<Product> getReviewList(Map<String, Object> map) {
		return sqlSession.selectList("Products.review", map);
	}

	public List<Product> getReviewProductList(Map<String, Object> map) {
		return sqlSession.selectList("Products.reviewProduct", map);
	}

	// 상품 소감(댓글) 작성
	public void registReview(Review review) throws Exception {
		sqlSession.insert(namespace + ".registReview", review);
		}
	
	// 상품 소감(댓글) 리스트
		public List<Review> reviewList(String product_code) throws Exception {
			return sqlSession.selectList(namespace + ".reviewList", product_code);
		}

	// 상품 소감(댓글) 삭제
	public void deleteReview(Review review) throws Exception {
		sqlSession.delete(namespace + ".deleteReview", review);
	}

	// 아이디 체크
	public String idCheck(String id) throws Exception {
		return sqlSession.selectOne(namespace + ".reviewUserIdCheck", id);
	}
	
	// 닉네임 체크
		public String nickCheck(String member_nick) throws Exception {
			return sqlSession.selectOne(namespace + ".reviewMember_nickCheck", member_nick);
		}

	// 상품 소감(댓글) 수정
	public void modifyReply(Review review) throws Exception {
		sqlSession.update(namespace + ".modifyReview", review);
	}

	// 카트 담기
	public void addCart(Cart cart) throws Exception {
		sqlSession.insert(namespace + ".addCart", cart);
	}

	// 카트 리스트
	public List<Cart> cartList(String userId) throws Exception {
		return sqlSession.selectList(namespace + ".cartList", userId);
	}

	// 카트 삭제
	public void deleteCart(Cart cart) throws Exception {
		sqlSession.delete(namespace + ".deleteCart", cart);
	}

	// 주문 정보
	public void orderInfo(Order_Market ordermarket) throws Exception {
		sqlSession.insert(namespace + ".orderInfo", ordermarket);
	}

	// 주문 상세 정보
	public void orderInfo_Details(Order_Detail orderDetail) throws Exception {
		sqlSession.insert(namespace + ".orderInfo_Details", orderDetail);
	}

	// 카트 비우기
	public void cartAllDelete(String userId) throws Exception {
		sqlSession.delete(namespace + ".cartAllDelete", userId);
	}

	// 주문 목록
	public List<Order_Market> orderList(Order_Market ordermarket) throws Exception {
		return sqlSession.selectList(namespace + ".orderList", ordermarket);
	}

	// 특정 주문 목록
	public List<OrderDetailList> orderView(Order_Market ordermarket) throws Exception {
		return sqlSession.selectList(namespace + ".orderView", ordermarket);
	}

	public int getCategoryProductListCount(int category_code) {
		return sqlSession.selectOne("Products.getCategoryProductListCount", category_code);
	}

	public List<Product> getCategoryProductList(Map<String, Object> map) {
		return sqlSession.selectList("Products.getCategoryProductList", map);
	}
		
}
