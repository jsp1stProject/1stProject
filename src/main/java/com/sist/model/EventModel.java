package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.EventDAO;
import com.sist.vo.EventVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.HashMap;
import java.util.List;

@Controller
public class EventModel {
	@RequestMapping("event/event_list.do")
	public String main_main(HttpServletRequest request, HttpServletResponse response) {
		HashMap map = new HashMap();
		map.put("key", request.getParameter("key"));
		List<EventVO> list= EventDAO.eventSearchList(map);
		request.setAttribute("list", list);

		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../event/event_list.jsp");
		request.setAttribute("title", "검색결과");
		return "../main/main.jsp";
	}
	
}
