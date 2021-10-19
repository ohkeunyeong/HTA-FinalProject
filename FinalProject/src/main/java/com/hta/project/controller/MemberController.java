package com.hta.project.controller;



import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
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
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.hta.project.domain.OrderDetail;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Market;
import com.hta.project.service.AdminService;
import com.hta.project.service.MemberService;
import com.hta.project.service.MynongService;
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

	@Autowired
	private MynongService mynongservice;
	
	@Autowired
	private AdminService adminService;

	@Value("${savefoldername}")
	private String saveFolder;
	
	//<util:properties id="folder" location="classpath:pro/savefolder.properties"/>
//		@Value("#{folder['savefoldername']}")
//		private String saveFolder;
	
		
	@Autowired
	private SendMail sendMail;
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String join() {
		return "member/member_joinForm";
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		File file = new File(saveFolder+ fileName);
		logger.info("fileName"+fileName);

		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping(value="/idcheck", method = RequestMethod.GET)
	public void idcheck(String id, HttpServletResponse response) throws Exception {
		int result = memberService.isId(id);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(result);
	}
	
	@RequestMapping(value="/nickcheck", method = RequestMethod.GET)
	public void nickcheck(String nick, HttpServletResponse response) throws Exception {
		int result = memberService.isNick(nick);
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
			member.setPersnacon(fileName);
			
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName =" + fileDBName);
			
			 
			uploadfile.transferTo(new File(saveFolder + fileDBName));
			
		
			member.setOriginal(fileDBName);
		}else {
			String fileDBName = "/"+"profile.png";
			member.setPersnacon("profile.png");
			member.setOriginal(fileDBName);
		}
		
		int result = memberService.insert(member);
		
		
		if (result == 1) {
			rattr.addFlashAttribute("result", "joinSuccess");
			return "redirect:/main";
		}else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "회원 가입 실패");
			return "chang/error/error";
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
							   Model mv) throws Exception{
		Map<String, Object> member = memberService.isId(id, password);
		Member m = (Member) member.get("member");
		int invite = mynongservice.checkmyfarm(id); //oky 농장 초대 여부
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
			rattr.addFlashAttribute("invite", invite); //oky 농장 초대 여부
			return "redirect:/main";
		}else {
			rattr.addFlashAttribute("result", result);
			return "redirect:/member/login";
		}
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String loginout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login(ModelAndView mv,
			@CookieValue(value="saveid", required=false) Cookie readCookie
			) {
		if(readCookie != null) {
			mv.addObject("saveid", readCookie.getValue());
			logger.info("cookie time = " + readCookie.getMaxAge());
		}
		mv.setViewName("member/loginForm");
		return mv;
	}
	
	// 회원 구매목록 리스트
	@GetMapping("/userOrderView")
	public ModelAndView userOrderView(@RequestParam(value="page", defaultValue="1", required=false) int page,
			ModelAndView mv, HttpServletRequest request) {
		logger.info("Admin userOrderView()");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		int limit = 7;
		
		int listcount = adminService.getUserOrderListCount(id);
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page - 1) / 10) * 10 + 1;
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		List<Order_Market> orderlist = adminService.getUserOrderList(id, page, limit);
		
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("orderlist", orderlist);
		mv.addObject("limit", limit);
		
		mv.setViewName("jjs/userOrderView");
		return mv;
	}
	
	// 회원 구매목록 상세보기
	@GetMapping("/userOrderDetail")
	public ModelAndView userOrderDetail(String order_num, ModelAndView mv, 
			   HttpServletRequest request) {
		logger.info("Admin orderDetail()");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		OrderDetail orderdetail = adminService.getUserOrderDetail(id, order_num);
		
		List<OrderDetailList> orderlist = adminService.getUserOrderDetailList(id, order_num);
		
		if(orderdetail==null) {
			logger.info("상세보기 실패");
			mv.setViewName("jjs/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		}else {
			logger.info("상세보기 성공");
			mv.setViewName("jjs/userOrderDetail");
			mv.addObject("orderdetail", orderdetail);
			mv.addObject("orderlist", orderlist);
		}
		return mv;
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
	  
	  @RequestMapping(value = "/updatebefore", method = RequestMethod.GET)
	  public String member_updatebefore(HttpSession session,
			  							ModelAndView mv)     {
		  return "/member/member_updatecheck";
	  }
	  
	  @RequestMapping(value = "/updatebeforeProcess", method = RequestMethod.POST)
	  public String member_updatebeforeProcess(String password,HttpSession session,
			  									Model model)     {
		  String id = (String)session.getAttribute("id");
		  Map<String, Object> member = memberService.isId(id, password);
			int result = (int) member.get("result");
			if(result == 1) {
				return "redirect:update";
			}else {
				model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
				return "/member/member_updatecheck";
			}
			
		  
	  }
	  
	  @RequestMapping(value = "/updateProcess", method = RequestMethod.POST)
	  public String updateProcess( String check, Member member, Model model,
			  					  HttpServletRequest request,
			
			  					  RedirectAttributes rattr) throws Exception, IOException   {
		 
//		  String OriginPass = memberService.OriginPass(member.getId(),member.getPass());
//		  if(OriginPass!=null && OriginPass.equals( member.getPass())){
//			  logger.info(OriginPass, member.getPass());
//		  }else {
//			  String encPassword = passwordEncoder.encode(member.getPass());
//			  logger.info(encPassword);
//			  member.setPass(encPassword);
//		  }
		  
		  	String encPassword = passwordEncoder.encode(member.getPass());
			logger.info(encPassword);
			member.setPass(encPassword);
			
			MultipartFile uploadfile = member.getUploadfile();
			
			if (check != null && !check.equals("")) { //기존 파일 그대로 사용하는 경우입니다. 
				  logger.info("기존파일 그대로 사용합니다.");
				  member.setOriginal(check);
				  // <input type= "hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
				  // 위 문장 때문에 board.setBOARD_FILE()값은 자동 저장됩니다.
		} else {
			
			if (uploadfile!=null && !uploadfile.isEmpty()) {
				logger.info("파일 변경되었습니다.");
				//답변글을 수정할 경우 <input type="file" id="upfile" name="uploadfile" > 엘리먼트
				//private MultipartFile uploadfile;에서 uploadfile은 null입니다.
				
				String fileName = uploadfile.getOriginalFilename(); //원래 파일명
				member.setOriginal(fileName);
				
				String fileDBName = fileDBName(fileName, saveFolder);
				
				// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
			    uploadfile.transferTo(new File(saveFolder + fileName));
			    
			    // 바뀐 파일명으로 저장 
			    member.setPersnacon(fileDBName);
			} else { // uploadfile.isEmpty() 인 경우 - 파일 선택하지 않은 경우 
				logger.info("선택 파일 없습니다.");
				//<input type="hidden" name="BOARD_FILE" value="$boarddata.BOARD_FILE}">
				//위 태그에 값이 있다면 ""로 값을 변경합니다.
				member.setPersnacon("");//""로 초기화합니다.
				member.setOriginal("");//""로 초기화합니다.
			} //else end
		} //else end 
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
	  
	  //oky 회원탈퇴
	  @RequestMapping(value="/delete", method = RequestMethod.GET)
	  public String delete() {
		  return "member/member_deleteForm";
	  }	  
	  
	  //oky 회원탈퇴 프로세스
	  @RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
	  public String deleteProcess(String id, String pass,HttpServletRequest request,  
				HttpSession session, HttpServletResponse response) throws Exception{
		logger.info("/deleteProcess 회원탈퇴");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기	
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1, 멤버 2, 대기 3
		String name=list.getMynong_name();
		if(myfarm.equals("1")) {//농장 관리자인지 판단
			int pan2 = mynongservice.getSerachListAdminCount(id, name);//해당 농장 관리자가 몇명인지 판단 용	
			if(pan2 == 0) {
				logger.info("/deleteProcess 농장관리자 1명");
				out.println("<script>");
				out.println("alert('소속된 농장을 삭제하거나  \\n다른 유저에게 관리자 임명 후 탈퇴 처리 가능합니다.');");
				out.println("history.back()");
				out.println("</script>");
				out.close();		
				return null;
			}			
		}
		int pan1 = memberService.isPass(id, pass);//입력한 아이디 비밀번호 확인(아이디 없으면 -1, 비밀번호 틀리면 0, 정상일 시 1)
		if(pan1 == -1) { //아이디가 없을경우
			logger.info("/deleteProcess 아이디없음");
			out.println("<script>");
			out.println("alert('입력한 정보의 회원을 찾을 수 없습니다.');");
		    out.println("history.back()");
		    out.println("</script>");
			out.close();		
			return null;
		}
		else if (pan1 == 0){ //비밀번호를 틀렸을 경우
			logger.info("/deleteProcess 비밀번호 오류");
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.');");
		    out.println("history.back()");
		    out.println("</script>");
			out.close();	
			return null;
		} else if (pan1 == 1) {//정상
			memberService.delete(id);
			logger.info("/deleteProcess 정상탈퇴처리");
			out.println("<script>");
		    out.println("alert('정상 탈퇴 처리 되었습니다. \\n지금까지 주말농장을 이용해주셔서 감사합니다.');");
		    out.println("window.opener.location.href='logout'");
		    out.println("window.close()");
		    out.println("</script>");
			out.close();	
			
		}
		return null;
	  }
	  
	  //oky 내농장초대
	  @RequestMapping(value="/invite", method = RequestMethod.GET)
	  public ModelAndView invite(ModelAndView mv, HttpSession session) {
		  String id = (String) session.getAttribute("id");
		  String name = mynongservice.getMynong(id); //농장 이름 가져오기
		  Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기	
		  mv.setViewName("member/member_inviteForm");
		  mv.addObject("name", name); 
		  mv.addObject("list", list);
	      return mv;
	  }	
	  //oky 내농장초대 프로세스
	  @RequestMapping(value = "/inviteProcess", method = RequestMethod.POST)
	  public String inviteProcess(String invite, HttpServletRequest request,  
				HttpSession session, HttpServletResponse response) throws Exception{
		logger.info("/inviteProcess 회원초대 프로세스");
		logger.info("/inviteProcess invite는?" + invite);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = (String) session.getAttribute("id");
		if(invite.equals("ok")) {
			mynongservice.okinvite(id);
			out.println("<script>");
			out.println("alert('농장 가입 완료하였습니다.');");
			out.println("window.close()");
		    out.println("window.opener.location.href='../main'");
			out.println("</script>");
			out.close();				
		}else if(invite.equals("no")) {//농장가입 거절
			mynongservice.delete(id);
			out.println("<script>");
			out.println("alert('농장 가입을 거절하였습니다.');");
			out.println("window.close()");
		    out.println("window.opener.location.href='../main'");
			out.println("</script>");
			out.close();	
		}
		return null;
	  }
	  
}
