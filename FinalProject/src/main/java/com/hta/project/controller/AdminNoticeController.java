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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Notice;
import com.hta.project.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminNoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminNoticeController.class);
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/noticeList")
	public ModelAndView noticeList(@RequestParam(value="page", defaultValue="1", required=false) int page, 
			   ModelAndView mv) {
		logger.info("Admin noticeList()");
		
		int limit = 7;
		
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
		
		mv.setViewName("jjs/admin/noticeList");
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
	
	@PostMapping("/noticeAdd")
	public String noticeAdd(Notice notice) {
		logger.info("Admin noticeAdd()");
		
		adminService.insert(notice);
		
		return "redirect:noticeList";
	}
	
	@PostMapping("/noticeModify")
	public String noticeModify(Notice notice, 
			HttpServletRequest request, Model model) {
		logger.info("Admin noticeModify()");
		
		int result = adminService.noticeModify(notice);
		
		if(result == 0) {
			logger.info("공지사항 글 수정 실패");
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "공지사항 글 수정 실패입니다.");
			return "jjs/error/error";
		}
		
		return "redirect:noticeDetail?num=" + notice.getNOTICE_NUM();
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
			mv.setViewName("jjs/admin/noticeDetail");
			mv.addObject("notice", notice);
		}
		
		return mv;
	}
	
	@PostMapping("/noticeFixUpdate")
	@ResponseBody
	public Map<String, Object> noticeFixUpdate(int num,
			@RequestParam(value="fix", required=false) String fix){
		logger.info("Admin noticeFixUpdate()");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int result = adminService.noticeFixUpdate(num, fix);
		
		Notice notice = adminService.noticeSelect(num);
		
		map.put("result", result);
		map.put("notice", notice);
		
		return map;
	}
	
	@PostMapping("/noticeSelect")
	@ResponseBody
	public Map<String, Object> noticeSelect(int num){
		logger.info("Admin noticeSelect()");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Notice notice = adminService.noticeSelect(num);
		
		map.put("notice", notice);
		
		return map;
	}
	
	@PostMapping("/noticeSelectionDelete")
	@ResponseBody
	public void noticeSelectionDelete(
			@RequestParam("valueArr") int[] noticeArr,
			HttpServletResponse response) throws Exception{
		logger.info("Admin noticeSelectionDelete()");
		int result = adminService.noticeSelectionDel(noticeArr);
		response.getWriter().print(result);
	}
	
	@PostMapping("/noticeDelete")
	public String noticeDelete(int num, HttpServletRequest request,
			Model mv) throws Exception {
		int result = adminService.noticeDelete(num);
		
		if(result == 0) {
			logger.info("공지사항 글 삭제 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "삭제 실패");
			return "error/error";
		}
		
		logger.info("공지사항 글 삭제 성공");
		return "redirect:noticeList";
	}

}
