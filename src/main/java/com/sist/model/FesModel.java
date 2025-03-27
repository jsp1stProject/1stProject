package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.vo.*;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;

@Controller
public class FesModel {
	
	@RequestMapping("fes/fes_home.do")
	public String fes_home(HttpServletRequest request, HttpServletResponse response)
	{
		List<FesVO> list=FesDAO.fesHomeData();
		List<FesVO> dlist=FesDAO.fesHomeData_DATE();
		List<NoticeVO> nlist=FesDAO.fesHomeNotice();
		
		System.out.println("nlist 갯수 : "+nlist.size());
		request.setAttribute("list", list);
		request.setAttribute("dlist", dlist);
		request.setAttribute("nlist", nlist);
		request.setAttribute("title", "메인");
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
		String[] valueSet= request.getParameterValues("valueSet");
		//String page=request.getParameter("page");
		int min=Integer.parseInt(valueSet[0]);
		int max=Integer.parseInt(valueSet[1]);
		//int curpage=Integer.parseInt(page);
		Map map = new HashMap();
		map.put("cat3List", cat3List);
		map.put("acList", acList);
		map.put("search", search);
		map.put("min", min);
		map.put("max", max);
		
		List<FesVO> list = FesDAO.fesFindData(map);
		/*
		 * int totalpage=FesDAO.fesFindTotalPage(map);
		 * 
		 * final int BLOCK=10; int startPage=((curpage-1)/BLOCK*BLOCK)+1; int
		 * endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		 * 
		 * if(endPage>totalpage) endPage=totalpage;
		 */
		  
		System.out.println("cat3List값은 : " + Arrays.toString(cat3List));
		System.out.println("acList값은 : " + Arrays.toString(acList));
		System.out.println("max값은 : " + max);
		System.out.println("min값은 : " + min);
		System.out.println("search값은 : "+search);
		System.out.println("데이터 검색 수는 " + list.size());
		int i=0;
		
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
			obj.put("price", vo.getPrice());
			
			if(i==0)
			{
				/*
				 * obj.put("curpage", curpage); obj.put("totalpage", totalpage);
				 * obj.put("startPage", startPage); obj.put("endPage",endPage);
				 */
				obj.put("search", search);
			}
			arr.add(obj);
			i++;
			
		}
		try {
			response.setContentType("text/plain;charset:UTF-8");
			PrintWriter out = response.getWriter();
			out.write(arr.toJSONString());//데이터보내기
		} catch (Exception e) {
			// TODO: handle exception
		}
		//request.setAttribute("list", list);
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

		return "redirect:fes_detail.do?content_id="+content_id;

	} 

	@RequestMapping("fes/fes_detail.do")
	public String fes_detail(HttpServletRequest request, HttpServletResponse response) 
	{
		System.out.println("fes_detail.do");
		String content_id = request.getParameter("content_id");
		System.out.println("vo받아오기 전");
		System.out.println(content_id);
		FesVO vo = FesDAO.fesDetailData(Integer.parseInt(content_id));
		System.out.println("===좌표정보===");
		System.out.println(vo.getMapy());
		System.out.println(vo.getMapx());
		List<FesVO> ilist = FesDAO.fesInfoData(Integer.parseInt(content_id));
		System.out.println(ilist.size());

		for (FesVO ivo : ilist) {
			if (ivo.getInfoname().equals("행사소개"))
				vo.setInfotext1(ivo.getInfotext());
			if (ivo.getInfoname().equals("행사내용"))
				vo.setInfotext2(ivo.getInfotext());
		}
		List<FesVO> plist = FesDAO.fesPosterData(Integer.parseInt(content_id));
		String startdate=vo.getEvent_startdate();
		String enddate=vo.getEvent_enddate();
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		//MemberVO mvo = MemberDAO.memberInfoData(user_id);
		vo.setEvent_startdate(startdate.substring(0, 10));
		vo.setEvent_enddate(enddate.substring(0, 10));
		System.out.println("startdate");
		System.out.println(startdate);
		
		//review
		ReviewVO rvo=new ReviewVO();
		rvo.setContent_id(Integer.parseInt(content_id));
		rvo.setType(3);
		List<ReviewVO> rlist=FesDAO.reviewListData(rvo);
		int count=FesDAO.reviewCount(rvo);
		request.setAttribute("count", count);
		request.setAttribute("rlist", rlist);
		System.out.println("리뷰리스트의 수는? :"+rlist.size());
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
		//request.setAttribute("mvo", mvo);
		request.setAttribute("vo", vo);
		// request.setAttribute("ilist", ilist);
		request.setAttribute("pList", plist);
		request.setAttribute("main_jsp", "../fes/fes_detail.jsp");

		return "../main/main.jsp";
	}

	/*
	 * *****************************************************************************************************
	*/
	@RequestMapping("fes/fes_cart_insert.do")
	public String fes_cart_insert(HttpServletRequest request, HttpServletResponse response) 
	{
		String fno=request.getParameter("fno");
		String account=request.getParameter("product_count");
		String cart_price=request.getParameter("cart_price"); //상품가격
		System.out.println("cart_price값은 : "+cart_price);
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		System.out.println("상품 번호:"+fno);
		System.out.println("선택 수량 : "+account);
		System.out.println("상품 가격 : "+cart_price);
		System.out.println("user_id :"+user_id);
		FesCartVO vo = new FesCartVO();
		vo.setAccount(Integer.parseInt(account));
		vo.setFno(Integer.parseInt(fno));
		vo.setCart_price(Integer.parseInt(cart_price));
		vo.setUser_id(user_id);
		
		FesDAO.fesCartInsert(vo);
		return "redirect:../fes/fes_cart_list.do";
	}
	
	//장바구니 수량 변경
	@RequestMapping("fes/fes_cart_update.do")
	public void fes_cart_update(HttpServletRequest request, HttpServletResponse response) 
	{
		String fno=request.getParameter("fno");
		String account=request.getParameter("account");
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		System.out.println("상품 번호:"+fno);
		System.out.println("선택 수량 : "+account);
		System.out.println("user_id :"+user_id);
		Map map = new HashMap();
		map.put("fno", Integer.parseInt(fno));
		map.put("account", Integer.parseInt(account));
		map.put("user_id", user_id);
		
		FesDAO.fesCartListUpdate(map);
		
	}
	@RequestMapping("fes/fes_cart_list.do")
	public String fes_cart_list(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		List<FesCartVO> clist=FesDAO.fesCartListData(user_id);
		request.setAttribute("list", clist);
		request.setAttribute("count", clist.size());
		request.setAttribute("main_jsp", "../fes/fes_cart_list.jsp");
		return "../main/main.jsp";

	}
	
	@RequestMapping("fes/fes_buy_insert.do")
	public void buy_insert(HttpServletRequest request, HttpServletResponse response)
	{
		String fno=request.getParameter("fno");
		String account=request.getParameter("account");
		String cart_price=request.getParameter("price"); //상품가격
		System.out.println("cart_price값은 : "+cart_price);
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		  
		FesCartVO vo = new FesCartVO();
		vo.setFno(Integer.parseInt(fno));
		vo.setUser_id(user_id);
		vo.setAccount(Integer.parseInt(account));
		vo.setCart_price(Integer.parseInt(cart_price));
		
		System.out.println(vo.getAccount());
		System.out.println(vo.getFno());
		System.out.println(vo.getCart_price());
		System.out.println(vo.getUser_id());
		FesDAO.buyInsert(vo);
		  
		MemberVO mvo=MemberDAO.memberInfoData(user_id);
		System.out.println("userid:"+user_id+",name="+mvo.getName());
		JSONObject obj=new JSONObject();
		obj.put("name", mvo.getName());
		obj.put("email", mvo.getEmail());
		obj.put("phone", mvo.getPhone());
		obj.put("address", mvo.getAddr1()+" "+mvo.getAddr2());
		obj.put("post", mvo.getPost());
		obj.put("account", Integer.parseInt(account));
		obj.put("cart_price", Integer.parseInt(cart_price));
		System.out.println(mvo.getName());  
		System.out.println(mvo.getEmail());
		System.out.println(mvo.getPhone());
		System.out.println(mvo.getAddr1());
		System.out.println(mvo.getPost());
		try
		{
			response.setContentType("text/plain;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(obj.toJSONString());
		}catch(Exception ex) {}
	  
	}
	/* =====================================================================  */
	// 리뷰
	@RequestMapping("fes/review_insert.do")
	public String review_insert(HttpServletRequest request, HttpServletResponse response)
	  {
		  System.out.println("리뷰인서트 진입");
		  String content_id=request.getParameter("content_id"); //rno가 
		  String type=request.getParameter("type");
		  String msg=request.getParameter("msg");
		  //String rate=request.getParameter("rate");
		  
		  HttpSession session=request.getSession();
		  String user_id=(String)session.getAttribute("user_id");
		  String name=(String)session.getAttribute("name");
		  String sex=(String)session.getAttribute("sex");
		  System.out.println(user_id);
		  System.out.println(msg);
		  System.out.println(type);https://dev-handbook.tistory.com/48
		  System.out.println(content_id);
		  ReviewVO rvo=new ReviewVO();
		  rvo.setUser_id(user_id);
		  //rvo.setName(name);
		  //rvo.setSex(sex);
		  rvo.setMessage(msg);
		  rvo.setType(Integer.parseInt(type));
		  rvo.setContent_id(Integer.parseInt(content_id));
		  rvo.setRate(1);
		  
		  FesDAO.reviewInsert(rvo);
		  
		  return "redirect:../fes/fes_detail.do?content_id="+content_id;
	  }  
	
	@RequestMapping("fes/review_delete.do")
	  public String reply_delete(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  String no=request.getParameter("no");
		  String content_id=request.getParameter("content_id");
		  String type=request.getParameter("type");
		  
		  
		  FesDAO.reviewDelete(Integer.parseInt(no));
		  return "redirect:../fes/fes_detail.do?content_id="+content_id;
	  }
	  
	  @RequestMapping("fes/review_update.do")
	  public String reply_update(HttpServletRequest request,
			  HttpServletResponse response)
	  {
		  String no=request.getParameter("no");
		  String content_id=request.getParameter("content_id");
		  String type=request.getParameter("type");
		  String message=request.getParameter("message");
		  
		  ReviewVO vo=new ReviewVO();
		  vo.setNo(Integer.parseInt(no));
		  vo.setMessage(message);
		  
		  FesDAO.reviewUpdate(vo);
		  return "redirect:../fes/fes_detail.do?content_id="+content_id;
	  }
	  
	  @RequestMapping("mypage/mycupon.do")
	  public String mycupon(HttpServletRequest request,  HttpServletResponse response)
	  {
		  System.out.println("페이지 들어가기");		  
		  HttpSession session=request.getSession();
		  String user_id=(String)session.getAttribute("user_id");
		  System.out.println(user_id);
		  List<UserCouponsVO> list=FesDAO.couponList(user_id);
		  System.out.println(list.size());
		  //vo.setEvent_enddate(enddate.substring(0, 10));
		  request.setAttribute("list", list);
		  //request.setAttribute("title", "메인");
		  request.setAttribute("main_jsp", "../mypage/mycupon.jsp");
		  return "../main/main.jsp";
		  
	  }

}
