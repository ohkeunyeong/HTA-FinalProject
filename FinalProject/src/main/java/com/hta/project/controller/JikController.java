package com.hta.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hta.project.domain.Jik;
import com.hta.project.service.JikService;
import com.hta.project.service.Jik_CommService;


@Controller
@RequestMapping(value="/jik")
public class JikController {
	

	private static final Logger logger
	= LoggerFactory.getLogger(JikController.class);
	
	@Autowired
	private JikService jikService;
	
	@Autowired
	private Jik_CommService jik_commService;
	
	//savefolder.properties에서 작성한 savefoldername 속성의 값을 String saveFolder에 주입합니다.
	@Value("${savefoldername}")
	private String saveFolder;
	

	@GetMapping(value = "/write")
	//@RequestMapping(value="/write",method=RequestMethod.GET)
	public String jik_write() {
		return "chang/Jik/jik_write";
	}

	@PostMapping("/add")
	//@RequestMapping(value="/write",method=RequestMethod.POST)
	public String add(Jik jik, HttpServletRequest request)
		throws Exception{
		
		MultipartFile uploadfile = jik.getUploadfile();
		
		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();
			jik.setJik_original(fileName);
			String saveFolder =
					request.getSession().getServletContext().getRealPath("resources")
					+"/upload/";
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName =" + fileDBName);
			
			
			uploadfile.transferTo(new File(saveFolder + fileDBName));
			
			
			jik.setJik_file(fileDBName);
		}
		jikService.insertJik(jik); 
		
		return "redirect:chang/jik/list";
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
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public ModelAndView jiklist(
			@RequestParam(value="page",defaultValue="1",required=false) int page,
			ModelAndView mv) {
		
		int limit = 10;
		
		int listcount = jikService.getListCount();
		
		
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1)/10) * 10 + 1;
		
	
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Jik> jiklist = jikService.getJikList(page, limit);
		
		mv.setViewName("chang/Jik/jik_list");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("jiklist",jiklist);
		mv.addObject("page",page);
		mv.addObject("limit",limit);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/list_ajax")
	public Map<String,Object> jikListAjax(
			@RequestParam(value="page",defaultValue="1",required=false) int page,
			@RequestParam(value="limit",defaultValue="10",required=false) int limit
			) {
		
		int listcount = jikService.getListCount();
		
		
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1)/10) * 10 + 1;
		
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Jik> jiklist = jikService.getJikList(page, limit);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage);
		map.put("listcount",listcount);
		map.put("jiklist",jiklist);
		map.put("limit",limit);
		return map;
	}
	
	@GetMapping(value = "/detail")
	public ModelAndView jik_detail(int num, ModelAndView mv,
			HttpServletRequest request) {
		Jik jik = jikService.getDetail(num);
		
		if(jik == null) {
			logger.info("상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		}else {
			logger.info("상세보기 성공");
			int count = jik_commService.getListCount(num);
			mv.setViewName("jik/jik_view");
			mv.addObject("count", count);
			mv.addObject("jikdata", jik);
		}
		return mv;
		
	}
	
	@RequestMapping(value="/replyView", method = RequestMethod.GET)
	//@GetMapping("/replyView")
	public ModelAndView jikReplyView(int num, ModelAndView mv,
								  HttpServletRequest request) {
		Jik jik = jikService.getDetail(num);
		if(jik == null) {
			mv.setViewName("error/error");
			mv.addObject("url",request.getRequestURL());
			mv.addObject("message", "게시판 답변글 가져오기 실패");
		}else {
			mv.addObject("jikdata", jik);
			mv.setViewName("jik/jik_reply");
		}
		return mv;
	}
	
	@PostMapping("/replyAction")
	public ModelAndView jikReplyAction(Jik jik, ModelAndView mv,
								   HttpServletRequest request) {
			
			int result =jikService.jikReply(jik);
			
			if(result == 0) {
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "게시판 답변 처리 실패");
			}else {
				//mv.setViewName("redirect:list");
				mv.setViewName("redirect:detail?num="+jik.getJik_num());
			
			}
			return mv;
		}
	
	@GetMapping("/modifyView")
	public ModelAndView jikmodifyView(int num, ModelAndView mv,
								   HttpServletRequest request) {
			
			Jik jikdata =jikService.getDetail(num);
			
			if(jikdata == null) {
				logger.info("수정보기 실패");
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "수정 페이지 로딩실패");
				return mv;
			}
			logger.info("수정 상세보기 성공");
			
			mv.addObject("jikdata", jikdata);
			
			mv.setViewName("jik/jik_modify");
			return mv;
		}
	

	
	@PostMapping("/down")
	public void jikFileDown(String filename,
			HttpServletRequest request, String original,
			HttpServletResponse response) throws Exception{
		
		String savePath = "resources/upload";
		
		ServletContext context = request.getSession().getServletContext();
		String sDownloadPath = context.getRealPath(savePath);
		
		// String sFilePath = sDownloadPath + "\\" + fileName;
		
		String sFilePath = sDownloadPath + "/" + filename;
		logger.info(sFilePath);
		
		byte b[] = new byte[4096];
		
		String sMimeType = context.getMimeType(sFilePath);
		logger.info("sMimeType>>>" + sMimeType);
		
		if (sMimeType == null)
			sMimeType = "application/octet-stram";
		
		response.setContentType(sMimeType);
		
		String sEncoding = new String(original.getBytes("utf-8"), "ISO-8859-1");
		//logger.info(sEncoding);
		

		response.setHeader("Content-Disposition", "attachment; filename="
							+ sEncoding);
	
		try (
			
				BufferedOutputStream out2 =
						new BufferedOutputStream(response.getOutputStream());
				
				BufferedInputStream in=
						new BufferedInputStream(new FileInputStream(sFilePath));)
		{
			int numRead;
			
			while ((numRead = in.read(b, 0, b.length)) != -1) {
				
				out2.write(b, 0, numRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}	

	
	
