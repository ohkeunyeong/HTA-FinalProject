package com.hta.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hta.project.dao.ShopDAO;
import com.hta.project.domain.Cart;
import com.hta.project.domain.Category;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Detail;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Review;

@Service
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopDAO dao = new ShopDAO();
	
	@Override
	public List<Category> getCategoryList() {
		return dao.getCategoryList();
	}


	@Override
	public int getProductListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		return dao.getProductListCount(map);
	}

	@Override
	public Product getShopProductDetail(String code) {
		return dao.getShopProductDetail(code);
	}

	@Override
	public int getProductCategoryCount(String category_name) {
		String word = "%" + category_name + "%";
		return dao.getProductCategoryCount(word);
	}

	@Override
	public List<Product> getProductCategoryList(int page, int limit, String category_name) {
		List<Product> list = new ArrayList<Product>();
		Map<String, Object> map = new HashMap<String, Object>();
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		String word = "%" + category_name + "%";
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("word", word);
		
		list = dao.getProductCategoryList(map);
		
		return list;
	}

	@Override
	public List<Product> getProductList(int index, String search_word, int page, int limit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getProductList(map);
	}


	@Override
	public List<Product> getToolsList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getToolsList(map);
	}


	@Override
	public List<Product> getGoodsList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getGoodsList(map);
	}


	@Override
	public List<Product> getReviewProductList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getReviewProductList(map);
	}
	
	@Override
	public List<Product> getReviewList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index != -1) {
			String[] search_field = new String[] {"product_name", "product_code", "category_name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getReviewList(map);
	}

	// 상품 소감(댓글) 작성
		@Override
		public void registReview(Review review) throws Exception {
			dao.registReview(review);		
		}

		// 상품 소감(댓글) 리스트
		@Override
		public List<Review> reviewList(String product_code) throws Exception {
			return dao.reviewList(product_code);
		}

		// 상품 소감(댓글) 삭제
		@Override
		public void deleteReview(Review review) throws Exception {
			dao.deleteReview(review);
		}

		// 아이디 체크
		@Override
		public String idCheck(String id) throws Exception {
			return dao.idCheck(id);
		}

		// 상품 소감(댓글) 수정
		@Override
		public void modifyReview(Review review) throws Exception {
			dao.modifyReply(review);
		}

		// 카트 담기
		@Override
		public void addCart(Cart cart) throws Exception {
			dao.addCart(cart);
		}

		// 카트 리스트
		@Override
		public List<Cart> cartList(String userId) throws Exception {
			return dao.cartList(userId);
		}

		// 카트 삭제
		@Override
		public void deleteCart(Cart cart) throws Exception {
			dao.deleteCart(cart);
		}

		// 주문 정보
		@Override
		public void orderInfo(Order_Market ordermarket) throws Exception {
			dao.orderInfo(ordermarket);
		}

		// 주문 상세 정보
		@Override
		public void orderInfo_Details(Order_Detail orderDetail) throws Exception {
			dao.orderInfo_Details(orderDetail);
		}

		// 카트 비우기 
		@Override
		public void cartAllDelete(String userId) throws Exception {
			dao.cartAllDelete(userId);
		}

		// 주문 목록
		@Override
		public List<Order_Market> orderList(Order_Market ordermarket) throws Exception {
			return dao.orderList(ordermarket);
		}


		@Override
		public String nickCheck(String member_nick) throws Exception {
			return dao.nickCheck(member_nick);
		}


		@Override
		public List<OrderDetailList> orderView(Order_Market ordermarket) throws Exception {
			return dao.orderView(ordermarket);
		}
	
}
