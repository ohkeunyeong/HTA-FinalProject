package com.hta.project.controller;


import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Member;
import com.hta.project.domain.MyCalendar;
import com.hta.project.service.CalService;
import com.hta.project.service.CartService;
import com.hta.project.service.MemberService;
import com.hta.project.service.MynongService;
import com.hta.project.service.NongService;
import com.hta.project.service.ShopService;


@Controller
public class MainController {

	private static final Logger logger
    = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private ShopService shopService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberService JikService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private MynongService mynongservice;

	@Autowired
	private NongService nongservice;
	
	@Autowired
	private CalService calservice;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		  mv.setViewName("main/main");
		  return mv;
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public ModelAndView cart(HttpServletRequest request,
							ModelAndView mv) {
		  mv.setViewName("hyun/cart/cart");
		  HttpSession session = request.getSession();
		  String id = (String)session.getAttribute("id");
		  return mv;
	}
	
	@RequestMapping(value = "/orderSuccess", method = RequestMethod.GET)
	public String orderSuccess() {
		logger.info("orderSuccess()");
		
		return "jjs/orderSuccess";
	}
	
//	//메인에 농장일정 가져오기 
//	@RequestMapping(value = "/main", method = RequestMethod.GET)
//	public ModelAndView main_calBoardList( HttpServletRequest request, HttpSession session, ModelAndView mv,
//			@RequestParam Map<String, String> ymd) {
//		logger.info("/main_calboardlist 메인에서 일정목록보기");
//		try {
//			String id = (String) session.getAttribute("id");
//			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
//			String name = mynongservice.getMynong(id);
//
//			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
//			int level = 0;
//			logger.info("/main_calboardlist 농장 이름은" + name);
//			logger.info("/main_calboardlist 농장 접속자 아이디는" + id);
//			if (myfarm.equals("1")) {// 농장 주인인지 판단
//				level = 1;
//			}
//			if (id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
//																								// 경우
//				logger.info("스케줄 보기 실패");
//				mv.setViewName("oky/error/error");
//				mv.addObject("url", request.getRequestURL());
//				mv.addObject("message", "해당 농장 캘린더를 볼 권한이 없습니다.");
//			} else {
//				if (ymd == null || ymd.get("year") == null) {// 일정목록페이지로 들어온상태이기때문에 ymd 필요없음.
//					ymd = (Map<String, String>) session.getAttribute("ymd");
//				} else {
//					session.setAttribute("ymd", ymd);
//				}
//
//				String yyyyMMdd = ymd.get("year") + isTwo(ymd.get("month")) + isTwo(ymd.get("date"));
//				logger.info("/main_calboardlist 년월일" + yyyyMMdd);
//				List<MyCalendar> list2 = calservice.main_calboardList(name, yyyyMMdd);
//				mv.addObject("list", list2);
//				mv.addObject("name", name);
//				mv.addObject("level", level);
//				mv.addObject("user", list);// 로그인한 유저의 모든 정보
//				mv.setViewName("main/main");
//			}
//			return mv;
//		} catch (NullPointerException e) {
//			logger.info("비회원 접근");
//			e.printStackTrace();
//			mv.setViewName("oky/error/error");
//			mv.addObject("url", request.getRequestURL());
//			mv.addObject("message", "해당페이지를 볼 권한이 없습니다.");
//			return mv;
//		}
//	}
	
	private String toDates;

	public String getToDates() {
		return toDates;
	}

	public void setToDates(String mdate) {

		// 문자열--->date타입으로 변환--> 문자열을 데이트패턴으로 수정 --> 데이트타입으로 변환

		// 날짜형식: yyyy-MM-dd hh:mm:ss
		String m = mdate.substring(0, 4) + "-" + mdate.substring(4, 6) + "-" + mdate.substring(6, 8) + " "
				+ mdate.substring(8, 10) + ":" + mdate.substring(10) + ":00";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		Timestamp tm = Timestamp.valueOf(m);// 문자열을 Date타입으로 변환

		this.toDates = sdf.format(tm);
	}

	// 토요일과 일요일을 확인해서 "blue"또는 "red" 문자열을 반환하는 메서드
	public static String fontColor(int dayOfWeek, int i) {
		String color = "";
		if ((dayOfWeek - 1 + i) % 7 == 0) {// 토요일인 경우
			color = "blue";
		} else if ((dayOfWeek - 1 + i) % 7 == 1) {// 일요일인 경우
			color = "red";
		} else {
			color = "gray";
		}
		return color;
	}

	// 1자리 문자열을 2자리 문자열로 변환하는 메서드 <---삼항연산자의 이해
		public static String isTwo(String msg) {
			return msg.length() < 2 ? "0" + msg : msg;
		}
	
	
	//footer - 주말농장 소개 바로가기 이동 
			@RequestMapping("/farm_info")
			public String farm_info() {
				return "main/farm_info";
			}
}
