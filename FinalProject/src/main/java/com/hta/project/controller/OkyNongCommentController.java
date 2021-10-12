package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hta.project.domain.Nong_Co;
import com.hta.project.service.OkyNong_CoService;


@Controller
public class OkyNongCommentController {
	
	@Autowired
	private OkyNong_CoService commentService;
	
	
	@ResponseBody
	@PostMapping(value = "/nongcolist")
	public Map<String, Object> CommentList(int nong_num, int page, String name) {
		
		List<Nong_Co> list = commentService.getCommentList(nong_num, page, name);
		int listcount = commentService.getListCount(nong_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listcount", listcount);
		return map;		
	}
	
	@PostMapping(value = "/nongcoadd")
	public void CommentAdd(Nong_Co co, HttpServletResponse response)
			throws Exception{
		int ok = commentService.commentsInsert(co);
		response.getWriter().print(ok);
	}
	
	@PostMapping(value = "/nongcodelete")
	public void CommentDelete(int num, HttpServletResponse response)throws Exception{
		                     //int num => Integer.parseInt(request.getParameter("num"))
		    int result = commentService.commentsDelete(num);
		    response.getWriter().print(result);
	}
	
	@PostMapping(value = "/nongcoupdate")
	public void CommentUpdate(Nong_Co co, HttpServletResponse response) throws Exception {
		System.out.println("conum" + co.getNong_co_num());
		System.out.println("cocon" + co.getNong_co_con());
		int ok = commentService.commentsUpdate(co);
		     response.getWriter().print(ok);		     
	}

}
