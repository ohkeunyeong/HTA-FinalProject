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

import com.hta.project.domain.Member;
import com.hta.project.service.MemberService;

@Controller
@RequestMapping(value="/admin")
public class AdminUserController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

	@Autowired
	private MemberService memberService;
	
	@GetMapping("/userList")
	public ModelAndView userList(@RequestParam(value="page", defaultValue="1", required=false) int page,
			ModelAndView mv) {
		logger.info("Admin userList()");
		
		int limit = 7;
		
		int listcount = memberService.getListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Member> userlist = memberService.getUserList(page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("userlist", userlist);
		mv.addObject("limit", limit);
		
		mv.setViewName("jjs/admin/userList");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/userList_search")
	public Map<String, Object> userList_search(
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="search_word", required=false) String search_word){
		
		int limit = 7;
		int listcount = 0;
		if(search_word != "") {
			listcount = memberService.getSearchListCount(search_word);
		}else {
			listcount = memberService.getListCount();
		}
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Member> userlist = new ArrayList<Member>();
		if(search_word != "") {
			userlist = memberService.getSearchList(search_word, page, limit);
		}else{
			userlist = memberService.getUserList(page, limit);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("userlist", userlist);
		map.put("limit", limit);
		return map;
		
	}
	
	@GetMapping("/userInfo")
	public ModelAndView userInfo(String id, ModelAndView mv, 
			HttpServletRequest request) {
		logger.info("Admin userInfo()");
		
		Member m = memberService.member_info(id);
		
		if(m == null) {
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 정보가 없습니다.");
		}else {
			mv.addObject("memberInfo", m);
			mv.setViewName("jjs/admin/userInfo");
		}
		
		return mv;
	}
	
	@GetMapping("/userDelete")
	public String userDelete(String id) {
		logger.info("Admin userDelete()");
		memberService.delete(id);
		return "redirect:userList";
	}
	
	

}
