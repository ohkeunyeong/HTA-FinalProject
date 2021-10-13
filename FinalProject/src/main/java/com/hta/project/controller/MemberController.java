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

import com.hta.project.domain.MailVO;
import com.hta.project.domain.Member;
import com.hta.project.service.MemberService;
import com.hta.project.task.SendMail;




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
	
	@Autowired
	private SendMail sendMail;
	
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
	  
	  //oky 아이디/비밀번호 찾기
	  @RequestMapping(value = "/find", method = RequestMethod.GET)
	  public String find() {
			return "member/member_findForm";		  
	  }
	  
	//oky 아이디/비밀번호 찾기 프로세스
	  @RequestMapping(value = "/findProcess", method = RequestMethod.POST)
	  public String findProcess(HttpServletResponse response, String name, String tel, 
			  String email, String find) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = memberService.findid(name, tel, email); //멤버 정보 찾기
		MailVO vo =new MailVO(); 
		out.println("<script>");
		  if(find.equals("findid") && id!=null) {//아이디찾기 선택시
			  logger.info("/findProcess 아이디찾기");
			  out.println("alert('요청하신 id 는" + id + "입니다');");
			  out.println("history.back()");
		  }else if(find.equals("findpw") && id!=null) {//비밀번호찾기 선택시
			  logger.info("/findProcess 비밀번호찾기");
			  
			  // 랜덤 문자열 생성 출처: https://cofs.tistory.com/266
			  Random rnd =new Random();			 
			  StringBuffer temp =new StringBuffer();
			  for (int i = 0; i < 10; i++) {
				    int rIndex = rnd.nextInt(3);
				    switch (rIndex) {
				    case 0:
				        // a-z
				        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				        break;
				    case 1:
				        // A-Z
				        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				        break;
				    case 2:
				        // 0-9
				        temp.append((rnd.nextInt(10)));
				        break;
				    }
				}
			  logger.info("/findProcess 생성된 랜덤 코드" +temp);
			  String encPassword = passwordEncoder.encode(temp);
			  int result = memberService.findpw(name, tel, email, encPassword);
			  if (result == 1) { //정상적으로 비밀번호 변경 시
			  vo.setTo(email);
			  vo.setSubject("주말농장에서 요청하신 임시 비밀번호 보내드립니다.");
			  vo.setContent("안녕하세요. 주말 농장입니다" + "<br>" +
			                "요청히신 임시 비밀번호는" + 
					        "<br>" + "<br>" +
			                temp + 
			                "<br>" +"<br>"+  
			                "입니다." + "<br>"+ 
					        "로그인 후에 꼭! 비밀번호를 변경해주세요" + "<br>" + 
			                "<br>" + "<br>" +
			                "감사합니다." + "<br>" + 
					        "주말농장 드림");
			  sendMail.sendMail(vo);
			  
		    out.println("alert('임시 비밀번호를 전송하였습니다.');");
		    out.println("history.back()");
			  } else {//비밀번호 변경 실패 시
			out.println("alert('비밀번호를 찾을 수 없습니다. 관리자에게 문의하세요');");
			out.println("history.back()");	  
			  }
		  } else { //해당하는 정보의 멤버가 없을 시 
			out.println("alert('해당정보로 가입된 사용자를 찾을 수 없습니다.');");
			out.println("history.back()");//
		  }
			  
		  out.println("</script>");
		  out.close();		
		  return null;
	  }
	  
}
