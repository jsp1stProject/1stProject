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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EventModel {
	@RequestMapping("event/main.do")
	public String event_main(HttpServletRequest request, HttpServletResponse response) {
		HashMap map = new HashMap();
		map.put("areacode", "1");
		map.put("start", "1");
		map.put("end", "8");
		List<EventVO> arealist1= EventDAO.eventAreaList(map);
		request.setAttribute("arealist1", arealist1);

		map.put("areacode", "6");
		List<EventVO> arealist2= EventDAO.eventAreaList(map);
		request.setAttribute("arealist2", arealist2);

		map.put("areacode", "39");
		List<EventVO> arealist3= EventDAO.eventAreaList(map);
		request.setAttribute("arealist3", arealist3);

		List<EventVO> list3= EventDAO.mainEventList();
		request.setAttribute("musicalList", list3);

		List<EventVO> list2= EventDAO.mainFesList();
		request.setAttribute("fesList", list2);


		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../event/event_home.jsp");
		request.setAttribute("title", "메인");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_list.do")
	public String event_list(HttpServletRequest request, HttpServletResponse response) {
		String[] catelist={"전통공연","연극","뮤지컬","오페라","전시회","박람회","무용","클래식","콘서트","영화","스포츠","기타행사"};
		LinkedHashMap catemap = new LinkedHashMap();
		catemap.put("A02080100", "전통공연");
		catemap.put("A02080200", "연극");
		catemap.put("A02080300", "뮤지컬");
		catemap.put("A02080400", "오페라");
		catemap.put("A02080500", "전시회");
		catemap.put("A02080600", "박람회");
		catemap.put("A02080800", "무용");
		catemap.put("A02080900", "클래식");
		catemap.put("A02081000", "콘서트");
		catemap.put("A02081100", "영화");
		catemap.put("A02081200", "스포츠");
		catemap.put("A02081300", "기타행사");
		request.setAttribute("catelist",catelist);
		request.setAttribute("catemap",catemap);

		HashMap map = new HashMap();
		map.put("key", request.getParameter("key"));

		EventVO vo=EventDAO.eventSearchDefault(map);
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
		System.out.println(json.toJSONString());
		String key=json.get("key").toString();
		String page=json.get("curpage").toString();
		String filter=json.get("filter").toString(); //filter true/false

		//parameter 매핑
		HashMap map = new HashMap();
		int curpage=Integer.parseInt(page);
		map.put("key", key);
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);

		//filter parameter 추출/매핑
		String filtermin = "";
		String filtermax = "";
		String cate = "";
		String[] catelist=new String[0];
		if(json.get("filtermin")!=null){ //가격 필터 적용했을 때만 매핑
			filtermin = json.get("filtermin").toString();
			filtermax = json.get("filtermax").toString();
			map.put("filtermin", filtermin);
			map.put("filtermax", filtermax);
		}
		if(json.get("cate")!=null){ //카테고리 필터 적용했을 때만 매핑
			cate = json.get("cate").toString();
			catelist=cate.split(",");
			map.put("cate", catelist);

		}
		if(json.get("enddate")!=null){
			map.put("enddate", json.get("enddate").toString());
		}
		//검색어, 페이지 추출

		System.out.println("filter:"+filter);
		System.out.println("filtermin:"+filtermin);
		System.out.println("filtermax:"+filtermax);
		System.out.println("cate:"+catelist.toString());

		//검색결과 총개수
		EventVO cvo=EventDAO.eventSearchDefault(map);
		//검색결과 목록
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
				obj.put("count", cvo.getCount());
				if(10*curpage>=Integer.parseInt(cvo.getCount())){
					System.out.println("10 * curpage:"+10*curpage);
					System.out.println("총페이지:"+cvo.getCount());
					System.out.println("listend:"+(10*curpage>=Integer.parseInt(cvo.getCount())));

					obj.put("listend", true);
				}
			}
			arr.add(obj);
			i++;
		}
		if(list==null||list.size()==0){
			JSONObject obj=new JSONObject();
			obj.put("count", 0);
			arr.add(obj);
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
