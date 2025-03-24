package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.vo.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;

@Controller
public class FesModel {
	
	@RequestMapping("fes/fes_home.do")
	public String fes_home(HttpServletRequest request, HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../fes/fes_home.jsp");
		return "../main/main.jsp";
		
	}
	@RequestMapping("fes/fes_list.do") //if문이 포함! -> if문 대신에 사용한다
	  public String fes_list(HttpServletRequest request, HttpServletResponse response)
	  {
		  String search = request.getParameter("search");
		  String page=request.getParameter("page");
		  if(page==null)
			  page="1";
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  map.put("search", search);
		  map.put("start", (curpage*12)-11);
		  map.put("end",curpage*12);
		  List<FesVO> list=FesDAO.fesHomeFindData(map);
		  int totalcount=FesDAO.fesHomeTotalCount(search);

		  int totalpage=(totalcount/12+1);
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  
		  if(endPage>totalpage)
			  endPage=totalpage;
		  request.setAttribute("search", search);
		  request.setAttribute("totalcount", totalcount);
		  request.setAttribute("list", list);
		  request.setAttribute("curpage", curpage);
		  request.setAttribute("totalpage", totalpage);
		  request.setAttribute("startPage", startPage);
		  request.setAttribute("endPage", endPage);
		  request.setAttribute("main_jsp", "../fes/fes_list.jsp");
		  return "../main/main.jsp";
	   }
	
	@RequestMapping("fes/fes_list_ajax.do")
	public void fes_list_ajax(HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("fes_list_ajax진입");
		/*
		 * String[] typeList = request.getParameterValues("type"); 하나가 들어올 지 여러개가 들어올 지
		 * 모르기 때문에 배열로 if(typeList==null) { typeList=new String[] {"cat3"}; }
		 */
		String[] cat3List = request.getParameterValues("cat3"); /* 검색어 */
		String[] acList = request.getParameterValues("ac");
		String search=request.getParameter("search");
		System.out.println("값 받아오기");
		System.out.println("cat3List값은 : " + Arrays.toString(cat3List));
		System.out.println("search값은 : "+search);
		Map map = new HashMap();
		map.put("cat3List", cat3List);
		map.put("acList", acList);
		List<FesVO> list = FesDAO.fesFindData(map);
		System.out.println("cat3List값은 : " + Arrays.toString(cat3List));
		System.out.println("acList값은 : " + Arrays.toString(acList));
		System.out.println("데이터 검색 수는 " + list.size());
		
		JSONArray arr= new JSONArray();
		for(FesVO vo : list)
		{
			JSONObject obj=new JSONObject();
			/*
			 content_id, title, addr1, addr2, zipcode, sigungucode, areacode, 
			 first_image, review_count, event_startdate, event_enddate, 
			 charge, agelimit, price, price_info, num
			 
			 */
			obj.put("content_id", vo.getContent_id());
			obj.put("title", vo.getTitle());
			obj.put("addr1", vo.getAddr1());
			obj.put("addr2", vo.getAddr2());
			obj.put("zipcode", vo.getZipcode());
			obj.put("sigungucode", vo.getSigungucode());
			obj.put("areacode", vo.getAreacode());
			obj.put("first_image", vo.getFirst_image());
			obj.put("review_count", vo.getReview_count());
			obj.put("event_startdate", vo.getEvent_startdate());
			obj.put("event_enddate", vo.getEvent_enddate());
			obj.put("charge", vo.getCharge());
			obj.put("agelimit", vo.getAgelimit());
			obj.put("price", vo.getPrice());
			arr.add(obj);
			
			try {
				response.setContentType("text/plain;charset:UTF-8");
				PrintWriter out = response.getWriter();
				out.write(arr.toJSONString());//데이터보내기
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}
		
		request.setAttribute("list", list);
		// 메인으로 넘어갈 때 헤더 풋터만 채워져있고 홈은 비워져있으니까 그 부분을 채워주야해
		
	}
	
	
	@RequestMapping("fes/fes_detail_before.do")
	public String fes_detail_before(HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("fes_detail_before");
		String content_id = request.getParameter("content_id");
		Cookie cookie = new Cookie("fes_" + content_id, content_id);
		cookie.setPath("/");
		cookie.setMaxAge(60 * 60 * 24);
		response.addCookie(cookie);

		return "redirect:fes_detail.do?content_id=" + content_id;

	}

	@RequestMapping("fes/fes_detail.do")
	public String fes_detail(HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("fes_detail.do");
		String content_id = request.getParameter("content_id");
		FesVO vo = FesDAO.fesDetailData(Integer.parseInt(content_id));

		List<FesVO> ilist = FesDAO.fesInfoData(Integer.parseInt(content_id));

		for (FesVO ivo : ilist) {
			if (ivo.getInfoname().equals("행사소개"))
				vo.setInfotext1(ivo.getInfotext());
			if (ivo.getInfoname().equals("행사내용"))
				vo.setInfotext2(ivo.getInfotext());
		}
		List<FesVO> plist = FesDAO.fesPosterData(Integer.parseInt(content_id));

		// System.out.println(vo.getTitle());
		String addr1 = "주소값 널값오류";

		String addr = vo.getAddr1();
		addr = addr.substring(addr.trim().indexOf(" "));
		// 전주시 완산구 중앙동3가 80
		String addr_1 = addr.trim();
		addr_1 = addr_1.substring(addr1.trim().indexOf(" "));
		// 완산구 중앙동3가 80
		String addr_map = addr_1.trim();
		addr_map = addr_map.substring(0, addr_map.indexOf(" "));
		request.setAttribute("addr", addr_map);

		// request.setAttribute("addr", addr1);
		request.setAttribute("vo", vo);
		// request.setAttribute("ilist", ilist);
		request.setAttribute("pList", plist);
		request.setAttribute("main_jsp", "../fes/fes_detail.jsp");

		return "../main/main.jsp";
	}

	

}
