package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.EventDAO;
import com.sist.vo.EventVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@Controller
public class EventModel {
	@RequestMapping("event/event_list.do")
	public String event_list(HttpServletRequest request, HttpServletResponse response) {
		String[] catelist={"전통공연","연극","뮤지컬","오페라","전시회","박람회","무용","클래식","콘서트","영화","스포츠","기타행사"};
		request.setAttribute("catelist",catelist);

        HashMap map = new HashMap();
		map.put("key", request.getParameter("key"));
		map.put("start",1);
		map.put("end",10);
		List<EventVO> list= EventDAO.eventSearchList(map);
		request.setAttribute("list", list);

		EventVO vo=EventDAO.eventSearchPrice(request.getParameter("key"));
		if(vo!=null){
			request.setAttribute("maxprice", vo.getMaxprice());
			request.setAttribute("minprice", vo.getMinprice());
		}else{
			request.setAttribute("maxprice", 0);
			request.setAttribute("minprice", 0);
		}

		request.setAttribute("wide", "y");
		request.setAttribute("is", "y"); //infinite scroll true
		request.setAttribute("main_jsp", "../event/event_list.jsp");
		request.setAttribute("title", "검색결과");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_list_data.do")
	public void event_list_data(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");

        BufferedReader reader= null;
		StringBuilder sb=new StringBuilder();
		JSONParser jsonparse=new JSONParser();
		JSONObject json;

        try {
            reader = request.getReader();
			String line;
			while((line=reader.readLine())!=null) {
				sb.append(line);
			}

			json=(JSONObject)jsonparse.parse(sb.toString());

        } catch (IOException | ParseException e) {
            throw new RuntimeException(e);
        }

		String key=json.get("key").toString();
		String page=json.get("curpage").toString();
		//검색어, 페이지 추출

		//검색결과 구하기
		EventVO cvo=EventDAO.eventSearchPrice(key);

		HashMap map = new HashMap();
		int curpage=Integer.parseInt(page);
		map.put("key", key);
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);

		List<EventVO> list= EventDAO.eventSearchList(map);
		JSONArray arr=new JSONArray();
		int i=0;
		for(EventVO vo:list){
			JSONObject obj=new JSONObject();
			obj.put("title", vo.getCvo().getTitle());
			obj.put("addr1", vo.getCvo().getAddr1());
			obj.put("addr2", vo.getCvo().getAddr2());
			obj.put("dbend", vo.getDbend());
			obj.put("dbcate", vo.getDbcate());
			obj.put("first_image", vo.getCvo().getFirst_image());
			obj.put("price", vo.getPrice());
			if(i==0){
				obj.put("curpage", curpage);
				if(cvo!=null){
					obj.put("count", cvo.getCount());
				}else{
					obj.put("count", 0);
				}
				if(10*curpage>Integer.parseInt(cvo.getCount())){
					obj.put("listend", true);
				}
			}
			arr.add(obj);
			i++;
		}

		PrintWriter out;
		try {
			out = response.getWriter();
			out.write(arr.toJSONString());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
}
