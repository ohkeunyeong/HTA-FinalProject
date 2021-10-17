package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Category;
import com.hta.project.domain.Member;
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
    		  //ModelAndView mv = new ModelAndView();
    		  mv.addObject("product", product);
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
    	
    	@GetMapping("/productList")
    	public ModelAndView productList(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop productList()");
    		
    		List<Product> productlist = null;
    		int listcount = 0;
    		
    		productlist = shopService.getProductList(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("productlist", productlist);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_main");///////
    		return mv;
    	}
    	
    	@GetMapping("/toolsList1")
    	public ModelAndView toolsList1(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop toolsList1()");
    		
    		List<Product> toolslist1 = null;
    		int listcount = 0;
    		
    		toolslist1 = shopService.getToolsList1(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("toolslist1", toolslist1);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_tools");///////
    		return mv;
    	}
    	
    	@GetMapping("/goodsList1")
    	public ModelAndView goodsList1(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop goodsList1()");
    		
    		List<Product> goodslist1 = null;
    		int listcount = 0;
    		
    		goodslist1 = shopService.getGoodsList1(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("goodslist1", goodslist1);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_goods");///////
    		return mv;
    	}
    	
    	
    	@GetMapping("/seedList1")
    	public ModelAndView seedList1(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop seedList1()");
    		
    		List<Product> seedlist1 = null;
    		int listcount = 0;
    		
    		seedlist1 = shopService.getSeedList1(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("seedlist1", seedlist1);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_seed");///////
    		return mv;
    	}
    	
    	@GetMapping("/soilList1")
    	public ModelAndView soilList1(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop soilList1()");
    		
    		List<Product> soillist1 = null;
    		int listcount = 0;
    		
    		soillist1 = shopService.getSoilList1(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("soillist1", soillist1);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_soil");///////
    		return mv;
    	}
    	
    	@GetMapping("/pesticideList1")
    	public ModelAndView pesticideList1(@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
    			ModelAndView mv,
    			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
    			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
    		logger.info("Shop pesticideList1()");
    		
    		List<Product> pesticidelist1 = null;
    		int listcount = 0;
    		
    		pesticidelist1 = shopService.getPesticideList1(index, search_word, page, limit);
    		listcount = shopService.getProductListCount(index, search_word);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("pesticidelist1", pesticidelist1);
    		mv.addObject("limit", limit);
    		mv.addObject("search_field", index);
    		mv.addObject("search_word", search_word);
    		
    		
    		mv.setViewName("hyun/shop/shop_pesticide");///////
    		return mv;
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
    	@RequestMapping (value = "/registReview", method = RequestMethod.POST)
    	public void registReview(Review review, HttpSession session) throws Exception {
    	 logger.info(review.getProduct_code());
    	 
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

    	
}
