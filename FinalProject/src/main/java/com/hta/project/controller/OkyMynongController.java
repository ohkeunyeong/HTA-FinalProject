//내농장 생성 컨트롤러
package com.hta.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Member;
import com.hta.project.service.OkyMynongService;

@Controller
public class OkyMynongController {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyMynongController.class);
	
	@Autowired
	private OkyMynongService okymynongservice;
	
	//내농장 생성으로 이동
	@RequestMapping(value="/createmynong", method = RequestMethod.GET)
	public ModelAndView createmynong(ModelAndView mv, HttpSession session, HttpServletResponse response)
			throws  ServletException, IOException{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out =response.getWriter();
		String id=(String)session.getAttribute("id");
		if(id == null) {
			logger.info("/createmynong 로그인 안되어있음");
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
		} else {
		  int pan =okymynongservice.checkmyfarm(id); //농장 관리자일시 1, 농장 구성원이면 2
		  logger.info("checkmyfarm 넘어온 pan 값: " +pan);
		  if (pan != 0) {
				out.println("<script>");
				out.println("alert('이미 농장에 소속되어 있습니다.');");
				out.println("history.back()");
				out.println("</script>");
				out.close();
				return null;			  
		  }
		  mv.setViewName("oky/mynong/createmynong");
		  return mv;
		}
	}	
	
	//내농장 생성
	@RequestMapping(value="/createProcess", method = RequestMethod.POST)
	public ModelAndView createmynongrocess(Member member, ModelAndView mv,
			                                HttpServletRequest request) {
		logger.info("입력한 내농장 이름 :" +member.getName());
		logger.info("넘어온 ID :" +member.getId());
		
		int result = okymynongservice.insertName(member.getMynong_name());
		okymynongservice.insertNongName(member);
		if (result == 0) {
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "내농장 생성 실패");			
		} else {
			mv.setViewName("redirect:mynong?name=" + member.getMynong_name() + "&id=" + member.getId());
		}
		
		return mv;
	}
	
	//내농장 이름 중복확인
	//@ResponseBody에 의해 Http의 Body에 추가되어 전송됩니다.
    @ResponseBody
    @RequestMapping(value = "/okynamecheck")
    public int namecheck(String mynong_name) {
    	int result = okymynongservice.isName(mynong_name);
     	return result;
    }
    
    
    
    
  
    
}
