package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.EventDAO;
import com.sist.vo.EventVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

@Controller
public class EventModel {
	@RequestMapping("event/main.do")
	public String event_main(HttpServletRequest request, HttpServletResponse response) {
		HashMap map = new HashMap();
		String[] code={"1"};
		map.put("areacode", code);
		map.put("start", "1");
		map.put("end", "8");
		List<EventVO> arealist1= EventDAO.eventSearchList(map);
		request.setAttribute("arealist1", arealist1);

		code[0]="6";
		map.put("areacode", code);
		List<EventVO> arealist2= EventDAO.eventSearchList(map);
		request.setAttribute("arealist2", arealist2);

		code[0]="39";
		map.put("areacode", code);
		List<EventVO> arealist3= EventDAO.eventSearchList(map);
		request.setAttribute("arealist3", arealist3);

		List<EventVO> list3= EventDAO.mainEventList();
		request.setAttribute("musicalList", list3);

		List<EventVO> list2= EventDAO.mainFesList();
		request.setAttribute("fesList", list2);

		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../event/event_home.jsp");
		request.setAttribute("event", "y"); //event page
		request.setAttribute("title", "메인");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_list.do")
	public String event_list(HttpServletRequest request, HttpServletResponse response) {
		//필터 카테고리 목록
		request.setAttribute("catemap",EventDAO.catemap);

		//parameter 매핑
		HashMap map = new HashMap();
		map.put("key", request.getParameter("key"));
		//최대값,최소값,결과개수
		EventVO vo=EventDAO.eventSearchDefault(map);
		if(vo.getMaxprice()!=null){
			request.setAttribute("maxprice", vo.getMaxprice());
			request.setAttribute("minprice", vo.getMinprice());
		}else{ //row 없으면
			request.setAttribute("maxprice", 0);
			request.setAttribute("minprice", 0);
		}

		request.setAttribute("wide", "y");//wide screen true
		request.setAttribute("is", "y"); //infinite scroll true
		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/event_list.jsp");
		request.setAttribute("title", "검색결과");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_list_data.do")
	public void event_list_data(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
        JSONObject json=EventDAO.jsonParse(request,response);
		String key=json.get("key").toString();
		String page=json.get("curpage").toString();
		String filter=json.get("filter").toString(); //filter true/false

		//기본 parameter 매핑
		HashMap map = new HashMap();
		int curpage=Integer.parseInt(page);
		map.put("key", key);
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);

		//filter parameter 추출/매핑
		String[] catelist=new String[0];
		if(json.get("filtermin")!=null){ //가격 필터 적용했을 때만 매핑
			map.put("filtermin", json.get("filtermin").toString());
			map.put("filtermax", json.get("filtermax").toString());
			System.out.println("filtermin:"+json.get("filtermin").toString());
			System.out.println("filtermax:"+json.get("filtermax").toString());
		}
		if(json.get("cate")!=null){ //카테고리 필터 적용했을 때만 매핑
			catelist=json.get("cate").toString().split(",");
			map.put("cate", catelist);
		}
		if(json.get("enddate")!=null){ //기간 필터 적용했을 때만 매핑
			map.put("enddate", json.get("enddate").toString());
		}

		System.out.println("filter:"+filter);
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
				if(10*curpage>=Integer.parseInt(cvo.getCount())){ //페이지 끝이면
					obj.put("listend", true);
				}
			}
			arr.add(obj);
			i++;
		}
		if(list==null||list.size()==0){ //row 없으면
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

	@RequestMapping("event/event_area.do")
	public String event_arealist(HttpServletRequest request, HttpServletResponse response) {
		//필터 카테고리 목록
		request.setAttribute("catemap",EventDAO.catemap);

		//parameter 매핑
		HashMap map = new HashMap();
		String[] catelist=request.getParameterValues("type");
		map.put("areacode", catelist);
		//최대값,최소값,결과개수
		EventVO vo=EventDAO.eventSearchDefault(map);
		if(vo!=null){
			request.setAttribute("maxprice", vo.getMaxprice());
			request.setAttribute("minprice", vo.getMinprice());
		}else{ //row 없으면
			request.setAttribute("maxprice", 0);
			request.setAttribute("minprice", 0);
		}
		request.setAttribute("areaStr",request.getParameter("areastr"));

		request.setAttribute("wide", "y");//wide screen true
		request.setAttribute("is", "y"); //infinite scroll true
		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/event_area.jsp");
		request.setAttribute("title", "검색결과");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_area_data.do")
	public void event_arealist_data(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
		JSONObject json=EventDAO.jsonParse(request, response);
		String codestr=json.get("areacode").toString();
		int[] codeArr2 = new int[0];
		if(codestr.contains("[")){
			codestr=codestr.substring(1,codestr.length()-1);
			String[] codeArr=codestr.split(",");
			codeArr2=new int[codeArr.length];
			for(int i=0;i<codeArr.length;i++){
				System.out.println(codeArr[i]);
				if(!codeArr[i].equals("")) {
					codeArr2[i]=Integer.parseInt(codeArr[i]);
				}
			}
		}

		String page=json.get("curpage").toString();
		String filter=json.get("filter").toString(); //filter true/false

		//기본 parameter 매핑
		HashMap map = new HashMap();
		int curpage=Integer.parseInt(page);
		map.put("areacode", codeArr2);
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);

		//filter parameter 추출/매핑
		String[] catelist=new String[0];
		if(json.get("filtermin")!=null){ //가격 필터 적용했을 때만 매핑
			map.put("filtermin", json.get("filtermin").toString());
			map.put("filtermax", json.get("filtermax").toString());
			System.out.println("filtermin:"+json.get("filtermin").toString());
			System.out.println("filtermax:"+json.get("filtermax").toString());
		}
		if(json.get("cate")!=null){ //카테고리 필터 적용했을 때만 매핑
			System.out.println("cate:"+json.get("cate").toString());
			catelist=json.get("cate").toString().split(",");
			map.put("cate", catelist);
		}
		if(json.get("enddate")!=null){ //기간 필터 적용했을 때만 매핑
			map.put("enddate", json.get("enddate").toString());
		}

		System.out.println("filter:"+filter);

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
				if(10*curpage>=Integer.parseInt(cvo.getCount())){ //페이지 끝이면
					obj.put("listend", true);
				}
			}
			arr.add(obj);
			i++;
		}
		if(list==null||list.size()==0){ //row 없으면
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
