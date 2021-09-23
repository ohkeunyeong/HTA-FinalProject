package com.hta.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hta.project.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping(value="/main")
	public String main() {
		logger.info("Admin main()");
		return "jjs/admin/main";
	}
	
	@GetMapping("/userList")
	public String userList() {
		logger.info("Admin userList()");
		return "jjs/admin/userList";
	}
	
	@GetMapping("/userInfo")
	public String userInfo() {
		logger.info("Admin userInfo()");
		return "jjs/admin/userInfo";
	}
	
	@GetMapping("/postList")
	public String postList() {
		logger.info("Admin postList()");
		return "jjs/admin/postList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail() {
		logger.info("Admin noticeDetail()");
		return "jjs/admin/noticeDetail";
	}

}
