package com.hta.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hta.project.domain.Report;
import com.hta.project.service.AdminService;

@Controller
@RequestMapping("/report")
public class ReportController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService adminService;
	
	@PostMapping("/reportAdd")
	@ResponseBody
	public int reportAdd(Report report) {
		logger.info("Admin reportAdd()");
		
		int result = adminService.reportInsert(report);
		
		return result;
	}

}
