package com.sist.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.ReservationDAO;
import com.sist.vo.HotelVO;

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
		HotelVO vo = ReservationDAO.rsvHotelData(Integer.parseInt(room_id));
		
		Map<String, String> facilityMap = Map.of(
		        "bathfacility", "욕실",
		        "aircondition", "에어컨",
		        "tv", "TV",
		        "pc", "PC",
		        "internet", "인터넷",
		        "refrigerator", "냉장고",
		        "hairdryer", "헤어드라이어"
		    );

	    List<String> facilities = new ArrayList<>();

	    if ("Y".equals(vo.getHrvo().getBathfacility())) facilities.add(facilityMap.get("bathfacility"));
	    if ("Y".equals(vo.getHrvo().getAircondition())) facilities.add(facilityMap.get("aircondition"));
	    if ("Y".equals(vo.getHrvo().getTv())) facilities.add(facilityMap.get("tv"));
	    if ("Y".equals(vo.getHrvo().getPc())) facilities.add(facilityMap.get("pc"));
	    if ("Y".equals(vo.getHrvo().getInternet())) facilities.add(facilityMap.get("internet"));
	    if ("Y".equals(vo.getHrvo().getRefrigerator())) facilities.add(facilityMap.get("refrigerator"));
	    if ("Y".equals(vo.getHrvo().getHairdryer())) facilities.add(facilityMap.get("hairdryer"));
	    
	    String facilityStr = String.join(", ", facilities);
	    
	    request.setAttribute("facility", facilityStr);
		request.setAttribute("vo", vo);
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../reservation/reservation.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("reservation/reservation_stay.do")
	public String reservation_stay(HttpServletRequest request, HttpServletResponse response) {
		String room_id = request.getParameter("room_id");
		String content_id = request.getParameter("content_id");
		System.out.println("room_id:" + room_id);
		System.out.println("content_id: " + content_id);
		HotelVO vo = ReservationDAO.rsvHotelData(Integer.parseInt(room_id));
		
		Map<String, String> facilityMap = Map.of(
		        "bathfacility", "욕실",
		        "aircondition", "에어컨",
		        "tv", "TV",
		        "pc", "PC",
		        "internet", "인터넷",
		        "refrigerator", "냉장고",
		        "hairdryer", "헤어드라이어"
		    );

	    List<String> facilities = new ArrayList<>();

	    if ("Y".equals(vo.getHrvo().getBathfacility())) facilities.add(facilityMap.get("bathfacility"));
	    if ("Y".equals(vo.getHrvo().getAircondition())) facilities.add(facilityMap.get("aircondition"));
	    if ("Y".equals(vo.getHrvo().getTv())) facilities.add(facilityMap.get("tv"));
	    if ("Y".equals(vo.getHrvo().getPc())) facilities.add(facilityMap.get("pc"));
	    if ("Y".equals(vo.getHrvo().getInternet())) facilities.add(facilityMap.get("internet"));
	    if ("Y".equals(vo.getHrvo().getRefrigerator())) facilities.add(facilityMap.get("refrigerator"));
	    if ("Y".equals(vo.getHrvo().getHairdryer())) facilities.add(facilityMap.get("hairdryer"));
	    
	    String facilityStr = String.join(", ", facilities);
	    
	    request.setAttribute("facility", facilityStr);
		request.setAttribute("vo", vo);
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../reservation/reservation_stay.jsp");
		return "../main/main.jsp";
	}
}
