package com.sist.model;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javax.swing.plaf.InternalFrameUI;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;
import java.sql.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
public class FoodModel {
	@RequestMapping("food/food_detail_before.do")
	  public String food_detail_before(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		
		  String fno=request.getParameter("fno");
		  Cookie cookie=new Cookie("food_"+fno, fno);
		  cookie.setPath("/");
		  cookie.setMaxAge(60*60*24);
		  // 전송 
		  response.addCookie(cookie);
		  
		  
		  // 화면 이동 
		  return "redirect:../food/food_detail.do?fno="+fno;
	  }
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
		  
		  Cookie[] cookies = request.getCookies();
		    List<FoodVO> foodHistory = new ArrayList<>();

		    if (cookies != null) {
		        for (Cookie c : cookies) {
		            if (c.getName().startsWith("food_")) {
		                int cookieFno = Integer.parseInt(c.getValue());
		                FoodVO food = FoodDAO.foodCookieData(cookieFno);
		                foodHistory.add(food);
		            }
		        }
		    }
		    
		      ReviewVO rvo=new ReviewVO();
			  rvo.setNo(Integer.parseInt(fno));
			  rvo.setType(4);
			  System.out.println("진입");
			  List<ReviewVO> list=FoodDAO.foodReviewListData(Integer.parseInt(fno));
			  System.out.println("list:"+list);
			  
			  int count=FoodDAO.foodReviewCount(Integer.parseInt(fno));
			  System.out.println("count"+count);
			  request.setAttribute("count", count);
			  request.setAttribute("rList", list);

		    request.setAttribute("foodHistory", foodHistory);
		request.setAttribute("main_jsp", "../food/food_detail_2.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("food/food_find.do")
	public String food_find(HttpServletRequest request,HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../food/food_find.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("food/food_find_ajax.do")
	  public void food_find_ajax(HttpServletRequest request,HttpServletResponse response)
	  {
		
		  // data:{"fd":fd,"ss":ss,"page":1,"totalCount":totalCount}
		  String page=request.getParameter("page");
		  String fd=request.getParameter("fd");
		  List<String> fdList = Arrays.asList(fd.split(","));
		  String ss=request.getParameter("ss");
		  
		  int curpage=Integer.parseInt(page);
		  Map map=new HashMap();
		  map.put("start", (12*curpage)-11);
		  map.put("end", 12*curpage);
		  map.put("ss", ss);
		  map.put("fdList",fdList);
		  System.out.println("fdList"+fdList);
		  // 검색 개수
		  int totalCount=FoodDAO.foodFindTotalCount(map);
		  map.put("totalCount", totalCount);
		  System.out.println("totalCount:"+totalCount);
		  
		  List<FoodVO> list=FoodDAO.foodFindData(map);
		  //페이지
		  int totalpage=FoodDAO.foodFindTotalPage(map);
		  final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  if(endPage>totalpage)
			 endPage=totalpage;
		  // 검색 개수
		  
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
	//리뷰
	private String[] urls={"","",
			  "","","food/food_detail.do?fno=",""};
	
	  @RequestMapping("food/food_review_insert.do")
	  public String food_review_insert(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  
		  String fno=request.getParameter("fno");
		  String message=request.getParameter("message");
		  
		  
		  HttpSession session=request.getSession();
		  String user_id=(String)session.getAttribute("user_id");
		  System.out.println("user_id"+user_id);
		  ReviewVO vo=new ReviewVO();
		  
		  vo.setUser_id(user_id);
		  vo.setMessage(message);
		  vo.setFno(Integer.parseInt(fno));
	
		 
		  FoodDAO.foodReviewInsert(vo);
		  System.out.println("vo"+vo);
		  return "redirect:../"+urls[4]+fno;
	  }
	  
	  @RequestMapping("food/food_review_delete.do")
	  public String food_review_delete(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  String fno=request.getParameter("fno");
		  System.out.println("delete fno:"+fno);
		  String no=request.getParameter("no");
		  
		  System.out.println("no:"+no);
		
		  
		  
		  FoodDAO.foodReviewDelete(Integer.parseInt(no));
		  return "redirect:../"+urls[4]+fno;
	  }
	  
	  @RequestMapping("food/food_review_update.do")
	  public String food_review_update(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  String fno = request.getParameter("fno");
		    String no = request.getParameter("no");
		    
		    // 댓글 데이터 가져오기
		    ReviewVO vo = FoodDAO.foodReviewData(Integer.parseInt(no));
		    request.setAttribute("vo", vo);  // 댓글 정보 넘겨주기
		    request.setAttribute("fno", fno);
		    
		    
		    return "../food/food_detail.jsp";
	  }
	  @RequestMapping("food/food_review_update_process.do")
	  public void food_review_update_process(HttpServletRequest request,
	          HttpServletResponse response) {
	      String no = request.getParameter("no");
	      String message = request.getParameter("message");

	      // 리뷰 데이터 수정
	      ReviewVO rvo = new ReviewVO();
	      rvo.setNo(Integer.parseInt(no));
	      rvo.setMessage(message);

	      // 리뷰 업데이트
	      FoodDAO.foodReviewUpdate(rvo);

	      // 응답 결과 전달 (성공시 아무 내용도 없이 응답)
	      try {
			response.getWriter().write("success");
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			ex.printStackTrace();
		}
	  }
	
	// 맛집 홈
	@RequestMapping("food/food_home.do")
	  public String main_main(HttpServletRequest request,HttpServletResponse response)
	  {
		  List<FoodVO> fList=FoodDAO.foodMainHouseData5();
		  // chefList => recipeList => newsList => cookieList
		  request.setAttribute("fList", fList);
		  
		  // JSP로 값을 전송 
		  request.setAttribute("main_jsp", "../food/food_home.jsp");
		  // 화면 변경
		  request.setAttribute("title", "메인");
		  return "../main/main.jsp";
	  }
	
	// 예약하기
	@RequestMapping("food/food_reserve.do")
	   public String food_reserve(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		String fno = request.getParameter("fno");
		String name=request.getParameter("name");
		 FoodVO fvo = FoodDAO.foodReserveId(Integer.parseInt(fno));
		 request.setAttribute("fvo", fvo);
		    
			 if (name == null || name.isEmpty()) 
			        System.out.println("name 값이 없음");
		request.setAttribute("main_jsp", "../food/food_reserve.jsp");
		return "../main/main.jsp";
	   }
	@RequestMapping("food/food_reserve_ok.do")
	public String food_reserve_ok(HttpServletRequest request,
			   HttpServletResponse response) {
	        
	        String res_date = request.getParameter("res_date");
	       String res_time=request.getParameter("res_time");
	        String people = request.getParameter("people");
	        HttpSession session=request.getSession();
			String user_id=(String)session.getAttribute("user_id");
			String fno = request.getParameter("fno");
			String name=request.getParameter("name");
	        
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Date parsedDate = null;
			try {
				parsedDate = sdf.parse(res_date);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			 // 맛집 번호 가져오기
			
			
			
		    System.out.println(" name: " + name);
		    FoodVO fvo = FoodDAO.foodReserveId(Integer.parseInt(fno)); // DAO에서 맛집 정보 가져오
		    request.setAttribute("fvo", fvo);
			System.out.println("fno:"+fno);
	        FoodReserveVO vo = new FoodReserveVO();
	        vo.setFvo(fvo);
	        vo.setRes_date(parsedDate);
	        System.out.println("여기");
	        vo.setRes_time(res_time);
	        vo.setPeople(Integer.parseInt(people));
	        
	        System.out.println("vo"+vo);
	        // DAO를 통해 예약 저장
	        FoodDAO.foodReserve(vo);
	        System.out.println("vo:"+vo);

			   return "redirect:../food/food_find.do"; // JSON 반환
	    }
	   



	
	// 관리자 페이지
	@RequestMapping("food/admin_food_list.do")
	public String admin_food_list(HttpServletRequest request,HttpServletResponse response)
	{
		String fd = request.getParameter("fd");
        String ss = request.getParameter("ss");
        String page = request.getParameter("page");

        if (page == null) page = "1";
        if (fd == null || fd.trim().isEmpty()) fd = "address";  // 기본값 설정
        if (ss == null || ss.trim().isEmpty()) ss = "마포";  // 기본 검색어 설정

        int curpage = Integer.parseInt(page);

        Map map = new HashMap();
        map.put("start", (curpage * 12) - 11);
        map.put("end", curpage * 12);
        map.put("fd", fd);
        map.put("ss", ss);
        
        
        List<FoodVO> foodList = FoodDAO.adminFoodListData(map);
        int totalpage = FoodDAO.adminFoodTotalPage(map);
        
        final int BLOCK=10;
		  int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		  int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		  if(endPage>totalpage)
			 endPage=totalpage;
		  
	
		  request.setAttribute("startPage", startPage);
		  request.setAttribute("endPage",endPage);
        request.setAttribute("aList", foodList);
        request.setAttribute("curpage", curpage);
        request.setAttribute("totalpage", totalpage);
	    request.setAttribute("wide", "y");
	    request.setAttribute("admin_jsp", "../food/admin_food_list.jsp");
		   return "../adminpage/admin_main.jsp";
	}
	
	@RequestMapping("food/food_insert.do")
	   public String food_insert(HttpServletRequest request,
			   HttpServletResponse response)
	   {
	   
		request.setAttribute("wide", "y");   
		request.setAttribute("admin_jsp", "../food/admin_food_insert.jsp");
		 return "../adminpage/admin_main.jsp";
	   }
	   @RequestMapping("food/food_insert_ok.do")
	   public String food_insert_ok(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   //fno=#{fno},name=#{name},poster=#{poster},type=#{type},content=#{content},theme=#{theme},phone=#{phone},address=#{address}
		   String name=request.getParameter("name");
		   String poster=request.getParameter("poster");
		   String type=request.getParameter("type");
		   String theme=request.getParameter("theme");
		   String phone=request.getParameter("phone");
		   String address=request.getParameter("address");
		   String content=request.getParameter("content");
		   String time=request.getParameter("time");
		   String price=request.getParameter("price");
		   System.out.println("스트링 값 들어와");
		   FoodVO vo=new FoodVO();
		   vo.setName(name);
		   vo.setPoster(poster);
		   vo.setType(type);
		   vo.setTheme(theme);
		   vo.setPhone(phone);
		   vo.setAddress(address);
		   vo.setContent(content);
		   vo.setTime(time);
		   vo.setPrice(price);
		   System.out.println(name);
		   System.out.println("vo에 값 넣고");
		 
		   FoodDAO.adminFoodInsert(vo);
		   
		   request.setAttribute("main_jsp", "../adminpage/admin_main.jsp");
		   return "redirect:../food/admin_food_list.do";
	   }
	@RequestMapping("food/admin_update.do")
	public String admin_update(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   String fno=request.getParameter("fno");
		   FoodVO vo=FoodDAO.adminFoodUpdateData(Integer.parseInt(fno));
		   request.setAttribute("vo", vo);
		   
		   
		   request.setAttribute("admin_jsp", "../food/admin_food_update.jsp");
		   return "../adminpage/admin_main.jsp";
	   }
	 @RequestMapping("food/admin_update_ok.do")
	   public String admin_update_ok(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   // invoke(obj,request,response)
		   String fno=request.getParameter("fno");
		   String name=request.getParameter("name");
		   String type=request.getParameter("type");
		   String content=request.getParameter("content");
		   String poster=request.getParameter("poster");
		   String theme=request.getParameter("theme");
		   String phone=request.getParameter("phone");
		   String address=request.getParameter("address");
		  
		   FoodVO vo=new FoodVO();
		   vo.setName(name);
		   vo.setFno(Integer.parseInt(fno));
		   vo.setType(type);
		   vo.setContent(content);
		   vo.setPoster(poster);
		   vo.setTheme(theme);
		   vo.setPhone(phone);
		   vo.setAddress(address);

		   request.setAttribute("vo", vo);
		   FoodDAO.adminFoodUpdate(vo);
		   request.setAttribute("fno", fno);
		   return "redirect:../food/admin_food_list.do";
	   }
	
	@RequestMapping("food/admin_delete.do")
	   public void admin_delete(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   String fno=request.getParameter("fno");
		   PrintWriter out=null;
		   try
		   {
			   
			   response.setContentType("text/html;charset=UTF-8");
			   out=response.getWriter();
			   
			   FoodDAO.adminFoodDelete(Integer.parseInt(fno));
			   out.write("yes");
		   }catch(Exception ex) {
			   out.write("no");
		   }
	   }

}
