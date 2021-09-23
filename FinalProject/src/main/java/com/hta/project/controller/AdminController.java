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
		return "jjs/admin/main2";
	}
	
	@GetMapping("/userlist")
	public String userlist() {
		logger.info("Admin userlist()");
		return "jjs/admin/list";
	}
	
	@GetMapping("/userInfo")
	public String userinfo() {
		logger.info("Admin userinfo()");
		return "jjs/admin/userinfo";
	}
	
	@GetMapping("/postlist")
	public String postlist() {
		logger.info("Admin postlist()");
		return "jjs/admin/postlist";
	}

}
