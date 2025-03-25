package com.sist.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.ReservationDAO;
import com.sist.vo.HotelVO;
import com.sist.vo.ReservationVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
	
	@RequestMapping("reservation/reservation_ok.do")
	public String reservation_ok(HttpServletRequest request, HttpServletResponse respons) {
		String content_id = request.getParameter("content_id");
		String room_id = request.getParameter("room_id");
		String check_in_date = request.getParameter("check_in_date");
		String check_out_date = request.getParameter("check_out_date");
		int count = Integer.parseInt(request.getParameter("people_count"));
		String arrival_type = request.getParameter("arrival_type");
		int pay_amount = Integer.parseInt(request.getParameter("pay_amount"));
		String status = request.getParameter("status");
		String guest_name = request.getParameter("guest_name");
		String guest_phone = request.getParameter("guest_phone");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date checkInDate = null;
		Date checkOutDate = null;
		try {
			checkInDate = sdf.parse(check_in_date);
			 checkOutDate = sdf.parse(check_out_date);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("user_id");
		
		ReservationVO vo = new ReservationVO();
		vo.setContent_id(Integer.parseInt(content_id));
		vo.setRoom_id(Integer.parseInt(room_id));
		vo.setCheck_in_date(checkInDate);
		vo.setCheck_out_date(checkOutDate);
		vo.setPay_amount(pay_amount);
		vo.setPeople_count(count);
		vo.setArrival_type(arrival_type);
		vo.setStatus(status);
		vo.setGuest_name(guest_name);
		vo.setGuest_phone(guest_phone);
		ReservationDAO.rsvInsert(vo);
		
		System.out.println("con: " + content_id);
		System.out.println("rid: " + room_id);
		System.out.println("cid: " + check_in_date);
		System.out.println("cod: " + check_out_date);
		System.out.println("count: " + count);
		System.out.println("atype: " + arrival_type);
		System.out.println("pamount: " + pay_amount);
		System.out.println("status: " + status);
		System.out.println("gname: " + guest_name);
		System.out.println("gphone: " + guest_phone);
		
		
		//return "../hotel/hotel_list.do";
		return "redirect:../hotel/hotel_list.do";
	}
}
