//내농장 관리컨트롤러
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Member;
import com.hta.project.service.OkyMynongService;

@Controller
public class OkyMynongSetting {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyMynongSetting.class);
	
	@Autowired
	private OkyMynongService okymynongservice;
	
    
    //내농장에 추가할 유저 아이디 확인
    @ResponseBody
    @RequestMapping(value = "/okyidcheck")
    public Map<String, Object> idcheck(Member member) {
    	logger.info("검색한 유저 아이디 :" +member.getId());
    	List<Member> list = okymynongservice.getUserList(member);
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("list", list);    	
     	return map ;
    }
    
    //메인에서 농장관리 버튼 클릭 시
    @GetMapping("/mynongprocess")
    public ModelAndView mynongprocess (ModelAndView mv,HttpServletRequest request,
    		HttpServletResponse response, HttpSession session)
    		throws ServletException, IOException{   
    	String id = (String)session.getAttribute("id");
    	response.setContentType("text/html;charset=utf-8");
    	PrintWriter out =response.getWriter();
    	if(id == null) {
			logger.info("/mynongprocess 로그인 안되어있음");
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
    	}
    	String mynongname = okymynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
    	int checkmyfarm = okymynongservice.checkmyfarm(id); //MY_FARM 이 뭔값인지 확인
    	logger.info("/mynongprocess checkmyfarm 값은: " +checkmyfarm);
    	if(checkmyfarm != 1) { //myfarm값이 2일시
			logger.info("/mynongprocess 농장관리 접근 권한이 없는 회원");
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
    	}
    	logger.info("mynongprocess 에서 검색된 내 농장 이름: " +mynongname);
    	mv.setViewName("redirect:mynong?name=" + mynongname + "&id=" + id); 
    	return mv;   	
    }
    
    //농장관리 
    @GetMapping("/mynong")
    public ModelAndView mynong (
    		@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "3", required = false) int limit,
			String name, String id, ModelAndView mv, 
			HttpServletRequest request,  HttpSession session, HttpServletResponse response) {
    	try {
    	String sessionid=(String)session.getAttribute("id");
    	if (!(sessionid.equals(id)) || sessionid==null) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("농장관리보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당페이지를 볼  권한이 없습니다.");    	
			return mv;
    	}
    	List<Member> list = null;
    	int listcount = 0;
    	list = okymynongservice.getUserList3(page,limit, name); //농장에 있는 모든 멤버 보여줌
    	listcount = okymynongservice.getSearchListCount(name); //농장에 있는 모든 멤버 수 구하기
    	logger.info("해당 농장 맴버 리스트 =" +list);
    	logger.info("해당 농장 맴버 수 =" +listcount);
    	logger.info("내 농장 이름은" + name);
    	logger.info("내 농장관리 아이디는" + id);
    	
    	        // 총 페이지 수
    			int maxpage = (listcount + limit - 1) / limit;
    			
    			// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등..)
    			int startpage = ((page -1) / 10) * 10 + 1;
    			
    			// 현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30 등..)
    			int endpage = startpage + 10 -1;
    			
    			if (endpage > maxpage)
    				endpage =maxpage;
    			
    	if (id == null) {
			logger.info("농장관리보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "농장관리 권한이 없습니다.");
		} else {
			logger.info("상세보기 성공");			
			mv.addObject("mynong_name", name);
			mv.addObject("id", id);
			mv.addObject("memberlist", list);
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.setViewName("oky/mynong/mynongsetting");
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
    
    //내 농장에 구성원 추가
    @RequestMapping(value = "/okyaddid")
    public ModelAndView addid(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "limit", defaultValue = "3", required = false) int limit,
    		@RequestParam("id") String id,@RequestParam("admin") String admin,
    		                 @RequestParam("mynong_name") String mynong_name,
    		                    Member member,
    		                    ModelAndView mv, 
    		                    HttpServletResponse response)
    		                    throws  ServletException, IOException {

    	
    	logger.info("추가할 유저 아이디 :" +id);
    	logger.info("농장 이름: " + member.getMynong_name());
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out =response.getWriter();
    	
    	Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
    	String name = list.getMynong_name();
    	List<Member> list1 =okymynongservice.checkid(member); //농장 멤버 중복 확인
    	
    	if(name != null && (!name.equals(mynong_name)) && (!(list.getMy_farm().equals("0")))) {//다른 곳에 소속된 회원일 경우
			out.println("<script>");
			out.println("alert('이미 다른  농장에 소속되어 있는 회원입니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;		
    	} else if (list1.size() > 0) { //농장에 멤버 중복
			out.println("<script>");
			out.println("alert('이미 소속되어 있는 회원입니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;    		   		
    	}
    	   	
    	int pan1 = 0; //check id 확인용 
   	    if(!(list1.size()==0)) {
   	    	pan1 = 1;
   	    }
   	    System.out.println("리미트"+limit);
   	    System.out.println("페이지" +page);
   	    logger.info("checkid =" +pan1);
    	logger.info("checkidlist =" +list1);
    	int pan2 = okymynongservice.insertusertonong(member); //농장에 멤버 삽입
    	logger.info("insertusertonong =" +pan2);
    	List<Member> list2 = okymynongservice.getUserList2(member); //농장에 있는 모든 멤버 보여줌
    	int listcount = okymynongservice.getSearchListCount(member.getMynong_name()); //농장에 있는 모든 멤버 수 구하기
    	logger.info("해당 농장 유저 리스트 =" +list2);
    	logger.info("해당 농장 맴버 수 =" +listcount);
		mv.setViewName("redirect:mynong?name=" + member.getMynong_name() + "&id=" + admin);
	return mv;
    }    
    
    //농장에서 멤버 삭제
    @RequestMapping(value = "/deletenongmem", method = RequestMethod.GET)
    public String deletemember(String id, HttpSession session, HttpServletResponse response)
            throws  ServletException, IOException {
    	String admin=(String)session.getAttribute("id");
    	String mynong=okymynongservice.getMynong(admin);
    	response.setContentType("text/html;charset=utf-8");
		PrintWriter out =response.getWriter();
    	okymynongservice.delete(id);
		out.println("<script>");
		out.println("alert('멤버를 삭제하였습니다');");
		out.println("location.href='mynong?name="+ mynong + "&id=" +admin + "'" );
		out.println("</script>");
		out.close();
    	return null;
    }
}
