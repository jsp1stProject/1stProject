package com.sist.model;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.PrintWriter;
// JSP (디자인) => Model => DAO => Model => JSP
//             | Conroller         |Controller
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.vo.*;
import com.sist.dao.*;
@Controller
public class SightsModel {
	@RequestMapping("sights/sights_list.do")
	  public String sights_list(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  String page=request.getParameter("page");
		  if(page==null)
			  page="1";
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  map.put("start", (curpage*12)-11);
		  map.put("end",curpage*12);
		  List<SightsVO> list=SightsDAO.sightsListData(map);
		  int totalpage=SightsDAO.sightsTotalPage();
		  
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
		  
		  request.setAttribute("main_jsp", "../sights/sights_list.jsp");
		  return "../main/main.jsp";
	  }
	
	@RequestMapping("sights/sights_detail.do")
	public String sights_detail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("sights_detail.do 값");
		int content_id=Integer.parseInt(request.getParameter("content_id"));
		System.out.println("content_id 값: " + content_id);
	    //String content_id = request.getParameter("content_id");
	    SightsVO vo = SightsDAO.sightsDetailData(content_id);
	    List<ReviewVO> rList = SightsDAO.sightsReviewList(content_id);

	    request.setAttribute("rList", rList);
	    request.setAttribute("vo", vo);
	    request.setAttribute("main_jsp", "../sights/sights_detail.jsp");

	    return "../main/main.jsp";
	}
	
	@RequestMapping("sights/sights_review_insert.do")
	public String sights_review_insert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("sightsReview:");
		String type = request.getParameter("type");
		String message = request.getParameter("msg");
		String content_id = request.getParameter("content_id");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("user_id");
		ReviewVO vo = new ReviewVO();
		vo.setContent_id(Integer.parseInt(content_id));
		System.out.println("contentID:"+content_id);
		vo.setType(Integer.parseInt(type));
		System.out.println("type:"+type);
		vo.setUser_id(id);
		vo.setMessage(message); 
		SightsDAO.sightsReviewInsert(vo);
		
		return "redirect:../sights/sights_detail.do?content_id=" +content_id;
	}

}
