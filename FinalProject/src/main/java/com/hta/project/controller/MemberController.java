package com.hta.project.controller;



import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hta.project.domain.Member;
import com.hta.project.service.MemberService;



@Controller
@RequestMapping(value="/member")//http://localhost:8088/myhome5/member/�� �����ϴ� �ּ� ����
public class MemberController {
	//import org.slf4j.Logger;
	//import org.slf4j.LoggerFactory;
	private static final Logger logger
							= LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	

	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String join() {
		return "member/member_joinForm";
	}
	

	
	@RequestMapping(value="/idcheck", method = RequestMethod.GET)
	public void idcheck(@RequestParam("id") String id,
						   HttpServletResponse response) throws Exception {
		int result = memberService.isId(id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	
	@RequestMapping(value="/joinProcess", method = RequestMethod.POST)
	public String joinProcess(Member member,
						   RedirectAttributes rattr,
						   Model model,
						   HttpServletRequest request) throws Exception {
	
		String encPassword = passwordEncoder.encode(member.getPass());
		logger.info(encPassword);
		member.setPass(encPassword);
		
		
		int result = memberService.insert(member);
		
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "joinSuccess");
			return "redirect:/main";
		}else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원가입을 실패하였습니다.");
			return "error/error";
		}
	}
	
	@RequestMapping(value="/loginProcess", method=RequestMethod.POST)
	public String loginProcess(@RequestParam(value="id") String id, 
							   @RequestParam(value="pass") String password,
							   @RequestParam(value="remember", defaultValue="", required=false) String remember,
							   HttpSession session, HttpServletResponse response,
							   RedirectAttributes rattr){
		Map<String, Object> member = memberService.isId(id, password);
		Member m = (Member) member.get("member");
		
		int result = (int) member.get("result");
		
		if(result == 1) {
			// 로그인 성공
			Cookie savecookie = new Cookie("saveid", id);
			if(!remember.equals("")) {
				savecookie.setMaxAge(60*60);
				logger.info("쿠키저장 : 60 * 60");
			}else {
				logger.info("쿠키저장 : 0");
				savecookie.setMaxAge(0);
			}
			response.addCookie(savecookie);
			session.setAttribute("id", m.getId());
			session.setAttribute("nick", m.getNick());
			return "redirect:/main";
		}else {
			rattr.addFlashAttribute("result", result);
			return "redirect:/main";
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String loginout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	
	@ResponseBody
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public Map<String, Object> login(@CookieValue(value="saveid", required=false) Cookie readCookie
			) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(readCookie != null) {
			map.put("saveid", readCookie.getValue());
			logger.info("cookie time = " + readCookie.getMaxAge());
		}
		return map;
	}

}
