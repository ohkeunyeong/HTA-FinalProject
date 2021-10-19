package com.hta.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Free;
import com.hta.project.domain.Jik;
import com.hta.project.domain.Report;
import com.hta.project.service.AdminService;
import com.hta.project.service.FreeService;
import com.hta.project.service.JikService;

@Controller
@RequestMapping(value="/admin")
public class AdminReportController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminReportController.class);
	
	@Autowired
	private AdminService adminService;
	@Autowired
	private JikService jikService;
	
	@Autowired
	private FreeService freeService;
	
	@GetMapping("/reportList")
	public ModelAndView reportList(@RequestParam(value="page", defaultValue="1", required=false) int page, 
			   ModelAndView mv) {
		logger.info("Admin reportList()");
		
		int limit = 7;
		
		int listcount = adminService.getReportListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Report> reportlist = adminService.getReportList(page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("reportlist", reportlist);
		mv.addObject("limit", limit);
		
		mv.setViewName("jjs/admin/reportList");
		return mv;
	}
	
	@GetMapping("/reportDetail")
	public ModelAndView reportDetail(int num, ModelAndView mv,
			HttpServletRequest request) {
		logger.info("Admin reportDetail()");
		
		Report reportdetail = adminService.getReportDetail(num);
		
		if(reportdetail == null) {
			logger.info("신고글 상세보기 실패");
			mv.setViewName("jjs/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "신고글 상세보기 실패입니다.");
		}else {
			logger.info("신고글 상세보기 성공");
			mv.setViewName("jjs/admin/reportDetail");
			mv.addObject("reportdetail", reportdetail);
		}
		
		return mv;
	}
	
	@PostMapping("/reportDelete")
	public String reportDelete(int report_num, String board_table, int board_num, 
			HttpServletRequest request, Model mv) throws Exception {
		int result = adminService.reportDelete(report_num, board_table, board_num);
		
		if(result == 0) {
			logger.info("신고글 삭제 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "삭제 실패");
			return "jjs/error/error";
		}
		
		logger.info("신고글 삭제 성공");
		if(board_table.equals("jik")) {
			Jik jik = new Jik();
			jik = jikService.getDetail2(board_num);
			if(jik == null) {
				adminService.numReportDelete(board_num, board_table);
			}
		}else if(board_table.equals("free")) {
			Free free = new Free();
			free = freeService.getDetail2(board_num);
			if(free == null) {
				adminService.numReportDelete(board_num, board_table);
			}
		}
		return "redirect:reportList";
	}

}
