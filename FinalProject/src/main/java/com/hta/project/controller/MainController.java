package com.hta.project.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Product;
import com.hta.project.service.CartService;
import com.hta.project.service.MemberService;
import com.hta.project.service.ShopService;


@Controller
public class MainController {

	private static final Logger logger
    = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		  mv.setViewName("main/main");
		  return mv;
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public ModelAndView cart(HttpServletRequest request,
							ModelAndView mv) {
		  mv.setViewName("hyun/cart/cart");
		  HttpSession session = request.getSession();
		  String id = (String)session.getAttribute("id");
		  return mv;
	}
	
	@RequestMapping(value = "/orderSuccess", method = RequestMethod.GET)
	public String orderSuccess() {
		logger.info("orderSuccess()");
		
		return "jjs/orderSuccess";
	}

	
	//굿즈 장터 메인 이동 - 상품 목록 
	@RequestMapping("/shopmain")
	public String shopmain(Model model,
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="limit", defaultValue="6", required=false) int limit) {
		logger.info("Shop productList()");
		
		List<Product> productlist  = shopService.getProductList(page, limit);		
		
		int listcount = shopService.getProductListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		model.addAttribute("listcount", listcount);
		model.addAttribute("productlist", productlist);
		model.addAttribute("limit", limit);
		
		return "hyun/shop/shop_main";
	}
	
	//상품 목록 
	@RequestMapping(value = "products/list", method = RequestMethod.GET)
	public void getProductsList(String category_code) throws Exception {
		logger.info("get products list");
		logger.info(category_code);
	}
	
	
	//취소됨 //굿즈 장터 퍼스나콘 페이지 이동 
//	@RequestMapping("/personacon")
//	public String shop_personacon() {		
//		return "hyun/shop/shop_personacon";
//	}
		
	//굿즈 장터 주말굿즈 이동 
	@RequestMapping("/goods")
	public String shop_goods() {		
		return "hyun/shop/shop_goods";
	}

	//굿즈 장터 농기구 이동 
	@RequestMapping("/tools")
	public String shop_tools() {		
		return "hyun/shop/shop_tools";
	}
	
	//굿즈 장터 씨앗/모종 이동 
		@RequestMapping("/seed")
		public String shop_seed() {		
			return "hyun/shop/shop_seed";
		}
		
	//굿즈 장터 비료/상토 이동 
		@RequestMapping("/soil")
		public String shop_soil() {		
			return "hyun/shop/shop_soils";
		}
		
	//굿즈 장터 살충제 이동 
		@RequestMapping("/pesticide")
		public String shop_pesticide() {		
			return "hyun/shop/shop_pesticide";
	}
					
	//회원수정 바로가기 이동 
		@RequestMapping("/update")
		public String update() {		
			return "member/member_update";
		}
}
