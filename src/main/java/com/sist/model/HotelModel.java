package com.sist.model;

import java.io.PipedWriter;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.HotelDAO;
import com.sist.vo.ContentVO;

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
			
			if (i == 0) {
				obj.put("curPage", curPage);
				obj.put("totalPage", totalPage);
				obj.put("startPage", startPage);
				obj.put("endPage", endPage);
			}
			
			arr.add(obj);
			i++;
		}
		
		try {
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(arr.toJSONString());
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		
	}
}

