package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.hta.project.domain.Product;
import com.hta.project.service.ShopService;

@Controller
@RequestMapping(value="/shop")
public class ShopController {

    	private static final Logger logger
        = LoggerFactory.getLogger(MainController.class);
    	
    	@Autowired
    	private ShopService shopService;
    	
    	//http:localhost:8088/project/shop/shop_detail?product_code=000001
    	@RequestMapping(value = "/shop_detail", method = RequestMethod.GET)
    	public ModelAndView main(ModelAndView mv, String product_code) {
    		Product product = shopService.getProductDetail(product_code);
    		  //ModelAndView mv = new ModelAndView();
    		  mv.addObject("product", product);
    		  mv.setViewName("hyun/shop/shop_detail");
    		  return mv;
    	}
    	
    	@PostMapping("/categoryList")
    	@ResponseBody
    	public Map<String, Object> categoryList() {
    		logger.info("Admin categoryList()");
    		
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
    		
    		
    		mv.setViewName("hyun/shop/shop_main");
    		return mv;
    	}
    	
    	@PostMapping("/productDetail")
    	@ResponseBody
    	public Map<String, Object> productDetail(String code) {
    		logger.info("Admin productDetail()");
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		Product product = shopService.getProductDetail(code);
    		
    		map.put("product", product);
    		
    		return map;
    	}
    	
    	@GetMapping("/productDetail")
    	public ModelAndView productDetail(String code, ModelAndView mv, 
    			   HttpServletRequest request) {
    		logger.info("Admin productDetail()");
    		
    		Product product = shopService.getProductDetail(code);
    		
    		if(product==null) {
    			logger.info("상세보기 실패");
    			mv.setViewName("jjs/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "상세보기 실패입니다.");
    		}else {
    			logger.info("상세보기 성공");
    			mv.setViewName("jjs/admin/productDetail");
    			mv.addObject("product", product);
    		}
    		return mv;
    	}
    	
    	
    	
    	@GetMapping("/orderList")
    	public String orderList() {
    		logger.info("Shop orderList()");
    		return "hyun/cart/orderList";
    	}
    	
    	@GetMapping("/orderDetail")
    	public String orderDetail() {
    		logger.info("Shop orderDetail()");
    		return "hyun/cart/orderDetail";
    	}
}
