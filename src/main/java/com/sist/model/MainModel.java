package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import com.sist.dao.EventDAO;
import com.sist.vo.EventVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

@Controller
public class MainModel {
	@RequestMapping("main/main.do")
	public String main_main(HttpServletRequest request, HttpServletResponse response) {

		List<EventVO> list3= EventDAO.mainEventList();
		request.setAttribute("musicalList", list3);

		List<EventVO> list2= EventDAO.mainFesList();
		request.setAttribute("fesList", list2);


		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "home.jsp");
		request.setAttribute("title", "메인");
		return "../main/main.jsp";
	}
	
}
