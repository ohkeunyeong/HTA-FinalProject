package com.hta.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hta.project.domain.Free;
import com.hta.project.domain.Free_File;
import com.hta.project.service.FreeService;
import com.hta.project.service.Free_CommService;


@Controller
@RequestMapping(value="/free")
public class FreeController {
	

	private static final Logger logger
	= LoggerFactory.getLogger(FreeController.class);
	
	@Autowired
	private FreeService freeService;
	
	@Autowired
	private Free_CommService free_commService;
	
	@Value("${savefoldername}")
	private String saveFolder;
	
	@Value("${resource.path}")
	private String resourceFolder;
	
	@GetMapping(value = "/write")
	public String free_write() {
		return "chang/Free/free_write";
	}
	
	@RequestMapping(value = "/report")
	public String report() {
		return "chang/Free/free_report";
	}

	@PostMapping("/add")
	@ResponseBody
	public void add(Free free, @RequestParam("article_file") List<MultipartFile> multipartFile
			, HttpServletRequest request, RedirectAttributes rattr)
		throws Exception{
		
		freeService.insertFree(free);
		logger.info(""+free.getFree_num());
		try {
			// 파일이 있을때 탄다.
			if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
				
				for(MultipartFile file:multipartFile) {
					
					String originalFileName = file.getOriginalFilename();	//오리지날 파일명
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
					String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
					
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
					String save = saveFolder+ "/" + year + "-" + month + "-" + date + "/";
					String gofile = "/" + year + "-" + month + "-" + date + "/" + savedFileName;
					File targetFile = new File(save + savedFileName);	
					try {
						InputStream fileStream = file.getInputStream();
						FileUtils.copyInputStreamToFile(fileStream, targetFile); //파일 저장
						freeService.insert_FreeFile(free.getFree_num(),originalFileName,gofile);
						
					} catch (Exception e) {
						//파일삭제
						//FileUtils.deleteQuietly(targetFile);	//저장된 현재 파일 삭제
						e.printStackTrace();
						break;
					}
					
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
/*	
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
*/	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public ModelAndView freelist(
			@RequestParam(value="page",defaultValue="1",required=false) int page,
			ModelAndView mv) {
		
		int limit = 10;
		
		int listcount = freeService.getListCount();
		
		
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1)/10) * 10 + 1;
		
	
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Free> freelist = freeService.getFreeList(page, limit);
		
		mv.setViewName("chang/Free/free_list");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("freelist",freelist);
		mv.addObject("page",page);
		mv.addObject("limit",limit);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/list_ajax")
	public Map<String,Object> freeListAjax(
			@RequestParam(value="page",defaultValue="1",required=false) int page,
			@RequestParam(value="limit",defaultValue="10",required=false) int limit,
			@RequestParam(value="type", defaultValue="-1", required=false) int type,
			@RequestParam(value="search", defaultValue="", required=false) String search
			) {
		
		List<Free> freelist =  new ArrayList<Free>();
		int listcount;
		
		if(type==-1 && search.equals("")) {
			logger.info("/list_ajax 검색어 적용안됨");
			freelist = freeService.getFreeList(page, limit);
			listcount = freeService.getListCount();
		}else { //검색적용된리스트
			logger.info("/list_ajax 검색어 적용됨");
			freelist = freeService.getFreeListSearchList(page, limit, type, search);
			listcount = freeService.getSearchListCount(type, search);
		}
		
		
		
		int maxpage = (listcount + limit - 1) / limit;
		
		
		int startpage = ((page-1)/10) * 10 + 1;
		
		
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("page",page);
		map.put("maxpage",maxpage);
		map.put("startpage",startpage);
		map.put("endpage",endpage);
		map.put("listcount",listcount);
		map.put("freelist",freelist);
		map.put("limit",limit);
		map.put("search_field", type);
		map.put("search_word", search);
		return map;
	}
	
	/* @GetMapping(path = "/detail/{dir}/{id}")
	 public ModelAndView image(@PathVariable(name = "dir") String dir,
			 				   @PathVariable(name = "id") String id) {
			logger.info(dir);
			logger.info(id);
		 return null;
		 //매핑잘되면 -> 로그 -> 아까 코드 
	 }*/

	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		File file = new File(saveFolder+ fileName);
		logger.info(fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping(value= "/isLike")
	@ResponseBody
	public int isLike(int num, String id) {
		int free_like = freeService.isLike(id,num);
		
		return free_like;
	}
	
	@PostMapping("/like")
	@ResponseBody
	public int like(int num, String id){
			int result = freeService.isLike(id, num);
			if(result==1) {
				return 0;
			}else {
				freeService.LikeUp(num);
				return freeService.like(num,id);
			}
			
	}
	
	@PostMapping("/dlike")
	@ResponseBody
	public int dlike(int num, String id){
			int result = freeService.isLike(id, num);
			if(result==1) {
				freeService.LikeDown(num);
				return freeService.dlike(num,id);
			}else {
				return 0;
			}
			
	}
	@GetMapping(value = "/detail")
	public ModelAndView free_detail(int num, String id, ModelAndView mv,
			HttpServletRequest request) {
		
		Free free = freeService.getDetail(num,id);
		List<Free_File> free_file = freeService.getFile(num);
		
		if(free == null) {
			logger.info("디테일 오류");
			mv.setViewName("chang/error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "디테일 페이지 오류");
		}else {
			logger.info("디테일 뷰 페이지 불러오기 성공");
			int count = free_commService.getListCount(num);
			mv.setViewName("chang/Free/free_view");
			mv.addObject("count", count);
			mv.addObject("freedata", free);
			mv.addObject("free_files",free_file);
		}
		return mv;
		
	}
	

	
	@GetMapping("/modifyView")
	public ModelAndView freemodifyView(int num, ModelAndView mv,
								   HttpServletRequest request) {
			
			Free freedata =freeService.getDetail2(num);
			
			if(freedata == null) {
				logger.info("디테일 오류");
				mv.setViewName("chang/error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "디테일 오류");
				return mv;
			}
			logger.info("정보수정 창으로 이동");
			
			mv.addObject("freedata", freedata);
			
			mv.setViewName("chang/Free/free_modify");
			return mv;
		}
	
	@PostMapping("/modifyAction")
	public String BoardModifyAction(Free freedata,
			String check, Model mv, HttpServletRequest request,
			RedirectAttributes rattr
			) throws Exception {

		String url="";

		int result = freeService.FreeModify(freedata);
		
		if(result == 0) {
			logger.info("정보수정 실패");
			mv.addAttribute("url", request.getRequestURL());
			mv.addAttribute("message", "정보수정에 실패 했습니다.");
		}else { 
			logger.info("정보수정에 성공하여 디테일페이지로 이동");
	
			url = "redirect:detail?num="+freedata.getFree_num()+"&id="+freedata.getFree_id();
		}
		return url;
	}
	
	@PostMapping("/delete")	
	public String freeDeleteAction(int free_num,
			Model mv,RedirectAttributes rattr,
			HttpServletRequest request
			)throws Exception {


		int result = freeService.FreeDelete(free_num);
		
		if(result == 0) {
			logger.info("삭제실패");
				mv.addAttribute("url", request.getRequestURL());
				mv.addAttribute("message", "삭제 실패");
				return "chang/error/error";
		}
		
		logger.info("삭제 성공");
		rattr.addFlashAttribute("result", "deleteSuccess");
		return "redirect:list";
		
	}
	
	@PostMapping("/down")
	public void FreeFileDown(String filename,
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

	
	
