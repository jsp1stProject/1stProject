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
	/*
	@RequestMapping("fes/fes_list.do")
	public String fes_list(HttpServletRequest request, HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../fes/fes_list.jsp");
		return "../main/main.jsp";
	}
		
		
	@RequestMapping("fes/fes_list.do")
	public String fes_list(HttpServletRequest request, HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
		  page="1";
		int curpage=Integer.parseInt(page);
		Map map=new HashMap();
		map.put("start", (curpage*12)-11);
		map.put("end",curpage*12);  
		List<FesVO> list = FesDAO.fesListData(map);
		int totalpage=FesDAO.fesTotalPage();
		
		final int BLOCK=10;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endPage>totalpage)
			  endPage=totalpage;
		
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		request.setAttribute("main_jsp", "../fes/fes_list.jsp");
		return "../main/main.jsp";
	}
	
	*/
	
	@RequestMapping("fes/fes_detail_before.do")
	public String fes_detail_before(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("fes_detail_before");
		String content_id=request.getParameter("content_id");
		Cookie cookie=new Cookie("fes_"+content_id,content_id);
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24);
		response.addCookie(cookie);
		
		return "redirect:fes_detail.do?content_id="+content_id;
			
	}
	
	@RequestMapping("fes/fes_detail.do")
	public String fes_detail(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("fes_detail.do");
		String content_id=request.getParameter("content_id");
		FesVO vo = FesDAO.fesDetailData(Integer.parseInt(content_id));
		
		List<FesVO> ilist= FesDAO.fesInfoData(Integer.parseInt(content_id));
		
		for(FesVO ivo : ilist)
		{
			if(ivo.getInfoname().equals("행사소개"))
				vo.setInfotext1(ivo.getInfotext());
			if(ivo.getInfoname().equals("행사내용"))
				vo.setInfotext2(ivo.getInfotext());
		}
		List<FesVO> plist= FesDAO.fesPosterData(Integer.parseInt(content_id));
		
		//System.out.println(vo.getTitle());
		String addr1="주소값 널값오류";
		
		String addr=vo.getAddr1();
		addr=addr.substring(addr.trim().indexOf(" "));
		  //전주시 완산구 중앙동3가 80
		String addr_1=addr.trim();
		addr_1=addr_1.substring(addr1.trim().indexOf(" "));
		  //완산구 중앙동3가 80
		String addr_map=addr_1.trim();
		addr_map=addr_map.substring(0,addr_map.indexOf(" "));
		request.setAttribute("addr", addr_map);
		
		//request.setAttribute("addr", addr1);
		request.setAttribute("vo", vo);
		//request.setAttribute("ilist", ilist);
		request.setAttribute("pList", plist);
		request.setAttribute("main_jsp", "../fes/fes_detail.jsp");
		
		return "../main/main.jsp";
	}
	
	@RequestMapping("fes/fes_list.do")
	public String recipe_find(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("fes_list진입");
		String[] typeList = request.getParameterValues("type"); /* 하나가 들어올 지 여러개가 들어올 지 모르기 때문에 배열로 */
		if(typeList==null)
		{
			typeList=new String[] {"cat3"};
		}
		String[] ssList = request.getParameterValues("ss"); /* 검색어 */
		String[] acList = request.getParameterValues("ac");
		if(ssList==null)
		{
			ssList= new String[] {"A02070100"};
		}
		System.out.println("값 받아오기");
		System.out.println("frr값은 : "+Arrays.toString(typeList));
		System.out.println("coldata값은 : "+Arrays.toString(ssList));
		
		Map map=new HashMap();
		map.put("typeList", typeList);
		map.put("ssList", ssList);
		List<FesVO> list = FesDAO.fesFindData(map);
		System.out.println("데이터 검색 수는 "+list.size());
		request.setAttribute("list", list);		
		//메인으로 넘어갈 때 헤더 풋터만 채워져있고 홈은 비워져있으니까 그 부분을 채워주야해
		request.setAttribute("main_jsp",
				"../fes/fes_list.jsp"); /* 인크루드되면 데이터가 공유되기 때문에 list를 메인,헤더,풋터,파인드 다 사용가능 */
		return "../main/main.jsp";
	}
	
	
}
