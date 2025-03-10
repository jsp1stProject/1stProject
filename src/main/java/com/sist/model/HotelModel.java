package com.sist.model;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.HotelDAO;
import com.sist.vo.ContentVO;
import com.sist.vo.HotelVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HotelModel {
	@RequestMapping("hotel/hotel_list.do")
	public String hotel_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../hotel/hotel_list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("hotel/hotel_list_ajax.do")
	public void hotel_list_ajax(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		String search = request.getParameter("search");
		String[] cat3 = request.getParameterValues("cat3");
		//System.out.println("cat3: " + cat3.toString());
		Map<String, Object> searchMap = new HashMap<String, Object>();
		List<HotelVO> searchList = HotelDAO.hotelFindData(searchMap);
		
		searchMap.put("cat3", cat3);
		
		
		Map map = new HashMap();
		System.out.println("search: " + search);
		int curPage = Integer.parseInt(page);
		int start = (15 * curPage) - 14;
		int end = 15 * curPage;
		
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		
		List<ContentVO> list = HotelDAO.hotelListData(map);
		int totalPage = HotelDAO.hotelTotalPage(search);
		
		System.out.println(list.toString());
		
		final int BLOCK = 10;
		int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		JSONArray arr = new JSONArray();
		int i = 0;
		for (ContentVO vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("content_id", vo.getContent_id());
			obj.put("title", vo.getTitle());
			obj.put("addr1", vo.getAddr1());
			//obj.put("subfacility", vo.getSubfacility());
			obj.put("first_image", vo.getFirst_image());
			obj.put("cat3", vo.getCat3());
			// 가격 등 표시해야 함
			
			if (i == 0) {
				obj.put("curPage", curPage);
				obj.put("totalPage", totalPage);
				obj.put("startPage", startPage);
				obj.put("endPage", endPage);
			}
			
			arr.add(obj);
			i++;
		}
		
		int j = 0;
		JSONArray searchArr = new JSONArray();
		for (HotelVO vo : searchList) {
			JSONObject obj = new JSONObject();
			obj.put("content_id", vo.getCvo().getContent_id());
			obj.put("title", vo.getCvo().getTitle());
			obj.put("addr1", vo.getCvo().getAddr1());
			obj.put("first_image", vo.getCvo().getFirst_image());
			obj.put("cat3", vo.getCvo().getCat3());
			obj.put("subfacility", vo.getSubfacility());
			obj.put("barbecue", vo.getBarbecue());
			obj.put("campfire", vo.getCampfire());
			obj.put("karaoke", vo.getKaraoke());
			obj.put("fitness", vo.getFitness());
			obj.put("publicbath", vo.getPublicbath());
			obj.put("sauna", vo.getSauna());
			obj.put("seminar", vo.getSeminar());
			obj.put("sports", vo.getSports());
			obj.put("offseason_minfee1", vo.getHrvo().getOffseason_minfee1());
			obj.put("peakseason_minfee1", vo.getHrvo().getPeakseason_minfee1());
			
			if (j == 0) {
				obj.put("curPage", curPage);
				obj.put("totalPage", totalPage);
				obj.put("startPage", startPage);
				obj.put("endPage", endPage);
			}
			searchArr.add(obj);
			j++;
		}
		try {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(arr.toJSONString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		
	}
	@RequestMapping("hotel/hotel_detail.do")
	public String hotel_detail(HttpServletRequest request, HttpServletResponse response) {
		int content_id = Integer.parseInt(request.getParameter("content_id")); 
		HotelVO vo = HotelDAO.hotelDetailData(content_id);
		//System.out.println("vo: " + vo.toString());
		List<HotelVO> list = HotelDAO.hotelRoomData(content_id);
		System.out.println("list: " + list.toString());
		
		
		request.setAttribute("list", list);
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../hotel/hotel_detail.jsp");
		return "../hotel/hotel_detail.jsp";
	}
	
	
	
	
	
	
	
	@RequestMapping("hotel/hotel_detail_1.do")
	public String hotel_detail_1(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../hotel/hotel_detail_1.jsp");
		return "../main/main.jsp";
	}
	
}

