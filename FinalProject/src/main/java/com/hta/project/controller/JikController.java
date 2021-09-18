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
	
	// �۾���
	@GetMapping(value = "/write")
	//@RequestMapping(value="/write",method=RequestMethod.GET)
	public String jik_write() {
		return "chang/Jik/jik_write";
	}
	/*
	 * 
	 * ������ �����̳ʴ� �Ű����� jik��ü�� �����ϰ�
	 * jik��ü�� setter �޼������ ȣ���Ͽ� ����� �Է°��� �����մϴ�.
	 * �Ű������� �̸��� setter�� property�� ��ġ�ϸ� �˴ϴ�.
	 */
	@PostMapping("/add")
	//@RequestMapping(value="/write",method=RequestMethod.POST)
	public String add(Jik jik, HttpServletRequest request)
		throws Exception{
		
		MultipartFile uploadfile = jik.getUploadfile();
		
		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//���� ���ϸ�
			jik.setJik_original(fileName);// ���� ���ϸ� ����
			String saveFolder =
					request.getSession().getServletContext().getRealPath("resources")
					+"/upload/";
			String fileDBName = fileDBName(fileName, saveFolder);
			logger.info("fileDBName =" + fileDBName);
			
			//transferTo(File path) : ���ε��� ������ �Ű������� ��ο� �����մϴ�.
			uploadfile.transferTo(new File(saveFolder + fileDBName));
			
			//�ٲ� ���ϸ����� ����
			jik.setJik_file(fileDBName);
		}
		jikService.insertJik(jik); // ����޼��� ȣ��
		
		return "redirect:chang/jik/list";
	}
	
	private String fileDBName(String fileName, String saveFolder) {
		// ���ο� ���� �̸� : ���� ��+��+��
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR); // ���� �⵵ ���մϴ�.
		int month =  c.get(Calendar.MONTH) + 1; // ���� �� ���մϴ�.
		int date =  c.get(Calendar.DATE); // ���� �� ���մϴ�.
		
		String homedir = saveFolder + year + "-" + month + "-" + date;
		logger.info(homedir);
		File path1 = new File(homedir);
		if(!(path1.exists())) {
			path1.mkdir();//���ο� ������ ����
		}
		
		// ������ ���մϴ�.
		Random r = new Random();
		int random = r.nextInt(100000000);
		
		/**** Ȯ���� ���ϱ� ���� ****/
		int index = fileName.lastIndexOf(".");
		// ���ڿ����� Ư�� ���ڿ��� ��ġ ��(index)�� ��ȯ�Ѵ�.
		// indexOf�� ó�� �߰ߵǴ� ���ڿ��� ���� index�� ��ȯ�ϴ� �ݸ�,
		// lastIndexOf�� ���������� �߰ߵǴ� ���ڿ��� index�� ��ȯ�մϴ�.
		// (���ϸ� ���� ������ ���� ��� �� �������� �߰ߵǴ� ���ڿ��� ��ġ�� �����մϴ�.)
		logger.info("index = " + index);
		
		String fileExtension = fileName.substring(index + 1);
		logger.info("fileExtension = " + fileExtension);
		/**** Ȯ���� ���ϱ� �� ****/
		
		// ���ο� ���ϸ�
		String refileName = "bbs" + year + month +date + random + "." + fileExtension;
		logger.info("refileName = " + refileName);
		
		//����Ŭ ��� ����� ���� ��
		String fileDBName = "/" + year + "-" +month+ "-" +date+"/"+refileName;
		logger.info("fileDBName = " + fileDBName);
		return fileDBName;
	}
	
	@RequestMapping(value = "/list", method=RequestMethod.GET)
	public ModelAndView jiklist(
			@RequestParam(value="page",defaultValue="1",required=false) int page,
			ModelAndView mv) {
		
		int limit = 10; //�� �������� ������ �Խ��� ����� ��
		
		int listcount = jikService.getListCount();//�� ����Ʈ ���� �޾ƿɴϴ�.
		
		//�� ������ �� 
		int maxpage = (listcount + limit - 1) / limit;
		
		//���� ������ �׷쿡�� ������ ���� ������ ��(1, 11, 21 �� ...)
		int startpage = ((page-1)/10) * 10 + 1;
		
		//���� ������ �׷쿡�� ������ ������ ������ ��(10, 20, 30 �� ...)
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Jik> jiklist = jikService.getJikList(page, limit);//����Ʈ�� �޾ƿ�
		
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
		
		int listcount = jikService.getListCount();//�� ����Ʈ ���� �޾ƿɴϴ�.
		
		//�� ������ �� 
		int maxpage = (listcount + limit - 1) / limit;
		
		//���� ������ �׷쿡�� ������ ���� ������ ��(1, 11, 21 �� ...)
		int startpage = ((page-1)/10) * 10 + 1;
		
		//���� ������ �׷쿡�� ������ ������ ������ ��(10, 20, 30 �� ...)
		int endpage = startpage + 10 - 1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Jik> jiklist = jikService.getJikList(page, limit);//����Ʈ�� �޾ƿ�
		
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
	//detail?num=9 ��û�� �Ķ���� num�� ���� int num�� �����մϴ�.
	@GetMapping(value = "/detail")
	public ModelAndView jik_detail(int num, ModelAndView mv,
			HttpServletRequest request) {
		Jik jik = jikService.getDetail(num);
		//jik=null;  //error ������ �̵� Ȯ���ϰ��� ���Ƿ� �����մϴ�.
		if(jik == null) {
			logger.info("�󼼺��� ����");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "�󼼺��� �����Դϴ�.");
		}else {
			logger.info("�󼼺��� ����");
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
			mv.addObject("message", "�Խ��� �亯�� �������� ����");
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
				mv.addObject("message", "�Խ��� �亯 ó�� ����");
			}else {
				//mv.setViewName("redirect:list");
				mv.setViewName("redirect:detail?num="+jik.getJik_num());
				//selectKey���� ���� �޾ƿ� ��.
			}
			return mv;
		}
	
	@GetMapping("/modifyView")
	public ModelAndView jikmodifyView(int num, ModelAndView mv,
								   HttpServletRequest request) {
			
			Jik jikdata =jikService.getDetail(num);
			
			if(jikdata == null) {
				logger.info("�������� ����");
				mv.setViewName("error/error");
				mv.addObject("url", request.getRequestURL());
				mv.addObject("message", "���� ������ �ε�����");
				return mv;
			}
			logger.info("���� �󼼺��� ����");
			// ���� �� �������� �̵��� �� ���� �� ������ �����ֱ� ������ jikdata ��ü��
			// ModelAndView ��ü�� �����մϴ�.
			mv.addObject("jikdata", jikdata);
			//�� ���� �� �������� �̵��ϱ� ���� ��θ� �����մϴ�.
			mv.setViewName("jik/jik_modify");
			return mv;
		}
	

	
	@PostMapping("/down")
	public void jikFileDown(String filename,
			HttpServletRequest request, String original,
			HttpServletResponse response) throws Exception{
		
		String savePath = "resources/upload";
		// ������ ���� ȯ�� ������ ��� �ִ� ��ü�� �����մϴ�.
		ServletContext context = request.getSession().getServletContext();
		String sDownloadPath = context.getRealPath(savePath);
		
		// String sFilePath = sDownloadPath + "\\" + fileName;
		// "\" �߰��ϱ� ���� "\\" ����մϴ�.
		String sFilePath = sDownloadPath + "/" + filename;
		logger.info(sFilePath);
		
		byte b[] = new byte[4096];
		
		// sFilePath�� �ִ� ������ MimeType�� �����ݴϴ�.
		String sMimeType = context.getMimeType(sFilePath);
		logger.info("sMimeType>>>" + sMimeType);
		
		if (sMimeType == null)
			sMimeType = "application/octet-stram";
		
		response.setContentType(sMimeType);
		
		// - �� �κ��� �ѱ� ���ϸ��� ������ ���� ������ �ݴϴ�.
		String sEncoding = new String(original.getBytes("utf-8"), "ISO-8859-1");
		//logger.info(sEncoding);
		
		/*
		 * Content-Disposition: attachment;
		 *  �������� �ش� Content�� ó������ �ʰ�, �ٿ�ε��ϰ� �˴ϴ�.
		 */
		response.setHeader("Content-Disposition", "attachment; filename="
							+ sEncoding);
		//Package Explorer- ������Ʈ ��Ŭ�� - Properties - Project facets���� �ڹ� ���� 1.8�� ����
		try (
				// �� ���������� ��� ��Ʈ�� �����մϴ�. (�ڵ����� close() )
				BufferedOutputStream out2 =
						new BufferedOutputStream(response.getOutputStream());
				// sFilePath�� ������ ���Ͽ� ���� �Է� ��Ʈ���� �����մϴ�.
				BufferedInputStream in=
						new BufferedInputStream(new FileInputStream(sFilePath));)
		{
			int numRead;
			// read(b, 0, b.length) : ����Ʈ �迭 b�� 0�� ���� b.length
			// ũ�� ��ŭ �о�ɴϴ�.
			while ((numRead = in.read(b, 0, b.length)) != -1) {//���� �����Ͱ� �����ϴ� ���
				// ����Ʈ �迭 b�� 0�� ���� numReadũ�� ��ŭ �������� ���
				out2.write(b, 0, numRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}	

	
	
