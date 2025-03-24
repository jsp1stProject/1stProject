package com.sist.model;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Controller
public class FoodModel {
	@RequestMapping("food/food_detail.do")
	public String food_detail(HttpServletRequest request,HttpServletResponse response)
	{
		  String fno=request.getParameter("fno");
		  FoodVO vo=FoodDAO.foodDetailData(Integer.parseInt(fno));
		  String addr=vo.getAddress();
		  addr=addr.substring(addr.trim().indexOf(" "));
		  String addr1=addr.trim();
		  addr1=addr1.substring(addr1.trim().indexOf(" "));
		  String addr2=addr1.trim();
		  addr2=addr1.substring(0,addr2.indexOf(" ")+1);
		  request.setAttribute("addr", addr2);
		  request.setAttribute("vo", vo);
		  
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../food/food_detail.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("food/food_find.do")
	public String food_find(HttpServletRequest request,HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../food/food_find.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("food/food_find_ajax.do")
	  public void food_find_ajax(HttpServletRequest request,
	  		HttpServletResponse response)
	  {
		
		  // data:{"fd":fd,"ss":ss,"page":1}
		  String page=request.getParameter("page");
		  System.out.println("page:"+page);
		  String fd=request.getParameter("fd");
		  System.out.println("fd:"+fd);
		  List<String> fdList = Arrays.asList(fd.split(","));
		  String ss=request.getParameter("ss");
		  System.out.println("ss:"+ss);
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  map.put("start", (12*curpage)-11);
		  map.put("end", 12*curpage);
		  map.put("ss", ss);
		  map.put("fdList",fdList);
		  System.out.println("map후");
		  List<FoodVO> list=FoodDAO.foodFindData(map);
		  System.out.println("list후");
		  //페이지
		  int totalpage=FoodDAO.foodFindTotalPage(map);
		  System.out.println(totalpage);
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  System.out.println(startPage);
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  System.out.println(endPage);
		  if(endPage>totalpage)
			 endPage=totalpage;
		  // 검색 개수
		  int totalCount=FoodDAO.foodFindTotalCount(map);
		  //JSON 변환
		  JSONArray arr=new JSONArray();
		  int i=0;
		  // fno,name,poster,score,type,content,theme,phone,address
		  for(FoodVO vo:list)
		  {
			  JSONObject obj=new JSONObject();
			  obj.put("fno", vo.getFno());
			  obj.put("name", vo.getName());
			  obj.put("poster", vo.getPoster());
			  obj.put("score", vo.getScore());
			  obj.put("type", vo.getType());
			  obj.put("content", vo.getContent());
			  obj.put("theme", vo.getTheme());
			  obj.put("phone", vo.getPhone());
			  obj.put("price",vo.getPrice());
			  obj.put("address", vo.getAddress());
			  obj.put("likecount", vo.getLikecount());
			  obj.put("replycount", vo.getReplycount());
			  obj.put("ss", ss);
			  obj.put("totalCount", totalCount);
			  if(i==0)
			  {
				  
				  obj.put("curpage", curpage);
				  obj.put("totalpage", totalpage);
				  obj.put("startPage", startPage);
				  obj.put("endPage",endPage);
				  obj.put("totalCount", totalCount);
			  }
			  
			  arr.add(obj);
			  i++;
		  }
		  //JSON으로 전송
		  try {
			  response.setContentType("text/plain;charset=UTF-8");
			  PrintWriter out=response.getWriter();
			  out.write(arr.toJSONString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		  
	  }
	

}
