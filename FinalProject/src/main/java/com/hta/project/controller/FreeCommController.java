package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.hta.project.domain.Free_Comm;
import com.hta.project.service.Free_CommService;


@Controller
@RequestMapping(value="/free_comm")
public class FreeCommController {
		

	private static final Logger logger
	= LoggerFactory.getLogger(FreeCommController.class);
	
	
	
		@Autowired
		private Free_CommService free_commService;
		
		@ResponseBody
		@PostMapping(value = "/list")
		public Map<String,Object> free_CommList(int free_num, int state, int page,String free_comm_secret){
			
			List<Free_Comm> list = free_commService.getFree_CommList(free_num, page, state);
			int listcount = free_commService.getListCount(free_num);
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("list", list);
			map.put("listcount", listcount);
			logger.info("state = " + state);
			return map;
		}
		
		@PostMapping(value = "/add")
		public void free_CommAdd(Free_Comm co, HttpServletResponse response)
				throws Exception{
			int ok = free_commService.Free_CommsInsert(co);
			response.getWriter().print(ok);
		}
		
		@RequestMapping(value = "/delete")
		public void free_CommDelete(int free_comm_num, HttpServletResponse response)
				throws Exception{ // int num => Integer.parseInt(request.getParameter)
			
			int select = free_commService.Free_comm_ref_select(free_comm_num);
			int select2 = free_commService.Free_comm_ref_select2(select);
			if(select2>=2) {
				int result2=free_commService.Free_CommsDelete2(free_comm_num);
				response.getWriter().print(result2);
			}else {
				int result = free_commService.Free_CommsDelete(free_comm_num);
				response.getWriter().print(result);
			}
			
			
		}
		
		@RequestMapping(value = "/update")
		public void free_CommUpdate(Free_Comm co, HttpServletResponse response)
				throws Exception{
			int ok = free_commService.Free_CommsUpdate(co);
			response.getWriter().print(ok);
		}
		
		@RequestMapping("/reply")
		public void BoardReplyAction(Free_Comm co, HttpServletResponse response)
				throws Exception{
			logger.info("free_comm_re_ref = " + co.getFree_comm_re_ref());
				int result =free_commService.Free_CommsReply(co);
				
				response.getWriter().print(result);
			}
		
}
