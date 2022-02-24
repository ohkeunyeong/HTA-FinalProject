package com.hta.project.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Farm;
import com.hta.project.domain.Member;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Report;
import com.hta.project.service.AdminService;
import com.hta.project.service.MemberService;

//
@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping(value="/main")
	public ModelAndView main(ModelAndView mv) {
		logger.info("Admin main()");
		
		List<Member> userlist = memberService.getUserList(1, 2);
		List<Report> reportlist = adminService.getReportList(1, 2);
		List<Product> productlist = adminService.getProductList(-1, "",  1, 2);
		List<Farm> farmlist = adminService.farmList(1, 2); 
		List<Order_Market> orderlist = adminService.getOrderList(1, 2);
		
		mv.addObject("userlist", userlist);
		mv.addObject("reportlist", reportlist);
		mv.addObject("productlist", productlist);
		mv.addObject("farmlist", farmlist);
		mv.addObject("orderlist", orderlist);
		mv.setViewName("jjs/admin/main");
		
		return mv;
	}

}
