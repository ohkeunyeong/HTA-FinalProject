package com.hta.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.CartList;
import com.hta.project.domain.Order_Market;
import com.hta.project.service.CartService;
import com.hta.project.service.OrderService;

@Controller
@RequestMapping(value = "/cart")
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView cart(HttpServletRequest request, ModelAndView mv) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		List<CartList> cartlist  = cartService.getCartList(id);
		int listcount  = cartService.getCartListCount(id);
		
		mv.addObject("cartlist", cartlist);
		mv.addObject("listcount", listcount);
		mv.setViewName("hyun/cart/cart");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public int add(HttpServletRequest request,
			String product_code, int order_de_count) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		int result = cartService.cartInsert(id, product_code, order_de_count);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartDelete", method = RequestMethod.POST)
	public int cartDelete(HttpServletRequest request,
			int cart_num) {
		
		int result = cartService.cartDelete(cart_num);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectionDelete", method = RequestMethod.POST)
	public int selectionDelete(HttpServletRequest request,
			int[] valueArr) {
		
		int result = cartService.cartSelectionDelete(valueArr);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public int order(HttpServletRequest request,
			Order_Market order, String imp_uid, int[] valueArr) {
		logger.info("order()");
		
		int result = orderService.orderInsert(order, valueArr);
		if(result == valueArr.length) {
			return 1;
		}
		
		return 0;
	}
	
	
	
}
