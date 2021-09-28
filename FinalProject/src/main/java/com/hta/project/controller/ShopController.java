package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    	
    	@RequestMapping(value = "/shopdetail", method = RequestMethod.GET)
    	public ModelAndView main(ModelAndView mv) {
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
    			ModelAndView mv) {
    		logger.info("Shop productList()");
    		
    		int limit = 5;
    		
    		int listcount = shopService.getProductListCount();
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		List<Product> productlist = shopService.getProductList(page, limit);
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("productlist", productlist);
    		mv.addObject("limit", limit);
    		
    		mv.setViewName("hyun/shop/shopmain");
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
