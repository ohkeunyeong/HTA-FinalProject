//멤버게시판 컨트롤러
package com.hta.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hta.project.domain.Member;
import com.hta.project.domain.Nong;
import com.hta.project.service.MynongService;
import com.hta.project.service.NongService;
import com.hta.project.service.Nong_CoService;

@Controller
public class NongController {
	private static final Logger logger = LoggerFactory.getLogger(NongController.class);

	@Autowired
	private MynongService mynongservice;

	@Autowired
	private NongService nongservice;

	@Autowired
	private Nong_CoService nongcoservice;

	// savefolder.properties에서 작성한 savefoldername 속성의 값을 String saveFolder에 주입합니다.
	@Value("${savefoldername}")
	private String saveFolder;

	// 메인에서 멤버게시판 클릭 시
	@RequestMapping(value = "/nongprocess")
	public ModelAndView nongprocess(ModelAndView mv, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		logger.info("/nongprocess 멤버게시판접속 ");
		String id = (String) session.getAttribute("id");
		String mynongname = mynongservice.getMynong(id); // 아이디가 속해있는 농장이름 가져오기
		Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (id == null) {
			logger.info("/nongprocess 로그인 안되어있음");
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
		} else if (mynongname == null || list.getMy_farm().equals("3")) { // 로그인 했지만 농장에 소속되어있지 않은경우
			logger.info("/nongprocess 농장없음");
			out.println("<script>");
			out.println("alert('농장 가입 또는 생성 시 이용 가능합니다');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
		} else {
			logger.info("/nongprocess 유저 " + id + "의  농장 이름은: " + mynongname);
			mv.setViewName("redirect:nong?name=" + mynongname);
		}
		return mv;
	}

	// 멤버 게시판
	@GetMapping("/nong")
	public ModelAndView nong(String name, @RequestParam(value = "page", defaultValue = "1", required = false) int page,
			ModelAndView mv, HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		logger.info("/nong 멤버게시판 ");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판보기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				int limit = 5; // 한 페이지에 보여줄 게시판 목록의 수

				int listcount = nongservice.getListCount(name); // 총 게시글 리스트 수를 받아옴

				// 총 페이지 수
				int maxpage = (listcount + limit - 1) / limit;

				// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등)
				int startpage = ((page - 1) / 10) * 10 + 1;

				// endpage: 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등 ...)
				int endpage = startpage + 10 - 1;

				if (endpage > maxpage)
					endpage = maxpage;

				List<Nong> boardlist = nongservice.getBoardList(name, page, limit); // 리스트 받아옴

				mv.setViewName("oky/nong/nong_list");
				mv.addObject("user", list);// 로그인한 유저의 모든 정보
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

	// 멤버 게시판 글쓰기페이지로 이동
	@GetMapping(value = "/nongwrite")
	public ModelAndView nongwrite(String name, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelAndView mv) {
		logger.info("/nongwrite 멤버게시판 글쓰기 접속");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판 글쓰기 이동 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				mv.addObject("name", name);
				mv.addObject("level", level);
				mv.addObject("user", list);// 로그인한 유저의 모든 정보
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

	// 멤버게시판 글추가
	@PostMapping("/nongadd")
	public ModelAndView add(String name, HttpServletRequest request, HttpSession session, HttpServletResponse response,
			ModelAndView mv, Nong nong) throws Exception {
		logger.info("/nongadd 멤버게시판 글추가");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판글쓰기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				MultipartFile uploadfile = nong.getUploadfile();

				if (!uploadfile.isEmpty()) {
					String fileName = uploadfile.getOriginalFilename();// 원래 파일명
					nong.setNong_ori(fileName);// 원래 파일명 저장

					String fileDBName = fileDBName(fileName, saveFolder);
					logger.info("fileDBName = " + fileDBName);

					// transferTO(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
					uploadfile.transferTo(new File(saveFolder + fileDBName));

					// 바뀐 파일명으로 저장
					nong.setNong_file(fileDBName);
				}

				nongservice.insertBoard(nong); // 저장메서드 호출

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

	// 파일 이름 변환하여 저장
	private String fileDBName(String fileName, String saveFolder) {
		// 새로운 폴더 이름 : 오늘 년+월+일
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR); // 오늘 년도 구합니다.
		int month = c.get(Calendar.MONTH) + 1; // 오늘 월 구합니다.
		int date = c.get(Calendar.DATE); // 오늘 일 구합니다.

		String homedir = saveFolder + year + "-" + month + "-" + date;
		logger.info(homedir);
		File path1 = new File(homedir);
		if (!(path1.exists())) {
			path1.mkdir(); // 새로운 폴더를 생성
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
		logger.info("index = " + index);

		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		/**** 확장자 구하기 끝 ***/

		// 새로운 파일명
		String refileName = "bbs" + year + month + date + random + "." + fileExtension;
		logger.info("refileName= " + refileName);

		// 오라클 디비에 저장 될 파일 명
		String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
		logger.info("fileDBName = " + fileDBName);
		return fileDBName;
	}

	// 게시판 상세보기
	@GetMapping("/nongdetail")
	public ModelAndView detail(int num, String name, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelAndView mv) {
		logger.info("/detail 멤버게시판 상세보기 ");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판보기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				Nong nong = nongservice.getDetail(num);
				// board=null; //eroor 페이지 이동 확인하고자 임의로 지정합니다.
				if (nong == null) {
					logger.info("상세보기 실패");
					mv.setViewName("error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "상세보기 실패입니다.");
				} else {
					logger.info("상세보기 성공");
					int count = nongcoservice.getListCount(num);
					mv.setViewName("oky/nong/nong_view");
					mv.addObject("count", count);
					mv.addObject("boarddata", nong);
					mv.addObject("name", name);
					mv.addObject("level", level);
					mv.addObject("user", list);// 로그인한 유저의 모든 정보
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

	// 답글 쓰기프로세스
	@GetMapping("/nongreplyView")
	public ModelAndView add(int num, String name, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelAndView mv) {
		logger.info("/nongreplyView 답글쓰기");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("답글쓰기 프로세스실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				Nong nong = nongservice.getDetail(num);
				if (nong == null) {
					mv.setViewName("error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "게시판 답변글 가져오기 실패");
				} else {
					mv.addObject("boarddata", nong);
					mv.addObject("name", name);
					mv.addObject("level", level);
					mv.addObject("user", list);// 로그인한 유저의 모든 정보
					mv.setViewName("oky/nong/nong_reply");
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

	// 답글쓰기
	@PostMapping("/nongreplyAction")
	public ModelAndView add(Nong nong, String name, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelAndView mv) {
		logger.info("/nongreplyAction 답글쓰기");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("답글쓰기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				int result = nongservice.boardReply(nong);
				if (result == 0) {
					mv.setViewName("error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "게시판 답변 처리실패");
				} else {
					mv.setViewName("redirect:nongdetail?num=" + nong.getNong_num());
					mv.addObject("name", name);
					mv.addObject("level", level);
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

	// 수정 프로세스
	@GetMapping("nongmodifyView")
	public ModelAndView BoardModifyView(int num, String name, HttpServletRequest request, HttpSession session,
			HttpServletResponse response, ModelAndView mv) {
		logger.info("/nongmodifyView 수정 프로세스");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("수정보기 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				Nong boarddata = nongservice.getDetail(num);

				// 글 내용 불러오기 실패한 경우입니다.
				if (boarddata == null) {
					logger.info("수정보기 실패");
					mv.setViewName("error/error");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "수정보기 실패입니다.");
					return mv;
				}
				mv.addObject("boarddata", boarddata);
				mv.addObject("name", name);
				mv.addObject("level", level);
				mv.addObject("user", list);// 로그인한 유저의 모든 정보
				mv.setViewName("oky/nong/nong_modify");
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

	// 멤버게시판 수정
	@PostMapping("/nongmodifyAction")
	public ModelAndView BoardModifyAction(Nong nong, String before_file, String check, String name,
			HttpServletRequest request, HttpSession session, HttpServletResponse response, RedirectAttributes rattr,
			ModelAndView mv) throws Exception {
		logger.info("/nongmodifyAction 멤버게시판 수정");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판 수정 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				boolean usercheck = nongservice.isBoardWriter(nong.getNong_num(), nong.getNong_pass());
				// 비밀번호가 다른 경우
				if (usercheck == false) {
					rattr.addFlashAttribute("result", "passFail");
					rattr.addAttribute("num", nong.getNong_num());
					mv.addObject("name", name);
					mv.addObject("level", level);
					mv.setViewName("redirect:nongmodifyView");
					return mv;
				}

				MultipartFile uploadfile = nong.getUploadfile();

				if (check != null && !check.equals("")) { // 기존파일 그대로 사용하는 경우입니다.
					logger.info("기존파일 그대로 사용합니다.");
					nong.setNong_ori(check);
				} else {

					if (uploadfile != null && !uploadfile.isEmpty()) {
						logger.info("파일 변경되었습니다");
						// 답변글을 수정할 경우 <input type="file" id="upfile" name="uploadfile" >
						// 엘리먼트가 존재하지 않아
						// private MultipartFile uploadfile;에서 uploadfile은 null 입니다.

						String fileName = uploadfile.getOriginalFilename(); // 원래 파일 명
						nong.setNong_ori(fileName);

						String fileDBName = fileDBName(fileName, saveFolder);

						// transferTo(File path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
						uploadfile.transferTo(new File(saveFolder + fileDBName));

						// 바뀐 파일명으로 저장
						nong.setNong_file(fileDBName);
					} else { // uploadfile.isEmpty() 인 경우 - 파일 선택하지 않은 경우
						logger.info("선택 파일 없습니다.");
						// <input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
						// 위 태그에 값이 없다면 ""로 값을 변경합니다.
						nong.setNong_file(""); // ""로 초기화힙니다.
						nong.setNong_ori(""); // ""로 초기화 합니다.
					} // else end
				} // else end

				// DAO에서 수정 메서드 호출하여 수정합니다.
				int result = nongservice.boardModify(nong);
				// 수정에 실패한 경우
				if (result == 0) {
					logger.info("게시판 수정 실패");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "게시판 수정 실패");
					mv.setViewName("error/error");
				} else { // 수정 성공의 경우
					logger.info("게시판 수정 완료");
					// 수정한 글 내용을 보여주기 위해 글 내용 보기 보기 페이지로 이동하기 위해 경로를 설정합니다.
					rattr.addAttribute("num", nong.getNong_num());
					mv.setViewName("redirect:nongdetail");

					// 수정 성공한 경우
					// 파일 삭제를 위해 추가한 부분
					// 수정 전에 파일이 있고 새로운 파일을 선택한 경우는 삭제할 목록을 테이블에 추가합니다.
					if (!before_file.equals("") && !before_file.equals(nong.getNong_file())) {
						nongservice.insert_deleteFile(before_file);
					}
				}
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

	// 게시글 삭제
	@PostMapping("/nongdelete")
	public ModelAndView BoardDeleteAction(String nong_pass, int num, String name, HttpServletRequest request,
			HttpSession session, HttpServletResponse response, RedirectAttributes rattr, ModelAndView mv)
			throws Exception {
		logger.info("/nongdelete 게시글 삭제");
		try { // 유효성 검사를 위한 초기 세팅
			String id = (String) session.getAttribute("id");
			Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기
			String getmynong = mynongservice.getMynong(id);

			String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
			int level = 0;
			if (myfarm.equals("1")) {// 농장 주인인지 판단
				level = 1;
			}
			if ((!(getmynong.equals(name))) || id == null || list.getMy_farm().equals("3")) { // 다른 아이디 접속해서 해당 주소로 들어올
																								// 경우
				logger.info("멤버게시판 삭제 실패");
				mv.setViewName("oky/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "해당 멤버게시판을 볼  권한이 없습니다.");
			} else { // 해당 농장 멤버 접근시
				// 글 삭제 명령을 요청한 사용자가 을을 작성한 사용자인지 판단하기 위해
				// 입력한 비밀번호와 저장된 비밀번호를 비교하여 일치하면 삭제합니다.
				boolean usercheck = nongservice.isBoardWriter(num, nong_pass);

				// 비밀번호 일치하지 않는 경우
				if (usercheck == false) {
					rattr.addFlashAttribute("result", "passFail");
					rattr.addAttribute("num", num);
					mv.addObject("name", name);
					mv.addObject("level", level);
					mv.setViewName("redirect:nongmodifyView");
					return mv;
				}

				// 비밀번호 일치하는 경우 삭제 처리합니다.
				int result = nongservice.boardDelete(num);

				// 삭제 처리 실패한 경우
				if (result == 0) {
					logger.info("게시판 삭제 실패");
					mv.addObject("url", request.getRequestURL());
					mv.addObject("message", "삭제 실패");
					mv.setViewName("error/error");
					return mv;
				}

				// 삭제 처리 성공한 경우 - 글 목록 보기 요청을 전송하는 부분입니다.
				logger.info("게시판 삭제 성공");
				rattr.addFlashAttribute("result", "deleteSuccess");
				mv.setViewName("redirect:nong");
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

	// 게시물 파일 다운
	@PostMapping("/down")
	public void BoardFileDown(String filename, HttpServletRequest request, String original,
			HttpServletResponse response) throws Exception {
		logger.info("/down 파일 다운로드");

		// String savePath = "resources/upload";
		// 서블릿의 실행 환경 정보를 담고 있는 객체를 리턴합니다.
		ServletContext context = request.getSession().getServletContext();
		// String sDownloadPath = context.getRealPath(savePath);

		// String sFilePath = sDownloadPath + "\\" + fileName;
		// "\" 추가하기 위해 "\\" 사용합니다.
		String sFilePath = saveFolder + "/" + filename;
		logger.info(sFilePath);

		byte b[] = new byte[4096];

		// sFilePath에 있는 파일의 MimeType을 구해옵니다.
		String sMimeType = context.getMimeType(sFilePath);
		logger.info("sMimeType>>>" + sMimeType);

		if (sMimeType == null)
			sMimeType = "application/octet-stream";

		response.setContentType(sMimeType);

		// - 이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.
		String sEncoding = new String(original.getBytes("utf-8"), "ISO-8859-1");
		// logger.info(sEncodiong);

		/*
		 * Content-Disposition: attachment: 브라우저는 해당 Content를 처리하지 않고, 다운로드하게 됩니다.
		 */
		response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);
		// package Explorer- 프로젝트 우클릭 - Properties - Project facts에서 자바 버전 1.8로 수정
		try (
				// 웹 브라우저로의 출력 스트림 생성합니다.
				BufferedOutputStream out2 = new BufferedOutputStream(response.getOutputStream());
				// sFilePath로 지정한 파일에 대한 입력 스트림을 생성합니다.
				BufferedInputStream in = new BufferedInputStream(new FileInputStream(sFilePath));) {
			int numRead;
			// read(b, 0, b.length) : 바이트 배열 b의 0번 부터 b.length
			// 크기 만큼 읽어옵니다.
			while ((numRead = in.read(b, 0, b.length)) != -1) { // 읽을 데이터가 존재하는 경우
				// 바이트 배열 b의 0번 부터 numRead크기 만큼 브라우저로 출력
				out2.write(b, 0, numRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 에이젝스로 검색어, 정렬순 받아오기
	@ResponseBody
	@RequestMapping(value = "/list_ajax")
	public Map<String, Object> boardListAjax(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "name", required = true) String name,
			@RequestParam(value = "view", defaultValue = "", required = false) String view,
			@RequestParam(value = "type", defaultValue = "", required = false) String type,
			@RequestParam(value = "search", defaultValue = "", required = false) String search, HttpSession session) {

		String id = (String) session.getAttribute("id");
		Member list = mynongservice.memberinfo(id);// 검색한 맴버 모든 정보 가져오기

		String myfarm = list.getMy_farm();// 일반유저 0, 관리자 1
		int level = 0;
		if (myfarm.equals("1")) {// 농장 주인인지 판단
			level = 1;
		}

		List<Nong> boardlist = new ArrayList<Nong>();

		// 초기 보드리스트 값 설정
		int limit = 5; // 한 페이지에 보여줄 게시판 갯수

		// 총 리스트 수를 받아옵니다.
		int listcount;

		if (type.equals("") && search.equals("")) { // 일반리스트
			logger.info("/list_ajax 검색어 적용안됨");
			boardlist = nongservice.getBoardList(page, limit, view, name);
			listcount = nongservice.getListCount(name);
		} else { // 검색적용된리스트
			logger.info("/list_ajax 검색어 적용됨");
			boardlist = nongservice.getBoardSearchList(page, limit, type, search, view, name);
			listcount = nongservice.getSearchListCount(type, search, name);
		}

		// 총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;

		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 등)
		int startpage = ((page - 1) / 10) * 10 + 1;

		// endpage: 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등 ...)
		int endpage = startpage + 10 - 1;

		if (endpage > maxpage)
			endpage = maxpage;

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("boardlist", boardlist);
		map.put("limit", limit);
		map.put("name", name);
		map.put("level", level);
		return map;
	}

}