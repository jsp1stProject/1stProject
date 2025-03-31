package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import com.sist.dao.EventDAO;
import com.sist.dao.NoticeDAO;
import com.sist.vo.EventVO;
import com.sist.vo.HotelVO;
import com.sist.vo.NoticeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

@Controller
public class MainModel {
	@RequestMapping("main/main.do")
	public String main_main(HttpServletRequest request, HttpServletResponse response) {
		List<HotelVO> hlist1= EventDAO.mainHotelList(1);
		request.setAttribute("hotelList1", hlist1);
		List<HotelVO> hlist2= EventDAO.mainHotelList(6);
		request.setAttribute("hotelList2", hlist2);
		List<HotelVO> hlist3= EventDAO.mainHotelList(31);
		request.setAttribute("hotelList3", hlist3);


		List<EventVO> list3= EventDAO.mainEventList();
		request.setAttribute("musicalList", list3);

		List<EventVO> list2= EventDAO.mainFesList();
		request.setAttribute("fesList", list2);


		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "home.jsp");
		request.setAttribute("title", "메인");
		return "../main/main.jsp";
	}
	@RequestMapping("main/notice_popup.do")
	public void notice_popup(HttpServletRequest request, HttpServletResponse response) {
		NoticeVO vo = NoticeDAO.noticePopUp();
		JSONObject obj = new JSONObject();
		obj.put("no", vo.getNo());
		obj.put("type", vo.getType());
		obj.put("subject", vo.getSubject());
		obj.put("content", vo.getContent());
		obj.put("dbday", vo.getDbday());
		try {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(obj.toJSONString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}


	
}
