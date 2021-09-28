//캘린더 관리 컨트롤러
package com.hta.project.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.service.OkyMynongService;

@Controller
public class OkyCalendarController {

	@Autowired
	private OkyMynongService okymynongservice;
	
	private static final Logger logger
	= LoggerFactory.getLogger(OkyCalendarController.class);
	
    //메인에서 캘린더 버튼 클릭 시
    @GetMapping("/calprocess")	
    public ModelAndView calprocess (ModelAndView mv, HttpSession session, HttpServletResponse response)
            throws ServletException, IOException{
    response.setContentType("text/html;charset=utf-8");
	PrintWriter out =response.getWriter();
	String id=(String)session.getAttribute("id");
	String mynongname = okymynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
	
	if(id == null) {
		logger.info("/calprocess 로그인 안되어있음");
		out.println("<script>");
		out.println("alert('로그인 후 이용 가능합니다.');");
		out.println("history.back()");
		out.println("</script>");
		out.close();
		return null;
	} else if(mynongname == null){ //로그인 했지만 농장에 소속되어있지 않은경우
		logger.info("/calprocess 농장없음");
		out.println("<script>");
		out.println("alert('농장 가입 또는 생성 시 이용 가능합니다');");
		out.println("history.back()");
		out.println("</script>");
		out.close();
		return null;		
	} else {
		logger.info("/calprocess 유저 " + id+ "의  농장 이름은: " +mynongname);
		mv.setViewName("redirect:calendar?name=" + mynongname);		
	}
    return mv;
    }
    
    //스케줄 
    @GetMapping("/calendar")
    public ModelAndView calendar (String name, ModelAndView mv, 
    	   HttpServletRequest request,  HttpSession session, HttpServletResponse response) {
    	
    	try {
    		String id=(String)session.getAttribute("id");
    		String getmynong = okymynongservice.getMynong(id);
        	if (!(getmynong.equals(name)) || id==null) { //다른 아이디 접속해서 해당 주소로 들어올 경우
    			logger.info("스케줄 보기 실패");
    			mv.setViewName("oky/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "해당 농장 스케줄을 볼  권한이 없습니다.");    	   		
        	} else {
        		mv.addObject("id",id);
        		mv.addObject("name", getmynong);
        		mv.setViewName("oky/calendar");
        	}
          return mv;
    	} catch (NullPointerException e) {
    		logger.info("비회원 접근");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당페이지를 볼  권한이 없습니다.");    	
			return mv;
    	}    	
    }
}
