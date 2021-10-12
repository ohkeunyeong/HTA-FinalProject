package com.hta.project.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SupportController {
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);
	
	
	//FAQ접속
	@GetMapping(value = "/faq")
	public String faq() {
		logger.info("/faq 접속");
		return "oky/support/faq";		
	}

	
	
	@GetMapping(value = "/emailprocess")
	public String email(HttpServletResponse response,
			HttpSession session) throws Exception{
		String id = (String)session.getAttribute("id");
		logger.info("/emailprocess 접속");
		response.setContentType("text/html;charset=utf-8");
    	PrintWriter out =response.getWriter();
    	if(id == null) {
			logger.info("/emailprocess 로그인 안되어있음");
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;		
	}
		return null;
  }
}
