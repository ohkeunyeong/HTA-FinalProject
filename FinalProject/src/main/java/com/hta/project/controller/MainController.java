package com.hta.project.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Category;
import com.hta.project.domain.Product;
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
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		  mv.setViewName("main/main");
		  return mv;
	}

	
	//굿즈 장터 메인 이동 - 상품 목록 
	@RequestMapping("/shopmain")
	public String shopmain(Model model,
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="limit", defaultValue="8", required=false) int limit,
			ModelAndView mv,
			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		logger.info("Shop productList()");
		
		
		//보여줄 값 구한다.
		//1. 모든 것
		//2. 살충제 
		//3. 비료/상토 
		
		//추천(판매량 많은) 제품 리스트 
		List<Product> productlist  = shopService.getProductList(index, search_word, page, limit);		
		model.addAttribute("productList", productlist);
		
		//취소됨 //퍼스나콘 제품 리스트
//		List<Product> personaconlist  = shopService.getPersonaconList(index, search_word, page, limit);		
//		model.addAttribute("personaconList", personaconlist);
		
		//도구 제품 리스트
		List<Product> toolslist  = shopService.getToolsList(index, search_word, page, limit);		
		model.addAttribute("toolsList", toolslist);
		
		//굿즈 제품 리스트
		List<Product> goodslist  = shopService.getGoodsList(index, search_word, page, limit);		
		model.addAttribute("goodsList", goodslist);
		
		//후기많은 제품 리스트
		List<Product> reviewProductlist  = shopService.getReviewProductList(index, search_word, page, limit);		
		model.addAttribute("reviewProductList", reviewProductlist);
		
		//후기 리스트
		List<Product> reviewlist  = shopService.getReviewList(index, search_word, page, limit);		
		model.addAttribute("reviewList", reviewlist);
		
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
	public String shop_goods(Model model,
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
			ModelAndView mv,
			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		logger.info("Shop goodsList1()");
		
		//굿즈 제품 리스트
				List<Product> goodslist1  = shopService.getGoodsList1(index, search_word, page, limit);		
				model.addAttribute("goodsList1", goodslist1);
		
		return "hyun/shop/shop_goods";
	}
	

	//굿즈 장터 농기구 이동 
	@RequestMapping("/tools")
	public String shop_tools(Model model,
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="limit", defaultValue="12", required=false) int limit,
			ModelAndView mv,
			@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
			@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
		logger.info("Shop toolsList1()");
		
		//도구 제품 리스트 - 헤더 카테고리 이동 
				List<Product> toolslist1  = shopService.getToolsList1(index, search_word, page, limit);		
				model.addAttribute("toolsList1", toolslist1);
				
		return "hyun/shop/shop_tools";
	}
	
	
				
	//굿즈 장터 씨앗/모종 이동 
		@RequestMapping("/seed")
		public String shop_seed(Model model,
				@RequestParam(value="page", defaultValue="1", required = false) int page,
				@RequestParam(value="limit", defaultValue="12", required=false) int limit,
				ModelAndView mv,
				@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
				@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
			logger.info("Shop seedList1()");
			
			//씨앗/모종 제품 리스트
			List<Product> seedlist1  = shopService.getSeedList1(index, search_word, page, limit);		
			model.addAttribute("seedList1", seedlist1);
			
			return "hyun/shop/shop_seed";
		}
		
	//굿즈 장터 비료/상토 이동 
		@RequestMapping("/soil")
		public String shop_soil(Model model,
				@RequestParam(value="page", defaultValue="1", required = false) int page,
				@RequestParam(value="limit", defaultValue="12", required=false) int limit,
				ModelAndView mv,
				@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
				@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
			logger.info("Shop soilList1()");
			
			//비료/상토 제품 리스트
			List<Product> soillist1  = shopService.getSoilList1(index, search_word, page, limit);		
			model.addAttribute("soilList1", soillist1);
			
			return "hyun/shop/shop_soil";
		}
		
	//굿즈 장터 살충제 이동 
		@RequestMapping("/pesticide")
		public String shop_pesticide(Model model,
				@RequestParam(value="page", defaultValue="1", required = false) int page,
				@RequestParam(value="limit", defaultValue="12", required=false) int limit,
				ModelAndView mv,
				@RequestParam(value="search_field", defaultValue="-1", required=false) int index,
				@RequestParam(value="search_word", defaultValue="", required=false) String search_word) {
			logger.info("Shop pesticideList1()");
			
			//씨앗/모종 제품 리스트
			List<Product> pesticidelist1  = shopService.getPesticideList1(index, search_word, page, limit);		
			model.addAttribute("pesticideList1", pesticidelist1);		
			return "hyun/shop/shop_pesticide";
	}
					
	//회원수정 바로가기 이동 
		@RequestMapping("/update")
		public String update() {		
			return "member/member_update";
		}
}
