//멤버게시판 컨트롤러
package com.hta.project.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
	
	//savefolder.properties에서 작성한 savefoldername 속성의 값을 String saveFolder에 주입합니다.
	 @Value("${savefoldername}")
	  private String saveFolder;
	 
	//메인에서 멤버게시판 클릭 시
	@RequestMapping(value="/nongprocess")
	public ModelAndView nongprocess (ModelAndView mv, HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("/nongprocess 멤버게시판접속 ");
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
		logger.info("/nong 멤버게시판 ");
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
	
	//멤버 게시판 글쓰기페이지로 이동
	@GetMapping(value = "/nongwrite")
	public ModelAndView nongwrite(String name,HttpServletRequest request,  
			HttpSession session, HttpServletResponse response, ModelAndView mv) {
		logger.info("/nongwrite 멤버게시판 글쓰기 접속");
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
			logger.info("멤버게시판 글쓰기 이동 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");    	   		
		} else {   //해당 농장 멤버 접근시 	
		mv.addObject("name", name);
		mv.addObject("level", level);
		mv.setViewName("oky/nong/nong_write");
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
	
	//멤버게시판 글추가
	@PostMapping("/add")
	public ModelAndView add(String name,HttpServletRequest request,  
			HttpSession session, HttpServletResponse response, 
			ModelAndView mv, Nong nong) throws Exception {
		logger.info("/add 멤버게시판 글추가");
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
			logger.info("멤버게시판글쓰기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");    	   		
		} else {   //해당 농장 멤버 접근시 				
			MultipartFile uploadfile = nong.getUploadfile();
			
			if (!uploadfile.isEmpty()) {
				String fileName = uploadfile.getOriginalFilename();//원래 파일명
				nong.setNong_ori(fileName);// 원래 파일명 저장
				
				String fileDBName = fileDBName(fileName, saveFolder);
				logger.info("fileDBName = " + fileDBName);
				
				// transferTO(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				
				
				// 바뀐 파일명으로 저장
				nong.setNong_file(fileDBName);
			}
			
			okynongservice.insertBoard(nong); //저장메서드 호출
			
			mv.addObject("name", name);
			mv.setViewName("redirect:nong");
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
	//파일 이름 변환하여 저장
	private String fileDBName(String fileName, String saveFolder) {
		// 새로운 폴더 이름 : 오늘 년+월+일
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR); //오늘 년도 구합니다.
		int month = c.get(Calendar.MONTH) + 1; //오늘 월 구합니다.
		int date = c.get(Calendar.DATE); //오늘 일 구합니다.
		
		String homedir = saveFolder + year + "-" + month + "-" + date;
		logger.info(homedir);
		File path1 = new File(homedir);
		if (!(path1.exists())) {
			path1.mkdir(); //새로운 폴더를 생성
		}
		
		// 난수를 구합니다.
		Random r = new Random();
		int random = r.nextInt(100000000);
		
		/**** 확장자 구하기 시작 ****/
		int index = fileName.lastIndexOf(".");
		// 문자열에서 특정 문자열의 위치 값(index)를 반환합니다.
		// indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
		// lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
		// (파일명에 점에 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
		logger.info("index = " +index);
		
		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		/**** 확장자 구하기 끝 ***/
		
		// 새로운 파일명
		String refileName = "bbs" + year + month + date + random + "." + fileExtension;
		logger.info("refileName= " + refileName);
		
		// 오라클 디비에 저장 될 파일 명
		String fileDBName = "/" + year + "-" +month+ "-" +date+"/"+refileName;
	      logger.info("fileDBName = " + fileDBName);
	      return fileDBName;
	}	
	
}		
	
	
	

//@PostMapping("/add")
//public ModelAndView add(String name,HttpServletRequest request,  
//		HttpSession session, HttpServletResponse response, ModelAndView mv) {
//	logger.info("/nongwrite 멤버게시판 글쓰기 접속");
//	try { //유효성 검사를 위한 초기 세팅
//	String id=(String)session.getAttribute("id");
//	Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
//	String getmynong = okymynongservice.getMynong(id);
//	
//	String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
//	int level =0;
//	if(myfarm.equals("1")) {//농장 주인인지 판단
//		level =1;
//	}
//	if (!(getmynong.equals(name)) || id==null) { //다른 아이디 접속해서 해당 주소로 들어올 경우
//		logger.info("멤버게시판보기 실패");
//		mv.setViewName("oky/error/error");
//		mv.addObject("url", request.getRequestURL());
//		mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");    	   		
//	} else {   //해당 농장 멤버 접근시 	
//		mv.addObject("name", name);
//	    mv.addObject("level", level);
//		mv.setViewName("oky/nong/nong_write");
//		}
//		return mv;
//		} catch (NullPointerException e) {
//			logger.info("비회원 접근");
//			mv.setViewName("oky/error/error");
//			mv.addObject("url", request.getRequestURL());
//			mv.addObject("message", "해당페이지를 볼  권한이 없습니다.");    	
//			return mv;
//		}    	    		
//	}    	
