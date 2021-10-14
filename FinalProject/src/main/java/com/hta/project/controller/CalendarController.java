//캘린더 관리 컨트롤러
package com.hta.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.hta.project.domain.Member;
import com.hta.project.domain.MyCalendar;
import com.hta.project.service.CalService;
import com.hta.project.service.MynongService;

@Controller
public class CalendarController {

	@Autowired
	private MynongService mynongservice;	
	@Autowired
	private CalService calservice;
	
	private static final Logger logger
	= LoggerFactory.getLogger(CalendarController.class);
	
    //메인에서 캘린더 버튼 클릭 시
    @GetMapping("/calprocess")	
    public ModelAndView calprocess (ModelAndView mv, HttpSession session, HttpServletResponse response)
            throws ServletException, IOException{
    response.setContentType("text/html;charset=utf-8");
	PrintWriter out =response.getWriter();
	String id=(String)session.getAttribute("id");
	String mynongname = mynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
	Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
	
	if(id == null) {
		logger.info("/calprocess 로그인 안되어있음");
		out.println("<script>");
		out.println("alert('로그인 후 이용 가능합니다.');");
		out.println("history.back()");
		out.println("</script>");
		out.close();
		return null;
	} else if(mynongname == null || list.getMy_farm().equals("3")){ //로그인 했지만 농장에 소속되어있지 않은경우
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
    	   HttpServletRequest request,  HttpSession session, HttpServletResponse response, String year, String month) {
    	
    	try {
    		int level =0;
    		String id=(String)session.getAttribute("id");
    		String getmynong = mynongservice.getMynong(id);
    		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
    		String myfarm=list.getMy_farm();
    		if(myfarm.equals("1")) {//농장 주인인지 판단
    			level =1;
    		}
        	if ((!(getmynong.equals(name))) || id==null || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
    			logger.info("스케줄 보기 실패");
    			mv.setViewName("oky/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
        	} else {
        		//calendar를 요청할때 년,월의 값을 전달하지 않으면 현재 달을 보여준다.
        		if(year==null || month ==null) {
        			Calendar cal = Calendar.getInstance();
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
        		List<MyCalendar> clist = calservice.calViewList(name, yyyyMM);
        		mv.addObject("clist", clist);
        		mv.addObject("id",id);
        		mv.addObject("name", getmynong);
        		mv.addObject("level", level);
        		mv.setViewName("oky/calendar/calendartest");
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
    
    //일정목록 보기
	@RequestMapping(value = "/calboardlist", method = RequestMethod.GET)
	public ModelAndView calBoardList(String name, HttpServletRequest request, HttpSession session, ModelAndView mv, 
			@RequestParam Map<String, String > ymd) {
		logger.info("/calboardlist 일정목록보기");
		try {
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		logger.info("/calboardlist 농장 이름은" +name);
		logger.info("/calboardlist 농장 접속자 아이디는" +id);
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
    	if ((!(getmynong.equals(name))) || id==null || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("스케줄 보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
    	} else {    		
		if(ymd==null ||ymd.get("year")==null) {//일정목록페이지로 들어온상태이기때문에 ymd 필요없음.
			ymd=(Map<String, String>)session.getAttribute("ymd");
		}else {
			session.setAttribute("ymd", ymd);
		}
		//년월일을 8자리로 만들기 위해 1자리값은 2 자리로 만들어서 8자리로 만든다.
//		String yyyyMMdd = year + (month.length() < 2 ? "0" + month : month)
//				               + (date.length() < 2 ? "0" + date : date);

		String yyyyMMdd = ymd.get("year")
				+ isTwo(ymd.get("month"))
	            + isTwo(ymd.get("date"));

		logger.info("/calboardlist 년월일" +yyyyMMdd);
		List<MyCalendar> list2= calservice.calboardList(getmynong, yyyyMMdd);
		mv.addObject("list", list2);
		mv.addObject("name", name);
		mv.addObject("level", level);
		mv.setViewName("oky/calendar/calboardlist");
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
    
    
    
	//일정추가폼이동
	@RequestMapping(value = "/insertcalform", method = RequestMethod.GET)
	public ModelAndView insertCalForm(HttpSession session, ModelAndView mv,String name, HttpServletRequest request) {
		logger.info("/insertcalform 일정추가폼으로 이동");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if (level==1 &&((!(getmynong.equals(name))) || id==null) || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("일정추가 보기실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
		} else {   //해당 농장 관리자 접근시 												
		mv.addObject("id", id);
		mv.addObject("name", name);
		mv.addObject("level", level);
		mv.setViewName("oky/calendar/insertcalform");
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
	
	//일정추가하기
	@RequestMapping(value = "/insertcalboard", method = RequestMethod.POST)
	public ModelAndView insertCalBoard(MyCalendar calendar,HttpSession session, ModelAndView mv,String name, HttpServletRequest request) {
		logger.info("/insertcalboard 일정추가하기");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if (level==1 &&((!(getmynong.equals(name))) || id==null) || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("일정추가 보기실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다."); 
		} else {   //해당 농장 관리자 접근시 				
		//mdate는 12자리로 만들어서 DB에 저장해야 함
		String mdate=calendar.getYear()
				 +isTwo(calendar.getMonth())
				 +isTwo(calendar.getDate())
				 +isTwo(calendar.getHour())
				 +isTwo(calendar.getMin());
		calendar.setMdate(mdate);
		boolean isS= calservice.insertCal(calendar);

		if(isS) {
			mv.setViewName("redirect:calendar?name=" + name + "&year="+calendar.getYear()+"&month="+calendar.getMonth());
		} else {
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "일정추가 실패");			
		}
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
	
	//일정삭제하기
	@RequestMapping(value = "/calmuldel", method = {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView calMuldel(MyCalendar calendar,HttpSession session, ModelAndView mv,String name,
			              HttpServletRequest request, String[] seq) {
		logger.info("/calmuldel 일정삭제하기 ");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if (level==1 &&((!(getmynong.equals(name))) || id==null) || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("일정 삭제 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다."); 
		} else {   //해당 농장 관리자 접근시 		
		boolean isS=calservice.calMuldel(seq);
		if(isS) {
			mv.addObject("name", name);
			mv.setViewName ("redirect:calboardlist");
		}else {
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "내농장 삭제 실패");			
			}
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
	
	//일정상세내용보기
	@RequestMapping(value = "/caldetail", method = RequestMethod.GET)
	public ModelAndView calDetail(int seq, MyCalendar calendar,HttpSession session, 
			ModelAndView mv,String name,
            HttpServletRequest request) {
		logger.info("/caldetail");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if ((!(getmynong.equals(name))) || id==null || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("일정상세보기 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
		} else {   //해당 농장 멤버 접근시 		
		calendar =calservice.calDetail(seq);								
		mv.addObject("calendar", calendar);	
		mv.addObject("name", name);
		mv.addObject("level", level);
		mv.setViewName("oky/calendar/caldetail");
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
	
	//메인화면 통해 일정상세내용보기
		@RequestMapping(value = "/caldetailmain", method = RequestMethod.GET)
		public ModelAndView calDetailmain(int seq, MyCalendar calendar,HttpSession session, 
				ModelAndView mv,String name,
	            HttpServletRequest request) {
			logger.info("/caldetailmain");
			try { //유효성 검사를 위한 초기 세팅
			String id=(String)session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);
			
			String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
			int level =0;
			if(myfarm.equals("1")) {//농장 주인인지 판단
				level =1;
			}
			if ((!(getmynong.equals(name))) || id==null || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
				logger.info("메인화면으로 부터 일정상세보기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
			} else {   //해당 농장 멤버 접근시 		
			calendar =calservice.calDetail(seq);								
			mv.addObject("calendar", calendar);	
			mv.addObject("name", name);
			mv.addObject("level", level);
			mv.setViewName("oky/calendar/caldetailmain");
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
	//일정수정폼이동
	@RequestMapping(value = "/updateform", method = RequestMethod.GET)
	public ModelAndView updateForm(int seq, ModelAndView mv,String name,
			HttpSession session, 
            HttpServletRequest request, MyCalendar calendar) {
		logger.info("/updateform");
		try { //유효성 검사를 위한 초기 세팅
		String id=(String)session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
		String getmynong = mynongservice.getMynong(id);
		
		String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
		int level =0;
		if(myfarm.equals("1")) {//농장 주인인지 판단
			level =1;
		}
		if (level==1 &&((!(getmynong.equals(name))) || id==null) || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
			logger.info("수정페이지 접근 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다."); 
		} else {   //해당 농장 관리자 접근시 				
		calendar =calservice.calDetail(seq);
		mv.addObject("calendar", calendar);
		mv.addObject("name", name);
		mv.setViewName("oky/calendar/calupdateform");
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
	
	//일정수정하기
	@RequestMapping(value = "/calupdate", method = RequestMethod.POST)
	public ModelAndView calUpdate(int seq, ModelAndView mv,String name,
			HttpSession session, 
            HttpServletRequest request, MyCalendar calendar) {
		logger.info("/calupdate");
		try { //유효성 검사를 위한 초기 세팅
			String id=(String)session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);
			
			String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
			int level =0;
			if(myfarm.equals("1")) {//농장 주인인지 판단
				level =1;
			}
			if (level==1 &&((!(getmynong.equals(name))) || id==null) || list.getMy_farm().equals("3")) { //다른 아이디 접속해서 해당 주소로 들어올 경우
				logger.info("관리자 인증 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다."); 
			} else {   //해당 농장 관리자 접근시 				
		//mdate는 12자리로 만들어서 DB에 저장해야 함
		String mdate=calendar.getYear()
				 +isTwo(calendar.getMonth())
				 +isTwo(calendar.getDate())
				 +isTwo(calendar.getHour())
				 +isTwo(calendar.getMin());
		calendar.setMdate(mdate);
		boolean isS=calservice.calUpdate(calendar);
		if(isS) {
			mv.setViewName("redirect:caldetail?name=" + name + "&seq=" + seq);
		} else {
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "캘린더 수정 실패");			
		}
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
	
    //일정개수보여주기
	@ResponseBody
	@RequestMapping(value = "/calcountajax", method = RequestMethod.POST)
	public String calCountAjax(@RequestParam("yyyyMMdd") String ymd, HttpSession session) {
		logger.info("/calcountajax");
		String id=(String)session.getAttribute("id");
		String name = mynongservice.getMynong(id);
		int count= calservice.calCount(name, ymd);
		
		return count+"";
}	
	
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


//try { //유효성 검사를 위한 초기 세팅
//String id=(String)session.getAttribute("id");
//Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
//String getmynong = mynongservice.getMynong(id);
//
//String myfarm=list.getMy_farm();//일반유저 0, 관리자 1
//int level =0;
//if(myfarm.equals("1")) {//농장 주인인지 판단
//	level =1;
//}
//if (!(getmynong.equals(name)) || id==null) { //다른 아이디 접속해서 해당 주소로 들어올 경우
//	logger.info("스케줄 보기 실패");
//	mv.setViewName("oky/error/error");
//	mv.addObject("url", request.getRequestURL());
//	mv.addObject("message", "해당 농장 캘린더를 볼  권한이 없습니다.");    	   		
//} else {   //해당 농장 멤버 접근시 		
//
//	
//	
//	
//mv.addObject("list", list2);
//mv.addObject("name", name);
//mv.addObject("level", level);
//mv.setViewName("oky/calboardlist");
//}
//return mv;
//} catch (NullPointerException e) {
//	logger.info("비회원 접근");
//	mv.setViewName("oky/error/error");
//	mv.addObject("url", request.getRequestURL());
//	mv.addObject("message", "해당페이지를 볼  권한이 없습니다.");    	
//	return mv;
//}    	    