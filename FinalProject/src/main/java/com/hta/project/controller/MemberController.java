package com.hta.project.controller;



import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hta.project.domain.Member;
import com.hta.project.service.MemberService;



@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	private static final Logger logger
							= LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Value("${savefoldername}")
	private String saveFolder;
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String join() {
		return "member/member_joinForm";
	}
	

	
	@RequestMapping(value="/idcheck", method = RequestMethod.GET)
	public void idcheck(String id, HttpServletResponse response) throws Exception {
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
		
		MultipartFile uploadfile = member.getUploadfile();
		
		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();
			
			
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName =" + fileDBName);
			
			 
			uploadfile.transferTo(new File(saveFolder + fileDBName));
			
		
			member.setPersnacon(fileName);
		}else {
			member.setPersnacon("profile.png");
		}
		
		int result = memberService.insert(member);
		
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "joinSuccess");
			return "redirect:/main";
		}else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원 가입 실패");
			return "error/error";
		}
	}
	
	private String fileDBName(String fileName, String saveFolder) {
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month =  c.get(Calendar.MONTH) + 1; 
		int date =  c.get(Calendar.DATE); 
		
		String homedir = saveFolder + year + "-" + month + "-" + date;
		logger.info(homedir);
		File path1 = new File(homedir);
		if(!(path1.exists())) {
			path1.mkdir();
		}
		
		
		Random r = new Random();
		int random = r.nextInt(100000000);
		
		int index = fileName.lastIndexOf(".");
		
		logger.info("index = " + index);
		
		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		
		String refileName = "bbs" + year + month +date + random + "." + fileExtension;
		logger.info("refileName = " + refileName);
		
		String fileDBName = "/" + year + "-" +month+ "-" +date+"/"+refileName;
		logger.info("fileDBName = " + fileDBName);
		return fileDBName;
	}
	
	@RequestMapping(value="/loginProcess", method=RequestMethod.POST)
	public String loginProcess(@RequestParam(value="id") String id, 
							   @RequestParam(value="pass") String password,
							   @RequestParam(value="remember", defaultValue="", required=false) String remember,
							   HttpSession session, HttpServletResponse response,
							   RedirectAttributes rattr, HttpServletRequest request,
							   Model mv){
		Map<String, Object> member = memberService.isId(id, password);
		Member m = (Member) member.get("member");
		
		int result = (int) member.get("result");
		
		if(result == 1) {
			Cookie savecookie = new Cookie("saveid", id);
			if(!remember.equals("")) {
				savecookie.setMaxAge(60*60);
				logger.info("쿠키저장: 60*60");
			}else {
				logger.info("쿠키저장: 0");
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

	  @RequestMapping(value = "/update", method = RequestMethod.GET)
	  public ModelAndView member_update(HttpSession session,
			  							ModelAndView mv)     {
		  String id = (String) session.getAttribute("id");
		  if(id==null)  {
			  mv.setViewName("redirect:login");
		  } else {
			  Member m = memberService.member_info(id);
			  mv.setViewName("member/member_updateForm");
			  mv.addObject("member_info", m); 
		  }
		  return mv;
	  }
	  
	  @RequestMapping(value = "/updateProcess", method = RequestMethod.POST)
	  public String updateProcess(Member member, Model model,
			  					  HttpServletRequest request,
			  					  RedirectAttributes rattr)   {
		  	String encPassword = passwordEncoder.encode(member.getPass());
			logger.info(encPassword);
			member.setPass(encPassword);
			
		  int result = memberService.update(member);
		  if (result == 1) {
			  rattr.addFlashAttribute("result", "updateSuccess");
			  return "redirect:/main";
		  } else {
			  model.addAttribute("url", request.getRequestURL());
			  model.addAttribute("message", "정보 수정 실패");
			  return "error/error";
		  }
	  }
	  
}
