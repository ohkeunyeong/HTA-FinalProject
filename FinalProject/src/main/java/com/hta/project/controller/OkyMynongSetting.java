//내농장 관리컨트롤러
package com.hta.project.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.OkyImsi;
import com.hta.project.service.OkyMynongService;

@Controller
public class OkyMynongSetting {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyMynongSetting.class);
	
	@Autowired
	private OkyMynongService okymynongservice;
	
    
    //내농장에 추가할 유저 아이디 확인
    @ResponseBody
    @RequestMapping(value = "/okyidcheck")
    public Map<String, Object> idcheck(OkyImsi okyimsi) {
    	logger.info("검색한 유저 아이디 :" +okyimsi.getID());
    	List<OkyImsi> list = okymynongservice.getUserList(okyimsi);
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("list", list);    	
     	return map ;
    }
    
    //농장관리 
    @GetMapping("/mynong")
    public ModelAndView mynong (
    		@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "3", required = false) int limit,
			String name, String id, ModelAndView mv, 
			HttpServletRequest request) {
    	List<OkyImsi> list = null;
    	int listcount = 0;
    	list = okymynongservice.getUserList3(page,limit, name); //농장에 있는 모든 멤버 보여줌
    	listcount = okymynongservice.getSearchListCount(name); //농장에 있는 모든 멤버 수 구하기
    	logger.info("해당 농장 맴버 리스트 =" +list);
    	logger.info("해당 농장 맴버 수 =" +listcount);
    	logger.info("내 농장 이름은" + name);
    	logger.info("내 농장관리 아이디는" + id);
    	
    	        // 총 페이지 수
    			int maxpage = (listcount + limit - 1) / limit;
    			
    			// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등..)
    			int startpage = ((page -1) / 10) * 10 + 1;
    			
    			// 현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30 등..)
    			int endpage = startpage + 10 -1;
    			
    			if (endpage > maxpage)
    				endpage =maxpage;
    			
    	if (id == null) {
			logger.info("농장관리보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "농장관리 권한이 없습니다.");
		} else {
			logger.info("상세보기 성공");			
			mv.addObject("mynong_name", name);
			mv.addObject("id", id);
			mv.addObject("memberlist", list);
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.setViewName("oky/mynongsetting");
		}
		return mv;
	}
    
    //내 농장에 구성원 추가
    @RequestMapping(value = "/okyaddid")
    public ModelAndView addid(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "3", required = false) int limit,
    		@RequestParam("ID") String id,@RequestParam("admin") String admin,
    		                 @RequestParam("MYNONG_NAME") String MYNONG_NAME,
    		                    OkyImsi okyimsi,
    		                    ModelAndView mv, 
    		                    HttpServletRequest request) {
    	logger.info("추가할 유저 아이디 :" +id);
    	logger.info("농장 이름: " + okyimsi.getMYNONG_NAME());
    	List<OkyImsi> list1 =okymynongservice.checkid(okyimsi); //농장 멤버 중복 확인
    	int pan1 = 0; //check id 확인용 
   	    if(!(list1.size()==0)) {
   	    	pan1 = 1;
   	    }
   	    System.out.println("리미트"+limit);
   	    System.out.println("페이지" +page);
   	    logger.info("checkid =" +pan1);
    	logger.info("checkidlist =" +list1);
    	int pan2 = okymynongservice.insertusertonong(okyimsi); //농장에 멤버 삽입
    	logger.info("insertusertonong =" +pan2);
    	List<OkyImsi> list2 = okymynongservice.getUserList2(okyimsi); //농장에 있는 모든 멤버 보여줌
    	int listcount = okymynongservice.getSearchListCount(okyimsi.getMYNONG_NAME()); //농장에 있는 모든 멤버 수 구하기
    	logger.info("해당 농장 유저 리스트 =" +list2);
    	logger.info("해당 농장 맴버 수 =" +listcount);
//        // 총 페이지 수
//		int maxpage = (listcount + limit - 1) / limit;
//		
//		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등..)
//		int startpage = ((page -1) / 10) * 10 + 1;
//		
//		// 현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30 등..)
//		int endpage = startpage + 10 -1;
//		
//		if (endpage > maxpage)
//			endpage =maxpage;
//		

//     	mv.addObject("mynong_name", MYNONG_NAME);
//		mv.addObject("id", admin);
//		mv.addObject("memberlist", list2);
//		mv.addObject("page", page);
//		mv.addObject("maxpage", maxpage);
//		mv.addObject("startpage", startpage);
//		mv.addObject("endpage", endpage);
//		mv.addObject("listcount", listcount);
		mv.setViewName("redirect:mynong?name=" + okyimsi.getMYNONG_NAME() + "&id=" + admin);
	return mv;
    }    
}
