package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class ReservationModel {
	@RequestMapping("reservation/reservation.do")
	public String reservation(HttpServletRequest request, HttpServletResponse response) {
		String room_id = request.getParameter("room_id");
		String content_id = request.getParameter("content_id");
		System.out.println("room_id:" + room_id);
		System.out.println("content_id: " + content_id);
		
		
		
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../reservation/reservation.jsp");
		return "../main/main.jsp";
	}
}
