package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Farm;
import com.hta.project.service.AdminService;

@Controller
@RequestMapping(value="/admin")
public class AdminFarmController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminFarmController.class);
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/farmList")
	public ModelAndView farmList(@RequestParam(value="page", defaultValue="1", required=false) int page, 
			   ModelAndView mv) {
		logger.info("Admin farmList()");
		
		int limit = 2;
		
		int listcount = adminService.getfarmListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Farm> farmList = adminService.farmList(page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("farmList", farmList);
		mv.addObject("limit", limit);
		
		mv.setViewName("jjs/admin/farmList");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/farmList_ajax")
	public Map<String, Object> farmList_ajax(
			@RequestParam(value="page", defaultValue="1", required = false) int page,
			@RequestParam(value="farmSelect", required=false) int farmSelect){
		
		int limit = 2;
		
		int listcount = adminService.getfarmListCount();
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Farm> farmlist = adminService.getFarmSelectList(page, limit, farmSelect);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("farmlist", farmlist);
		map.put("limit", limit);
		return map;
		
	}

}
