//내농장 컨트롤러
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
public class OkyMynongController {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyMynongController.class);
	
	@Autowired
	private OkyMynongService okymynongservice;
	
	//내농장 생성으로 이동
	@RequestMapping(value="/createmynong", method = RequestMethod.GET)
	public ModelAndView createmynong(ModelAndView mv) {
		  mv.setViewName("oky/createmynong");
		  return mv;
	}	
	
	//내농장 생성
	@RequestMapping(value="/createProcess", method = RequestMethod.POST)
	public ModelAndView createmynongrocess(OkyImsi okyimsi, ModelAndView mv,
			                                HttpServletRequest request) {
		logger.info("입력한 내농장 이름 :" +okyimsi.getMYNONG_NAME());
		logger.info("넘어온 ID :" +okyimsi.getID());
		
		int result = okymynongservice.insertName(okyimsi.getMYNONG_NAME());
		okymynongservice.insertNongName(okyimsi);
		System.out.println(result);
		if (result == 0) {
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "내농장 생성 실패");			
		} else {
			mv.setViewName("redirect:mynong?name=" + okyimsi.getMYNONG_NAME() + "&id=" + okyimsi.getID());
		}
		
		return mv;
	}
	
	//내농장 이름 중복확인
	//@ResponseBody에 의해 Http의 Body에 추가되어 전송됩니다.
    @ResponseBody
    @RequestMapping(value = "/okynamecheck")
    public int namecheck(String MYNONG_NAME) {
    	int result = okymynongservice.isName(MYNONG_NAME);
     	return result;
    }
    
    
    
    
  
    
}
