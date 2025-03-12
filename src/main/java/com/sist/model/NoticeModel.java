package com.sist.model;


import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class NoticeModel {
	@RequestMapping("notice/notice_list.do")
	public String notice_list(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../notice/notice_list.jsp");
		return "../main/main.jsp";
	}
}
