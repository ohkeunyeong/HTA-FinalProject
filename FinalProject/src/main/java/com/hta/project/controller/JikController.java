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
	
	@Value("${savefoldername}")
	private String saveFolder;
	

	@GetMapping(value = "/write")
	public String jik_write() {
		return "chang/Jik/jik_write";
	}

	@PostMapping("/add")
	
	public String add(Jik jik, HttpServletRequest request)
		throws Exception{
		
		MultipartFile uploadfile = jik.getUploadfile();
		
		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//
			jik.setJik_original(fileName);//
			
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName =" + fileDBName);
			
			 
			uploadfile.transferTo(new File(saveFolder + fileDBName));
			
		
			jik.setJik_file(fileDBName);
		}
		jikService.insertJik(jik);
		
		return "redirect:list";
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
			mv.setViewName("chang/Jik/jik_view");
			mv.addObject("count", count);
			mv.addObject("jikdata", jik);
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
			
			mv.setViewName("chang/Jik/jik_modify");
			return mv;
		}
	
	@PostMapping("/modifyAction")
	public String BoardModifyAction(Jik jikdata, String before_file,
			String check, Model mv, HttpServletRequest request,
			RedirectAttributes rattr
			) throws Exception {

		String url="";

		MultipartFile uploadfile = jikdata.getUploadfile();
		
		if(check != null && !check.equals("")) {
			logger.info("기존파일 그대로 사용합니다.");
			jikdata.setJik_original(check);
			
		} else {
			
			if(uploadfile!=null && !uploadfile.isEmpty()) {
				logger.info("파일 변경되었습니다.");
				
				String fileName = uploadfile.getOriginalFilename();
				jikdata.setJik_original(fileName);
				
				String fileDBName = fileDBName(fileName, saveFolder);
				
				uploadfile.transferTo(new File(saveFolder + fileDBName));
				
				jikdata.setJik_file(fileDBName);
			}else { 
				logger.info("선택 파일 없습니다.");
				
				jikdata.setJik_file("");
				jikdata.setJik_original("");
			}//else end
		}//else end
		
		int result = jikService.jikModify(jikdata);
		
		if(result == 0) {
			logger.info("게시판 수정 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "게시판 수정 실패");
		}else { 
			logger.info("게시판 수정 완료");
	
			url = "redirect:detail";
			rattr.addAttribute("num", jikdata.getJik_num());
			
			
			if(!before_file.equals("") && !before_file.equals(jikdata.getJik_file())) {
				jikService.insert_deleteFile(before_file);
			}
		}
		return url;
	}
	
	@PostMapping("/delete")	
	public String JikDeleteAction(int jik_num,
			Model mv,RedirectAttributes rattr,
			HttpServletRequest request
			)throws Exception {


		int result = jikService.jikDelete(jik_num);
		
		if(result == 0) {
			logger.info("게시판 삭제 실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "삭제 실패");
				return "error/error";
		}
		
		logger.info("게시판 삭제 성공");
		rattr.addFlashAttribute("result", "deleteSuccess");
		return "redirect:list";
	}
	
	@PostMapping("/down")
	public void jikFileDown(String filename,
			HttpServletRequest request, String original,
			HttpServletResponse response) throws Exception{
		
		
		ServletContext context = request.getSession().getServletContext();
		
		// String sFilePath = sDownloadPath + "\\" + fileName;
		
		String sFilePath = saveFolder + "/" + filename;
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

	
	
