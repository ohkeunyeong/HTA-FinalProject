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
					
	//회원수정 바로가기 이동 
		@RequestMapping("/update")
		public String update() {		
			return "member/member_update";
		}
}
