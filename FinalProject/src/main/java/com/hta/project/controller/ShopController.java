package com.hta.project.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Cart;
import com.hta.project.domain.Category;
import com.hta.project.domain.Member;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Detail;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Review;
import com.hta.project.service.MemberService;
import com.hta.project.service.ShopService;

@Controller
@RequestMapping(value="/shop")
public class ShopController<ReviewList, CartList> {

    	private static final Logger logger
        = LoggerFactory.getLogger(ShopController.class);
    	
    	@Autowired
    	private ShopService shopService;
    	
    	@Autowired
    	private MemberService memberService;
    	
    	//http:localhost:8088/project/shop/shop_detail?product_code=000001
    	@RequestMapping(value = "/shop_detail", method = RequestMethod.GET)
    	public ModelAndView main(ModelAndView mv, String product_code) {
    		Product product = shopService.getShopProductDetail(product_code);
    		mv.addObject("p", product);
    		mv.setViewName("hyun/shop/shop_detail");
    		return mv;
    	}
    	
    	@PostMapping("/categoryList")
    	@ResponseBody
    	public Map<String, Object> categoryList() {
    		logger.info("Shop categoryList()");
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		List<Category> categoryList = shopService.getCategoryList();
    		
    		map.put("categoryList", categoryList);
    		
    		return map;
    	}
    	
    	@PostMapping("/productDetail")
    	@ResponseBody
    	public Map<String, Object> productDetail(String code, HttpSession session) {
    		logger.info("Shop productDetail()");
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		Product product = shopService.getShopProductDetail(code);
    		String id = (String)session.getAttribute("id");
    		Member member = memberService.member_info(id);
    		
    		map.put("product", product);
    		map.put("member", member);
    		
    		return map;
    	}
    	
    	@GetMapping("/productDetailView")
    	public ModelAndView productDetail(String code, ModelAndView mv, 
    			   HttpServletRequest request) {
    		logger.info("Shop productDetailView()");
    		
    		Product product = shopService.getShopProductDetail(code);
    		
    		if(product==null) {
    			logger.info("상세보기 실패");
    			mv.setViewName("hyun/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "상세보기 실패입니다.");
    		}else {
    			logger.info("상세보기 성공");
    			mv.setViewName("hyun/shop/productDetailView");
    			mv.addObject("product", product);
    		}
    		return mv;
    	}
    	
    	
    	
    	@GetMapping("/orderListView")
    	public String orderList() {
    		logger.info("Shop orderList()");
    		return "hyun/cart/orderListView";
    	}
    	
    	@GetMapping("/orderDetailView")
    	public String orderDetail() {
    		logger.info("Shop orderDetail()");
    		return "hyun/cart/orderDetailView";
    	}
    	
 //////////////////////////////////////////////1013
    	
    	// 상품 조회 - 소감(댓글) 작성
    	@ResponseBody   	
    	@RequestMapping(value = "/registReview", method = RequestMethod.POST)
    	public void registReview(Review review, HttpSession session) throws Exception {
    	 logger.info("regist review");
    	 
    	 String id = (String)session.getAttribute("id");
    	 Member member = memberService.member_info(id);
    	 review.setId(id);
    	 
    	 review.setMember_nick(member.getNick());
    	 
    	 shopService.registReview(review);
    	 
    	}
    	
    	
    	
    	// 상품 소감(댓글) 목록
    	@ResponseBody
    	@RequestMapping(value = "/reviewList", method = RequestMethod.GET)
    	public List<Review> getReviewList(@RequestParam("n") String product_code) throws Exception {
    	 logger.info("get review list");
    	   
    	 List<Review> review = shopService.reviewList(product_code);
    	 
    	 return review;
    	} 
    	
    	
    	
    	// 상품 소감(댓글) 삭제
    	@ResponseBody
    	@RequestMapping(value = "/deleteReview", method = RequestMethod.POST)
    	public int getReviewList(Review review,  HttpSession session) throws Exception {
    		logger.info("post delete review");

    		// 정상작동 여부를 확인하기 위한 변수
    		int result = 0;

    		Member member = (Member)session.getAttribute("member");  // 현재 로그인한  member 세션을 가져옴
    		String userNick = shopService.nickCheck(review.getMember_nick());  // 소감(댓글)을 작성한 사용자의 아이디를 가져옴

    		// 로그인한 아이디와, 소감을 작성한 아이디를 비교
    		if(member.getNick().equals(userNick)) {

    			// 로그인한 아이디가 작성한 아이디와 같다면

    			review.setMember_nick(member.getId());  // reply에 userId 저장
    			shopService.deleteReview(review);  // 서비스의 deleteReply 메서드 실행

    			// 결과값 변경
    			result = 1;
    		}

    		// 정상적으로 실행되면 소감 삭제가 진행되고, result값은 1이지만
    		// 비정상적으로 실행되면 소감 삭제가 안되고, result값이 0
    		return result;	
    	}

    	// 상품 소감(댓글) 수정
    	@ResponseBody
    	@RequestMapping(value = "/modifyReview", method = RequestMethod.POST)
    	public int modifyReview(Review review, HttpSession session) throws Exception {
    		logger.info("modify review");

    		int result = 0;

    		Member member = (Member)session.getAttribute("member");
    		String userNick = shopService.idCheck(review.getMember_nick());  // 소감(댓글)을 작성한 사용자의 아이디를 가져옴

    		if(member.getNick().equals(userNick)) {

    			review.setMember_nick(member.getId());  // reply에 userId 저장
    			shopService.deleteReview(review);  // 서비스의 deleteReply 메서드 실행
    			result = 1;
    		}

    		return result;

    	}

    	// 주문
    	@RequestMapping(value = "/cartList", method = RequestMethod.POST)
    	public String order(HttpSession session, Order_Market ordermarket, Order_Detail orderDetail) throws Exception {
    		logger.info("order");

    		Member member = (Member)session.getAttribute("member");		
    		String userId = member.getId();

    		// 캘린더 호출
    		Calendar cal = Calendar.getInstance();
    		int year = cal.get(Calendar.YEAR);  // 연도 추출
    		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);  // 월 추출
    		String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));  // 일 추출
    		String subNum = "";  // 랜덤 숫자를 저장할 문자열 변수

    		for(int i = 1; i <= 6; i ++) {  // 6회 반복
    			subNum += (int)(Math.random() * 10);  // 0~9까지의 숫자를 생성하여 subNum에 저장
    		}

    		String ordernum = ymd + "_" + subNum;  // [연월일]_[랜덤숫자] 로 구성된 문자

    		ordermarket.setOrder_num(ordernum);
    		ordermarket.setOrder_name(userId);

    		shopService.orderInfo(ordermarket);

    		orderDetail.setId(userId);			
    		shopService.orderInfo_Details(orderDetail);

    		// 주문 테이블, 주문 상세 테이블에 데이터를 전송하고, 카트 비우기
    		shopService.cartAllDelete(userId);

    		return "redirect:/shop/orderList";		
    	}

    	// 주문 목록
    	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
    	public void getOrderList(HttpSession session,  Order_Market ordermarket, Model model) throws Exception {
    		logger.info("get order list");

    		Member member = (Member)session.getAttribute("member");
    		String userId = member.getId();

    		ordermarket.setId(userId);

    		List<Order> orderList = shopService.orderList(ordermarket);

    		model.addAttribute("orderList", orderList);
    	}

    	// 주문 상세 목록
    	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
    	public void getOrderList(HttpSession session,
    							@RequestParam("n") String orderId,
    							 Order_Market ordermarket, Model model) throws Exception {
    		logger.info("get order view");

    		Member member = (Member)session.getAttribute("member");
    		String userId = member.getId();

    		ordermarket.setId(userId);
    		ordermarket.setOrder_name(orderId);

    		List<OrderDetailList> orderView = shopService.orderView(ordermarket);

    		model.addAttribute("orderView", orderView);
    	}

}
