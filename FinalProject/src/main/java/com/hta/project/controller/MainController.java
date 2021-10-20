package com.hta.project.controller;


import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.hta.project.domain.Free;
import com.hta.project.domain.Jik;
import com.hta.project.domain.Member;
import com.hta.project.service.CartService;
import com.hta.project.service.FreeService;
import com.hta.project.service.JikService;
import com.hta.project.service.Jik_CommService;
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
	private JikService jikService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private Jik_CommService jik_commService;
	
	@Autowired
	private FreeService freeService;
	
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
	
	@RequestMapping(value = "/farm_info", method = RequestMethod.GET)
	public String farm_info () {
		  return "main/farm_info";
	}
	
	@RequestMapping(value = "/main", method=RequestMethod.GET)
	public ModelAndView mainjiklistANDmainfreelist(
			@RequestParam(value="page",defaultValue="1",required=false) 
			int page,
			ModelAndView mv) {
		
		int limit = 6;
		int freelimit = 6;
		
		int listcount = jikService.getListCount();
		int freelistcount = freeService.getListCount();
		
		int freemaxpage = (freelistcount + freelimit - 1) / freelimit;
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1)/10) * 10 + 1;
		
	
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Jik> mainjiklist = jikService.getMainjikList(page, limit);
		
		int freestartpage = ((page-1)/10) * 10 + 1;
		
		
		int freeendpage = freestartpage + 10 - 1;
		
		if(freeendpage > freemaxpage)
			freeendpage = freemaxpage;
		
		List<Free> mainfreelist = freeService.getMainfreeList(page, limit);
		
		mv.setViewName("main/main");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("mainjiklist",mainjiklist);
		mv.addObject("page",page);
		mv.addObject("limit",limit);
		mv.addObject("freelimit",freelimit);
		mv.addObject("maxpage",freemaxpage);
		mv.addObject("startpage",freestartpage);
		mv.addObject("endpage",freeendpage);
		mv.addObject("freelistcount",freelistcount);
		mv.addObject("mainfreelist",mainfreelist);
		return mv;
	}
	

	
}
