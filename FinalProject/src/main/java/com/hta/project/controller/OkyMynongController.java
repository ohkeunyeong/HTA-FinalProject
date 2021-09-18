//내농장 컨트롤러
package com.hta.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.OkyMynong;
import com.hta.project.service.OkyMynongService;

@Controller
public class OkyMynongController {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyMynongController.class);
	
	@Autowired
	private OkyMynongService okymynongservice;
	
	@RequestMapping(value="/createmy", method = RequestMethod.GET)
	public ModelAndView createmyhome(ModelAndView mv) {
		  mv.setViewName("oky/createmyhome");
		  return mv;
	}	
	
	@RequestMapping(value="/createProcess", method = RequestMethod.POST)
	public ModelAndView createmyhomeprocess(@RequestParam("MYNONG_NAME") String name) {
		logger.info("입력한 내농장 이름 :" +name);
	    okymynongservice.insertName(name);
		return null;
	}

	//@ResponseBody에 의해 Http의 Body에 추가되어 전송됩니다.
    @ResponseBody
    @RequestMapping(value = "/namecheck")
    public int namecheck(String MYNONG_NAME) {
    	int result = okymynongservice.isName(MYNONG_NAME);
     	return result;
    }

}
