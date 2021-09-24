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
    public Map<String, Object> idcheck(String id) {
    	logger.info("검색한 유저 아이디 :" +id);
    	List<OkyImsi> list = okymynongservice.getUserList(id);
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("list", list);    	
     	return map ;
    }
    
    //농장관리 
    @GetMapping("/mynong")
    public ModelAndView mynong (String name, String id, ModelAndView mv, 
			HttpServletRequest request) {
    	logger.info("내 농장 이름은" + name);
    	logger.info("내 농장관리 아이디는" + id);
    	if (id == null) {
			logger.info("농장관리보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "농장관리 권한이 없습니다.");
		} else {
			logger.info("상세보기 성공");			
			mv.setViewName("oky/mynongsetting");
			mv.addObject("mynong_name", name);
			mv.addObject("id", id);
		}
		return mv;
	}
    	  
    
}
