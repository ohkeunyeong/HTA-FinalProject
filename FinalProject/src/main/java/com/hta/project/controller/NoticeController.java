package com.hta.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.hta.project.domain.Notice;
import com.hta.project.service.AdminService;

@Controller
@RequestMapping(value="/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/noticeList")
	public ModelAndView noticeList(@RequestParam(value="page", defaultValue="1", required=false) int page, 
			   ModelAndView mv) {
		logger.info("notice noticeList()");
		
		int limit = 10;
		
		int listcount = adminService.getListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Notice> noticelist = adminService.getNoticeList(page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("noticelist", noticelist);
		mv.addObject("limit", limit);
		mv.setViewName("chang/notice/notice_list");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeList_search")
	public Map<String, Object> noticeList_search(
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="search_word", required=false) String search_word){
		
		int limit = 7;
		int listcount = 0;
		if(search_word != "") {
			listcount = adminService.getSearchListCount(search_word);
		}else {
			listcount = adminService.getListCount();
		}
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Notice> noticelist = new ArrayList<Notice>();
		if(search_word != "") {
			noticelist = adminService.getSearchNoticeList(page, limit, search_word);
		}else{
			noticelist = adminService.getNoticeList(page, limit);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("noticelist", noticelist);
		map.put("limit", limit);
		return map;
		
	}
	

	
	@GetMapping("/noticeDetail")
	public ModelAndView noticeDetail(int num, ModelAndView mv,
				HttpServletRequest request) {
		logger.info("Admin noticeDetail()");
		
		Notice notice = adminService.getDetail(num);
		
		if(notice == null) {
			logger.info("공지사항 상세보기 실패");
			mv.setViewName("jjs/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "공지사항 상세보기 실패입니다.");
		}else {
			logger.info("공지사항 상세보기 성공");
			mv.setViewName("chang/notice/notice_view");
			mv.addObject("notice", notice);
		}
		
		return mv;
	}
	
	



}
