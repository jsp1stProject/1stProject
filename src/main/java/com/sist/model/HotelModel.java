package com.sist.model;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

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
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../hotel/hotel_list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("hotel/hotel_list_ajax.do")
	public void hotel_list_ajax(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		String title = request.getParameter("title");
		String searchTitle = request.getParameter("searchTitle");
		System.out.println("title:" + title);
		String[] cat3 = request.getParameterValues("cat3");
		String[] locations = request.getParameterValues("locations");
		String min = request.getParameter("min");
		String max = request.getParameter("max");
		if (min == null || max == null) {
			min = "0";
			max = "100000";
		}
		min = min.replaceAll("[^0-9]", "");
		max = max.replaceAll("[^0-9]", "");
		/*
		String[] cat3 = null;
		String[] locations = null;
		JSONParser parser = new JSONParser();
		try {
			BufferedReader reader = request.getReader();
			StringBuilder jsonBuilder = new StringBuilder();
			String line;
			while ((line = reader.readLine()) != null) {
				jsonBuilder.append(line);
			}
			
			JSONObject jsonObject = (JSONObject) parser.parse(jsonBuilder.toString());
			
			JSONArray cat3Array = (JSONArray) jsonObject.get("cat3");
			JSONArray locationsArray = (JSONArray) jsonObject.get("locations");
			
			
			if (cat3Array != null) {
				cat3 = new String[cat3Array.size()];
				for (int i = 0; i < cat3Array.size(); i++) {
					cat3[i] = (String) cat3Array.get(i);
				}
			}
			if (locationsArray != null) {
				locations = new String[locationsArray.size()];
				for (int i = 0; i < locationsArray.size(); i++) {
					locations[i] = (String) locationsArray.get(i);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		*/
		
		Map map = new HashMap();
		int curPage = Integer.parseInt(page);
		int start = (15 * curPage) - 14;
		int end = 15 * curPage;
		
		map.put("start", start);
		map.put("end", end);
		map.put("cat3", cat3);
		map.put("locations", locations);
		map.put("title", title);
		map.put("searchTitle", map);
		map.put("min", min);
		map.put("max", max);
		
		//System.out.println("cat3: " + cat3.toString() + " and " + cat3);;
		//System.out.println("locations:" + locations.toString());;
		System.out.println("cat3Arr: " + Arrays.toString(cat3));
		System.out.println("locationArr: " + Arrays.toString(locations));
		
		List<HotelVO> list = HotelDAO.hotelListData(map);
		int totalPage = HotelDAO.hotelTotalPage(map);
		int totalCount = HotelDAO.hotelTotalCount(map);
		
		//System.out.println("List: " + list.toString());
		for (HotelVO vo : list) {
			if (vo.getCvo() != null) {
				//System.out.println("ContentVO: " + vo.getCvo());
			}
			if (vo.getHrvo() != null) {
				//System.out.println("HotelRoomVO: " + vo.getHrvo());
			}
		}
		
		final int BLOCK = 10;
		int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
		System.out.println("endPage: " + endPage);
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		JSONArray arr = new JSONArray();
		int i = 0;
		for (HotelVO vo : list) {
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
			obj.put("totalCount", totalCount);
			
			if (i == 0) {
				obj.put("curPage", curPage);
				obj.put("totalPage", totalPage);
				obj.put("startPage", startPage);
				obj.put("endPage", endPage);
			}
			
			arr.add(obj);
			i++;
		}
		System.out.println("JSONArr: " + arr.toJSONString());
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
		
		System.out.println("map: " + vo.getCvo().getMapx());
		
		List<HotelVO> list = HotelDAO.hotelRoomData(content_id);
		List<HotelVO> imglist = HotelDAO.hotelDetailImg(content_id);
		request.setAttribute("imglist", imglist);
		request.setAttribute("list", list);
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../hotel/hotel_detail.jsp");
		return "../main/main.jsp";
	}
}

