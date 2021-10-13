//가계부 컨트롤러
package com.hta.project.controller;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

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

import com.hta.project.domain.Account;
import com.hta.project.domain.Member;
import com.hta.project.service.AccService;
import com.hta.project.service.MynongService;

@Controller
public class AccountController {
	private static final Logger logger
	= LoggerFactory.getLogger(AccountController.class);
	
	@Autowired
	private MynongService mynongservice;	
	@Autowired
	private AccService accservice;
	
	//메인에서 가계부 클릭 시
	@GetMapping("/accprocess")
	public ModelAndView accountprocess (ModelAndView mv, HttpServletRequest request,
    		HttpServletResponse response, HttpSession session) throws Exception {
    	String id = (String)session.getAttribute("id");
    	String mynongname = mynongservice.getMynong(id); //아이디가 속해있는 농장이름 가져오기
		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
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
    	} else if(mynongname == null || list.getMy_farm().equals("3")){ //로그인 했지만 농장에 소속되어있지 않은경우
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
    		String getmynong = mynongservice.getMynong(id);
    		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
    		String myfarm=list.getMy_farm();
    		if(myfarm.equals("1")) {//농장 주인인지 판단
    			level =1;
    		}
        	if ((!(getmynong.equals(name))) || id==null || list.getMy_farm().equals("3")) { //다른 농장 맴버가 접속해서 해당 주소로 들어올 경우
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
        		List<Account> alist = accservice.accViewList(name, yyyyMM);
        		mv.addObject("alist", alist);
        		
        	    //현재 월의 1일에 대한 요일 구하기: 1~7 -->1(일요일), 2(월), 3()......7(토)
        	    // set(y, month-1, 1) --> month-1 : calendar기준 0~11, 우리기준 (1~12)
        	    cal.set(Integer.parseInt(year), Integer.parseInt(month)-1 , 1); //원하는 날짜로 넣어준다
        	    
        	    //현재 월의 마지막 날 구하기
        	    int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        	    int dayofweek = cal.get(Calendar.DAY_OF_WEEK); //요일 구하기
        	 	int hour = cal.get(Calendar.HOUR_OF_DAY);
        	 	int min = cal.get(Calendar.MINUTE);
        	    //해당 달의 일정 받기
//        	    List<MyCalendar> clist=(List<MyCalendar>)request.getAttribute("clist");
        	    
        	 	mv.addObject("alist", alist);
        		mv.addObject("name", getmynong);
        		mv.addObject("id",id);
        		mv.addObject("level", level);
        		mv.addObject("year", year);
        		mv.addObject("month", month);
        		mv.addObject("lastday", lastDay);
        		mv.addObject("dayofweek", dayofweek);
        		mv.addObject("hour", hour);
        		mv.addObject("min", min);
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

	
	//가계부추가
	@RequestMapping(value = "/insertacc", method = RequestMethod.POST)
	public ModelAndView inseracc(Account account, HttpSession session, HttpServletRequest request, ModelAndView mv, String name) {
		logger.info("/insertacc 가계부 추가하기");
		logger.info("/insertacc" + account.getYear()+ " 년" +account.getMonth()+ " 월" +
		 account.getDate()+ " 일" + account.getHour() + "시 "+ 
		 account.getMin() + "분 " +account.getAmount()  + "원 "
		+ "지출명 " +account.getTitle() + "합친명" +account.getMdate() + "농장명"+account.getName()
				 );
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
				logger.info("가계부추가 보기실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 농장 가계부를 추가할  권한이 없습니다."); 
			} else {   //해당 농장 관리자 접근시 
				//mdate는 12자리로 만들어서 DB에 저장해야 함
				String mdate=account.getYear()
						 +isTwo(account.getMonth())
						 +isTwo(account.getDate())
						 +isTwo(account.getHour())
						 +isTwo(account.getMin());
				account.setMdate(mdate);		
				boolean pan = accservice.insertacc(account);
				
				if(pan) {
					mv.setViewName("redirect:account?name=" + name + "&year="+account.getYear()+"&month="+account.getMonth());
				} else {
					mv.setViewName("oky/error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "가계부 추가 실패");					
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
	
//	//가계부 상세보기
//	@ResponseBody
//	@RequestMapping(value= "/accdetail")
//	public Account caldetail(int seq){
//		logger.info("/caldetail 가계부 상세보기");
//		logger.info("/caldetail 넘어온 seq 값은" + seq);
//		
//		Account acclist = accservice.accDetail(seq);	
//		return acclist;
//	}
	
	//가계부삭제하기
	@RequestMapping(value = "/accdelete", method =  RequestMethod.GET)
	public ModelAndView accdelete(int seq, HttpSession session, ModelAndView mv,String name, 
			 				String year, String month,
			              HttpServletRequest request) {
		logger.info("/accdelete 가계부삭제하기 ");
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
			logger.info("가계부 삭제 실패");
			mv.setViewName("oky/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "해당 가계부를 삭제할  권한이 없습니다."); 
		} else {   //해당 농장 관리자 접근시 		
		boolean isS=accservice.accDelete(seq);
		if(isS) {
			mv.setViewName ("redirect:account?name=" + name + "&year="+year+"&month="+month);
		}else {
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "가계부 삭제 실패");			
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
	
	
	//가계부수정하기
	@RequestMapping(value = "/accupdate", method = RequestMethod.POST)
	public ModelAndView accupdate(int seq, Account account, HttpSession session, 
			HttpServletRequest request, ModelAndView mv, String name) {
		logger.info("/accupdate 가계부 수정하기");
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
				logger.info("가계부수정 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 농장 가계부를 수정할  권한이 없습니다."); 
			} else {   //해당 농장 관리자 접근시 
				//mdate는 12자리로 만들어서 DB에 저장해야 함
				String mdate=account.getYear()
						 +isTwo(account.getMonth())
						 +isTwo(account.getDate())
						 +isTwo(account.getHour())
						 +isTwo(account.getMin());
				account.setMdate(mdate);	
				boolean isS=accservice.accUpdate(account);
				if(isS) {
					mv.setViewName("redirect:account?name=" + name + "&year="+account.getYear()+"&month="+account.getMonth());
				} else {
					mv.setViewName("oky/error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "가계부 수정 실패");			
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

    private String toDates2;
    
	public String getToDates2() {
		return toDates2;
	}

	public void setToDates2(String mdate){
		
		//문자열--->date타입으로 변환--> 문자열을 데이트패턴으로 수정 --> 데이트타입으로 변환
		
		//날짜형식: yyyy-MM-dd hh:mm:ss
		String m=mdate.substring(0, 4)  + "-"
		  		+mdate.substring(4, 6)  + "-"
		  		+mdate.substring(6, 8)  + " "		  		
		  		+mdate.substring(8, 10)  + ":"	
		  		+mdate.substring(10)  + ":00";	
		
		SimpleDateFormat sdf=new SimpleDateFormat(" HH시mm분");
		Timestamp tm=Timestamp.valueOf(m);//문자열을 Date타입으로 변환
		
	  	this.toDates2= sdf.format(tm);
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
//		String getmynong = mynongservice.getMynong(id);
//		Member list = mynongservice.memberinfo(id);//검색한 맴버 모든 정보 가져오기
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
