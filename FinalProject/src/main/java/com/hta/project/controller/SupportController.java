package com.hta.project.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.MailVO;
import com.hta.project.domain.Member;
import com.hta.project.service.MynongService;
import com.hta.project.task.SendMail;


@Controller
public class SupportController {
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);
	
	@Autowired
	private MynongService mynongservice;	

	@Autowired
	private SendMail sendMail;
	
	//FAQ접속
	@GetMapping(value = "/faq")
	public String faq() {
		logger.info("/faq 접속");
		return "oky/support/faq";		
	}

	
	
	@GetMapping(value = "/emailprocess")
	public ModelAndView email(HttpServletResponse response,
			HttpSession session, ModelAndView mv) throws Exception{
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
    	Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		mv.addObject("list", list);
		mv.setViewName("oky/support/contactus");
		return mv;
  }
	
	@PostMapping(value ="/mailsend")
	public String mailsend(
			HttpServletResponse response, 
			String userid, String username, String email, String phone,
			String subject, String content, String sender) throws Exception {
		
		MailVO vo = new MailVO();
		vo.setTo(sender);
		vo.setSubject(userid + " 님으로 부터 문의 메일입니다.");
		vo.setContent("회원 아이디: "  + userid +"<br>" 
                +"회원 이름: " + username +"<br>" 
                +"회원 이메일: " + email +"<br>" 
                +"회원 전화번호: " + phone +"<br><br>" 
			       +"------------------------------문의 내용------------------------------" +"<br><br>" 
                +"제목: " + subject + "<br><br>"
                +content);
		sendMail.sendMail(vo);
		logger.info("/mailsend 메일을 정상적으로 보냄");
		response.setContentType("text/html;charset=utf-8");
    	PrintWriter out =response.getWriter();
		out.println("<script>");
		out.println("alert('메일을 정상적으로 보냈습니다.');");
		out.println("location.href = 'main';");
		out.println("</script>");
		out.close();
		return null;
		
	}
}
