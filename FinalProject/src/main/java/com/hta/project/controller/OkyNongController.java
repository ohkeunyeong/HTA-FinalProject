//멤버게시판 컨트롤러
package com.hta.project.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Member;
import com.hta.project.domain.Nong;
import com.hta.project.service.OkyMynongService;
import com.hta.project.service.OkyNongService;


@Controller
public class OkyNongController {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyNongController.class);
	
	@Autowired
	private OkyMynongService okymynongservice;

	@Autowired
	private OkyNongService okynongservice;
	
	//메인에서 멤버게시판 클릭 시
	@RequestMapping(value="/nongprocess")
	public ModelAndView nongprocess (ModelAndView mv, HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception {
    	String id = (String)session.getAttribute("id");
    	String mynongname = okymynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
    	response.setContentType("text/html;charset=utf-8");
    	PrintWriter out =response.getWriter();
    	if(id == null) {
			logger.info("/nongprocess 로그인 안되어있음");
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
    	} else if(mynongname == null){ //로그인 했지만 농장에 소속되어있지 않은경우
    		logger.info("/nongprocess 농장없음");
    		out.println("<script>");
    		out.println("alert('농장 가입 또는 생성 시 이용 가능합니다');");
    		out.println("history.back()");
    		out.println("</script>");
    		out.close();
    		return null;		
    	} else {
    		logger.info("/nongprocess 유저 " + id+ "의  농장 이름은: " +mynongname);
    		mv.setViewName("redirect:nong?name=" + mynongname);	    		
    	}
		return mv;
	}
	
	//멤버 게시판
	@GetMapping("/nong")
	public ModelAndView nong(
			String name, @RequestParam(value="page", defaultValue="1", required=false) int page,
			 ModelAndView mv, HttpServletRequest request,  HttpSession session, HttpServletResponse response) {
		logger.info("/nong");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = okymynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if (!(getmynong.equals(name)) || id==null) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("멤버게시판보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");    	   		
		} else {   //해당 농장 멤버 접근시 	
    	int limit = 10; //한 페이지에 보여줄 게시판 목록의 수
    	
    	int listcount = okynongservice.getListCount(name); //총 게시글 리스트 수를 받아옴
    	
    	// 총 페이지 수
    	int maxpage = (listcount + limit - 1) / limit;
    	
    	// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등)
    	int startpage = ((page -1) /10) * 10 +1;
    	
    	// endpage: 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등 ...)
    	int endpage = startpage + 10 - 1;

    	if (endpage > maxpage)
    		endpage = maxpage;
    	
    	List<Nong> boardlist =okynongservice.getBoardList(name, page, limit); //리스트 받아옴
    	
    	
    	mv.setViewName("oky/nong/nong_list");
    	mv.addObject("page", page);
    	mv.addObject("maxpage", maxpage);
    	mv.addObject("startpage", startpage);
    	mv.addObject("endpage", endpage);
    	mv.addObject("listcount", listcount);
    	mv.addObject("boardlist", boardlist);
    	mv.addObject("limit", limit);
		mv.addObject("name", name);
		mv.addObject("level", level);
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
