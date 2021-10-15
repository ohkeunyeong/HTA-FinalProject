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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.CartList;
import com.hta.project.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService cartService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView cart(HttpServletRequest request, ModelAndView mv,
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="limit", defaultValue="6", required=false) int limit) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		List<CartList> cartlist  = cartService.getCartList(id, page, limit);		
		
		int listcount = cartService.getCartListCount(id);
		
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
		mv.addObject("cartlist", cartlist);
		mv.addObject("limit", limit);
		mv.setViewName("hyun/cart/cart");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public int add(HttpServletRequest request,
			String product_code, int order_de_count) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		int result = cartService.cartInsert(id, product_code, order_de_count);
		
		return result;
	}
}
