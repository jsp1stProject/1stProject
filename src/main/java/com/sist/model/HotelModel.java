package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HotelModel {
	@RequestMapping("hotel/hotel_list.do")
	public String hotel_list(HttpServletRequest requst, HttpServletResponse response) {
		
		
		requst.setAttribute("main_jsp", "../hotel/hotel_list.jsp");
		return "../main/main.jsp";
	}
}

