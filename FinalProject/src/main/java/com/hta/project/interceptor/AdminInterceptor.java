package com.hta.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hta.project.domain.Member;

public class AdminInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object object)
			throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		if(id == null || !id.equals("admin")) {
			response.sendRedirect("/project/main");
			return false;
		}
		
		return true;
		
	}
	
	

}
