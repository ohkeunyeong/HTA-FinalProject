//가계부 컨트롤러
package com.hta.project.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Account;
import com.hta.project.domain.Member;
import com.hta.project.service.OkyMynongService;

@Controller
public class OkyAccountController {
	private static final Logger logger
	= LoggerFactory.getLogger(OkyAccountController.class);
	
	@Autowired
	private OkyMynongService okymynongservice;		
	
	//메인에서 가계부 클릭 시
	@GetMapping("/acc")
	public ModelAndView accountprocess (ModelAndView mv, HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception {
    	String id = (String)session.getAttribute("id");
    	String mynongname = okymynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
    	response.setContentType("text/html;charset=utf-8");
    	PrintWriter out =response.getWriter();
    	if(id == null) {
			logger.info("/accountprocess 로그인 안되어있음");
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
    		logger.info("/accountprocess 유저 " + id+ "의  농장 이름은: " +mynongname);
    		mv.setViewName("redirect:account?name=" + mynongname);	    		
    	}
		return mv;
	}
	
	//가계부
	@GetMapping("/account")
	public ModelAndView account (String name, ModelAndView mv,
			HttpServletRequest request,  HttpSession session, HttpServletResponse response, 
			Account account, String year, String month ) {		    
    	try {
    		Calendar cal = Calendar.getInstance();
    		int level =0;
    		String id=(String)session.getAttribute("id");
    		String getmynong = okymynongservice.getMynong(id);
    		Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
    		String myfarm=list.getMy_farm();
    		if(myfarm.equals("1")) {//농장 주인인지 판단
    			level =1;
    		}
        	if (!(getmynong.equals(name)) || id==null) { //다른 농장 맴버가 접속해서 해당 주소로 들어올 경우
    			logger.info("가계부 보기 실패");
    			mv.setViewName("oky/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "해당 농장 가계부를 볼  권한이 없습니다.");    	   		
        	} else {
        		//calendar를 요청할때 년,월의 값을 전달하지 않으면 현재 달을 보여준다.
        		if(year==null || month ==null) {
        			year=cal.get(Calendar.YEAR)+ ""; 
        			month=cal.get(Calendar.MONTH)+1 + ""; 			
        		}else {
        			//크기를 비교하기 위해 정수형으로 변환: month>12, month<1
        			int yearInt = Integer.parseInt(year);
        			int monthInt = Integer.parseInt(month);
        			
        			//월이 증가하다 12보다 커지면(13,14...)넘어가는 현상을 처리
        		    if(monthInt>12) {
        		    	monthInt=1;//1월로 변경
        		    	yearInt++;//년도는 다음해로 넘어가니깐 년도+1증가시키기
        		    }
        		    
        		    //감소의 경우 처리
        		    if(monthInt<1) {
        		    	monthInt=12;
        		    	yearInt--;
        		    }   
        		    
        		    year=yearInt+""; // 3+2+"", ""+3+2
        		    month=String.valueOf(monthInt);
        		}
        		//월별 일정에 대해 하루마다 일정 3개씩 표시하기 기능 구현
        		String yyyyMM=year+isTwo(month);
//        		List<MyCalendar> clist = okycalservice.calViewList(name, yyyyMM);
//        		mv.addObject("clist", clist);
        		
        	    //현재 월의 1일에 대한 요일 구하기: 1~7 -->1(일요일), 2(월), 3()......7(토)
        	    // set(y, month-1, 1) --> month-1 : calendar기준 0~11, 우리기준 (1~12)
        	    cal.set(Integer.parseInt(year), Integer.parseInt(month)-1 , 1); //원하는 날짜로 넣어준다
        	    
        	    //현재 월의 마지막 날 구하기
        	    int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        	    int dayofweek = cal.get(Calendar.DAY_OF_WEEK); //요일 구하기
        	    //해당 달의 일정 받기
//        	    List<MyCalendar> clist=(List<MyCalendar>)request.getAttribute("clist");
        	    
        	    
        		mv.addObject("name", getmynong);
        		mv.addObject("id",id);
        		mv.addObject("level", level);
        		mv.addObject("year", year);
        		mv.addObject("month", month);
        		mv.addObject("lastday", lastDay);
        		mv.addObject("dayofweek", dayofweek);
        		mv.setViewName("oky/account/account");
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
	
//	//가계부추가폼이동
//	@RequestMapping(value = "/insertaccform", method = RequestMethod.GET)
//	public ModelAndView insertCalForm(HttpSession session, ModelAndView mv,String name, HttpServletRequest request) {
//		logger.info("/insertcalform 일정추가폼으로 이동");
//		try { //유효성 검사를 위한 초기 세팅
//		String id=(String)session.getAttribute("id");
//		Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
//		String getmynong = okymynongservice.getMynong(id);
//		
//		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
//		int level =0;
//		if(myfarm.equals("1")) {//농장 주인인지 판단
//			level =1;
//		}
//		if (level==1 &&(!(getmynong.equals(name)) || id==null)) { //다른 아이디 접속해서 해당 주소로 들어올 경우
//			logger.info("가계부추가 보기실패");
//			mv.setViewName("oky/error/error");
//			mv.addObject("url", request.getRequestURL());
//			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
//		} else {   //해당 농장 관리자 접근시 												
//		mv.addObject("id", id);
//		mv.addObject("name", name);
//		mv.addObject("level", level);
//		mv.setViewName("oky/calendar/insertaccform");
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
	
	
	
	
	
	
////utils	
    private String toDates;
    
	public String getToDates() {
		return toDates;
	}

	public void setToDates(String mdate){
		
		//문자열--->date타입으로 변환--> 문자열을 데이트패턴으로 수정 --> 데이트타입으로 변환
		
		//날짜형식: yyyy-MM-dd hh:mm:ss
		String m=mdate.substring(0, 4)  + "-"
		  		+mdate.substring(4, 6)  + "-"
		  		+mdate.substring(6, 8)  + " "		  		
		  		+mdate.substring(8, 10)  + ":"	
		  		+mdate.substring(10)  + ":00";	
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		Timestamp tm=Timestamp.valueOf(m);//문자열을 Date타입으로 변환
		
	  	this.toDates= sdf.format(tm);
   }
  //토요일과 일요일을 확인해서 "blue"또는 "red" 문자열을 반환하는 메서드
  public static String fontColor(int dayOfWeek, int i) {
    String color="";
	if((dayOfWeek-1 + i)%7==0){//토요일인 경우
		color="blue";
	}else if((dayOfWeek-1 + i)%7==1){//일요일인 경우
		color="red";
	}else {
		color="gray";
	}				
	return color;
  }
  
  //1자리 문자열을 2자리 문자열로 변환하는 메서드 <---삼항연산자의 이해
  public static String isTwo(String msg) {		  
	  return msg.length() < 2 ? "0" + msg : msg;
  }   
}
////utils end	









////가계부
//@GetMapping("/account")
//public ModelAndView account (String name, ModelAndView mv,
//		HttpServletRequest request,  HttpSession session, HttpServletResponse response) {
//
//	try {
//		int level =0;
//		String id=(String)session.getAttribute("id");
//		String getmynong = okymynongservice.getMynong(id);
//		Member list = okymynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
//		String myfarm=list.getMy_farm();
//		if(myfarm.equals("1")) {//농장 주인인지 판단
//			level =1;
//		}
//    	if (!(getmynong.equals(name)) || id==null) { //다른 농장 맴버가 접속해서 해당 주소로 들어올 경우
//			logger.info("가계부 보기 실패");
//			mv.setViewName("oky/error/error");
//			mv.addObject("url", request.getRequestURL());
//			mv.addObject("message", "해당 농장 가계부를 볼  권한이 없습니다.");    	   		
//    	} else {
//    		//본문작성
//    		
//    		
//    		mv.setViewName("oky/account/account");
//    	}
//    	  return mv;
//	} catch (NullPointerException e) {
//    		logger.info("비회원 접근");
//			mv.setViewName("oky/error/error");
//			mv.addObject("url", request.getRequestURL());
//			mv.addObject("message", "해당페이지를 볼  권한이 없습니다.");    	
//			return mv;
//    	}    	
//}
