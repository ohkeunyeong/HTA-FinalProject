package com.hta.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.OrderDetail;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Market;
import com.hta.project.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminOrderController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminOrderController.class);
	
	@Autowired
	private AdminService adminService;
	
	@Value("${savefoldername}")
	private String saveFolder;
	
	@GetMapping("/orderList")
	public ModelAndView orderList(@RequestParam(value="page", defaultValue="1", required=false) int page,
			ModelAndView mv) {
		logger.info("Admin orderList()");
		
		int limit = 7;
		
		int listcount = adminService.getOrderListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Order_Market> orderlist = adminService.getOrderList(page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("orderlist", orderlist);
		mv.addObject("limit", limit);
		
		mv.setViewName("jjs/admin/orderList");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/orderList_search")
	public Map<String, Object> orderList_search(
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="search_word", required=false) String search_word){
		
		int limit = 7;
		int listcount = 0;
		if(search_word != "") {
			listcount = adminService.getSearchOrderListCount(search_word);
		}else {
			listcount = adminService.getOrderListCount();
		}
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Order_Market> orderlist = new ArrayList<Order_Market>();
		if(search_word != "") {
			orderlist = adminService.getSearchOrderList(search_word, page, limit);
		}else{
			orderlist = adminService.getOrderList(page, limit);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("orderlist", orderlist);
		map.put("limit", limit);
		return map;
		
	}
	
	@GetMapping("/orderDetail")
	public ModelAndView orderDetail(String order_num, ModelAndView mv, 
			   HttpServletRequest request) {
		logger.info("Admin orderDetail()");
		
		OrderDetail orderdetail = adminService.getOrderDetail(order_num);
		
		List<OrderDetailList> orderlist = adminService.getOrderDetailList(order_num);
		
		if(orderdetail==null) {
			logger.info("상세보기 실패");
			mv.setViewName("jjs/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		}else {
			logger.info("상세보기 성공");
			mv.setViewName("jjs/admin/orderDetail");
			mv.addObject("orderdetail", orderdetail);
			mv.addObject("orderlist", orderlist);
		}
		return mv;
	}
	
	@PostMapping("/OrderDeliveryUpdate")
	@ResponseBody
	public void OrderDeliveryUpdate(String deliveryStatus,
			String order_num, HttpServletResponse response) throws Exception{
		logger.info("Admin OrderDeliveryUpdate()");
		
		int result = adminService.orderDeliveryUpdate(order_num, deliveryStatus);
		
		response.getWriter().print(result);
	}

}
