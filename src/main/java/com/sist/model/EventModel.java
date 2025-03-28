package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.MailDAO;
import com.sist.vo.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import static com.sist.dao.EventDAO.*;


@Controller
public class EventModel {
//내정보
	@RequestMapping("mypage/myinfo.do")
	public String myinfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("user_id") == null) { //세션 만료 시 main 이동
			return "redirect:../main/main.do";
		}else{
			String id=session.getAttribute("user_id").toString();
			MemberVO vo= memberDetail(id);
			request.setAttribute("vo", vo);
			session.removeAttribute("code");
			session.setAttribute("email", vo.getEmail());
			session.removeAttribute("expireTime");
			session.setAttribute("verified", "true");
		}
		request.setAttribute("title", "내 정보");
		request.setAttribute("main_jsp", "../mypage/myinfo.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("mypage/myinfo_update.do")
	public void myinfo_update(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json;charset=UTF-8");
		//request 파싱
		JSONObject json= jsonParse(request,response);

		HttpSession session = request.getSession();
		JSONObject obj=new JSONObject();
		if(session.getAttribute("user_id") == null) { //로그인 세션 만료 시
			obj.put("statement", "expired");
		}else if(session.getAttribute("verified") == null ||
				!session.getAttribute("email").equals(json.get("email").toString())) { //인증하지 않거나, 인증한 이메일과 입력값이 다르면
			obj.put("statement", "not_verified");
		}else{
			String id=session.getAttribute("user_id").toString();
			//기본 parameter 매핑
			HashMap map=new HashMap();
			map.put("user_id", json.get("user_id").toString());
			map.put("name", json.get("name").toString());
			//비밀번호 변경 안 했으면 기존 비밀번호 적용
			if(json.get("pwd_after")==null||json.get("pwd_after").toString().equals("")){
				map.put("pwd", json.get("pwd_before").toString());
			}else{
				map.put("pwd", json.get("pwd_after").toString());
			}
			map.put("nickname", json.get("nickname").toString());
			map.put("email", json.get("email").toString());
			map.put("phone", json.get("phone").toString());
			map.put("addr1", json.get("addr1").toString());
			map.put("addr2", json.get("addr2").toString());
//			map.put("profile_img", json.get("profile").toString()); //프로필 이미지 기능 미구현
			map.put("birthday", json.get("birth").toString());
			map.put("post", json.get("post").toString());

			boolean state= memberUpdate(map,json.get("pwd_before").toString());
			if(state) {//비밀번호 일치하면
				obj.put("statement", "success");
			}else{
				obj.put("statement", "failed");
			}
			PrintWriter out=null;
			try {
				out=response.getWriter();
				out.write(obj.toJSONString());
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
				System.out.println("ioe오류");
			}
		}
	}
	@RequestMapping("mypage/withdrawBefore.do")
	public String withdrawBefore(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mode", "1"); //1이면 비밀번호 입력, 2면 탈퇴 페이지

		request.setAttribute("title", "내 정보");
		request.setAttribute("main_jsp", "../mypage/withdraw.jsp");
		return "../main/main.jsp";
	}

	@RequestMapping("mypage/withdraw.do")
	public String withdraw(HttpServletRequest request, HttpServletResponse response) {
		String pwd=request.getParameter("pwd");
		String user_id=request.getParameter("user_id");
		HashMap map=new HashMap();
		map.put("user_id", user_id);
		map.put("pwd", pwd);
		boolean state= memberPwdCheck(map);

		if(state) { //비밀번호가 일치하면
			request.setAttribute("mode", "2"); //1이면 비밀번호 입력, 2면 탈퇴 페이지
			request.setAttribute("title", "내 정보");
		}else{
			HttpSession session = request.getSession();
			session.invalidate();
			request.setAttribute("mode", "3"); //3이면 강제 로그아웃
		}
		request.setAttribute("main_jsp", "../mypage/withdraw.jsp");
		return "../main/main.jsp";
	}

	@RequestMapping("mypage/withdrawExecute.do")
	public void withdraw_execute(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json;charset=UTF-8");
		String user_id=request.getParameter("user_id");
		memberDelete(user_id); //탈퇴 실행

		HttpSession session = request.getSession();
		session.invalidate(); //세션 삭제

		JSONObject obj=new JSONObject();

		obj.put("statement", "success"); //response mapping
		PrintWriter out=null;
		try {
			out=response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("ioe오류");
		}
	}

//메일
	@RequestMapping("mail/codeSending.do")
	public void codeSending(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json;charset=UTF-8");

		String email=request.getParameter("email"); //인증 대상 이메일
		String code=MailDAO.sendMail(email); //인증코드 생성

		HttpSession session=request.getSession();
		session.setAttribute("code", code);
		session.setAttribute("expireTime", System.currentTimeMillis() + (300 * 1000)); //유효기간 5분
		session.setAttribute("email", email);
		session.removeAttribute("verified"); //검증 결과 삭제

		JSONObject obj=new JSONObject();
		obj.put("statement", "success");
		PrintWriter out=null;
        try {
			out=response.getWriter();
            out.write(obj.toJSONString());
			out.flush();
        } catch (IOException e) {
            e.printStackTrace();
			System.out.println("ioe오류");
        }
    }
	@RequestMapping("mail/verification.do")
	public void verification(HttpServletRequest request, HttpServletResponse response){
		response.setContentType("application/json;charset=UTF-8");
		HttpSession session=request.getSession();
		JSONObject obj=new JSONObject();

		String authCode=request.getParameter("code"); //입력받은 코드
		String email=request.getParameter("email"); //현재 이메일
		Long expireTime = (Long) session.getAttribute("expireTime");
		if(authCode!=null && expireTime!=null){ //코드를 발급 받고 입력했으면
			if(System.currentTimeMillis() <= expireTime){
				System.out.println(session.getAttribute("code"));
				String code=session.getAttribute("code").toString();
				if(authCode.equals(code)){
					obj.put("statement", "success");
					session.setAttribute("verified", "true");
				}else{
					obj.put("statement", "fail");
				}
			}else { //만료
				obj.put("statement", "expired");
				session.removeAttribute("code");
				session.removeAttribute("expireTime");
			}
		}

		PrintWriter out=null;
		try {
			out=response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("ioe오류");
		}
	}

	@RequestMapping("event/main.do")
	public String event_main(HttpServletRequest request, HttpServletResponse response) {
		HashMap map = new HashMap();
		String[] code={"1"};
		map.put("areacode", code);
		map.put("start", "1");
		map.put("end", "8");
		List<EventVO> arealist1= eventSearchList(map);
		request.setAttribute("arealist1", arealist1);

		code[0]="6";
		map.put("areacode", code);
		List<EventVO> arealist2= eventSearchList(map);
		request.setAttribute("arealist2", arealist2);

		code[0]="39";
		map.put("areacode", code);
		List<EventVO> arealist3= eventSearchList(map);
		request.setAttribute("arealist3", arealist3);

		List<EventVO> list3= mainEventList();
		request.setAttribute("musicalList", list3);

		List<EventVO> list2= mainFesList();
		request.setAttribute("fesList", list2);

		HttpSession session=request.getSession();
		if(session.getAttribute("user_id")!=null){
			int eventcart=eventCartCount(session.getAttribute("user_id").toString());
			session.setAttribute("eventcart", eventcart);
		}

		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../event/event_home.jsp");
		request.setAttribute("event", "y"); //event page
		request.setAttribute("title", "메인");
		return "../main/main.jsp";
	}

	@RequestMapping("event/event_list.do")
	public String event_list(HttpServletRequest request, HttpServletResponse response) {
		//필터 카테고리 목록
		request.setAttribute("catemap", catemap);

		//mode 없으면 행사 메인페이지로
		String mode=request.getParameter("mode");
		if(mode==null){
			return "redirect:../event/main.do";
		}
		request.setAttribute("mode", mode);

		//parameter 매핑
		HashMap map = new HashMap();

		if(mode.equals("search")){
			map.put("key", request.getParameter("key"));
		}else if(mode.equals("area")){
			map.put("areacode", request.getParameterValues("type"));
			request.setAttribute("areaStr",request.getParameter("areastr"));
		}

		//최대값,최소값,결과개수
		EventVO vo= eventSearchDefault(map);
		if(vo.getMaxprice()!=null){
			request.setAttribute("maxprice", vo.getMaxprice());
			request.setAttribute("minprice", vo.getMinprice());
		}else { //row 없으면
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
        JSONObject json= jsonParse(request,response);

		//기본 parameter 매핑
		String page=json.get("curpage").toString();
		String filter=json.get("filter").toString(); //filter true/false
		HashMap map = new HashMap();
		int curpage=Integer.parseInt(page);
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);

		//mode:{search||area}
		String mode=request.getParameter("mode");
		if(mode.equals("search")){ //검색 페이지
			System.out.println("mode인식:"+mode);
			String key=json.get("key").toString();
			map.put("key", key);
		}else if(mode.equals("area")){ //지역별 페이지
			System.out.println("mode인식:"+mode);
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
			map.put("areacode", codeArr2);
		}

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

		//검색결과 총개수
		EventVO cvo= eventSearchDefault(map);
		//검색결과 목록
		List<EventVO> list= eventSearchList(map);
		JSONArray arr=new JSONArray();
		int i=0;
		for(EventVO vo:list){
			JSONObject obj=new JSONObject();
			obj.put("content_id", vo.getContent_id());
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
//상세페이지
	@RequestMapping("event/event_detail.do")
	public String event_detail(HttpServletRequest request, HttpServletResponse response) {
		String contid=request.getParameter("id");
		int id=Integer.parseInt(contid); //content_id

		EventVO vo= eventDetailData(id);
		List<EventVO> imglist= eventDetailImg(id);
		List<EventVO> infolist= eventDetailInfo(id);
		List<ContentVO> nearlist= eventDetailHotel(vo.getCvo().getAreacode());
		HashMap map=new HashMap();
		map.put("content_id", contid);
		map.put("start", 1);
		map.put("end", 5);
		List<ReviewVO> rvlist=eventReviewList(map);

		HttpSession session = request.getSession();
		if(session.getAttribute("user_id")!=null){
			String user_id = (String) session.getAttribute("user_id");
			HashMap map2=new HashMap();
			map2.put("content_id", contid);
			map2.put("user_id", user_id);
			List<EventOrderVO> orderlist = eventMyReviewOrderList(map2);
			request.setAttribute("orderlist", orderlist);
		}


		request.setAttribute("imglist", imglist);
		request.setAttribute("infolist", infolist);
		request.setAttribute("vo", vo);
		request.setAttribute("nearlist", nearlist);
		request.setAttribute("rvlist", rvlist);
		request.setAttribute("reviewmode", "insert");//리뷰 쓰기 창 include 시 사용

		//쿠키
		String cookies="";
		Cookie[] cookiesArray = request.getCookies();
		if(cookiesArray!=null){
			for(Cookie cookie:cookiesArray){
				if(cookie.getName().equals("eventCookies")){
					cookies=cookie.getValue();
				}
			}
		}
		List<EventVO> clist=new ArrayList<EventVO>();
		List<String> ids=new LinkedList<>(Arrays.asList(cookies.split("/")));

		//현재 페이지 추가 전 방문기록 리스트 생성
		if(ids.size()>0||ids.get(0)!=null||!ids.get(0).equals("")){
			for(String s:ids){
				if(!s.equals("")){
					EventVO ckvo= eventDetailData(Integer.parseInt(s));
					categorySet(ckvo);
					clist.add(ckvo);
				}
			}
		}
		request.setAttribute("clist", clist);

		//쿠키에 현재 페이지 추가
		ids.remove(contid);
		ids.add(0,contid);
		if(ids.size()>10){ //최대 10개까지 저장
			ids=ids.subList(0,10);
		}
		String newCookies=String.join("/",ids);
		Cookie cookie=new Cookie("eventCookies",newCookies);
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24); //쿠키 유효기간 1일
		response.addCookie(cookie);

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/event_detail.jsp");
		request.setAttribute("title", "상세보기");
		return "../main/main.jsp";
	}
//	행사 리뷰 작성
	@RequestMapping("event/review_insert.do")
	public void event_review_insert(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
		JSONObject json = jsonParse(request, response); //content_id,rate,message
		//세션에서 아이디 정보
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");

		if (json.size() == 0) return; //값이 없으면 종료
		String content_id = (String) json.get("content_id");
		int rate = Integer.parseInt((String) json.get("rate"));
		String message = (String) json.get("message");
		String order_id = (String) json.get("order_id");
		System.out.println(content_id);
		System.out.println(rate);
		System.out.println(message);

		HashMap map = new HashMap();
		map.put("user_id", user_id);
		map.put("content_id", content_id);
		map.put("rate", rate);
		map.put("message", message);
		map.put("order_id", order_id);
		map.put("used","r");
		System.out.println("order_id:"+order_id);
		eventReviewInsert(map);

		JSONObject obj=new JSONObject();
		obj.put("statement", "success");

		PrintWriter out;
		try {
			out = response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
//	장바구니 cart
	@RequestMapping("event/cart.do")
	public String event_cart(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		if(session.getAttribute("user_id")==null){
			return "redirect:../event/main.do";
		}
		String user_id=(String)session.getAttribute("user_id"); //세션에서 아이디 정보
		HashMap map=new HashMap();
		map.put("user_id", user_id);
		List<CartVO> list=cartList(map); //장바구니 목록
		request.setAttribute("list", list);

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/cart.jsp");
		request.setAttribute("title", "장바구니");
		return "../main/main.jsp";
	}
//	장바구니 추가/수정
	@RequestMapping("event/cart_insert.do")
	public void event_cart_insert(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
		JSONObject json = jsonParse(request, response); //content_id,account,price,total_price,(incr/decr)
		//세션에서 아이디 정보
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");

		if (json.size() == 0) return; //값이 없으면 종료

		for (Object cart : json.values()) { //각 상품 목록
			List<String> cartData = List.of(cart.toString().split("/")); //데이터 분리
			int contid = Integer.parseInt(cartData.get(0)); //행사 content_id
			int account_new = Integer.parseInt(cartData.get(1)); //추가하려는 상품 개수
			int price = Integer.parseInt(cartData.get(2)); //상품 하나 가격
			int total_price = Integer.parseInt(cartData.get(3)); //상품 전체개수 총가격
			int account_after=0;

			HashMap map = new HashMap();
			map.put("user_id", user_id);
			map.put("content_id", contid);
			List<CartVO> list = cartList(map); //이미 존재하는 상품인지 조회

			if (list.size() > 0) { //장바구니에 이미 해당 상품이 있다면
				int account_before = list.get(0).getAccount(); //기존 상품 개수

				if(cartData.size()==5){ //상품 개수 수정 요청일 때
					String state = cartData.get(4); //state:update
					account_after=account_new;
				}else{ //신규 추가일 때
					account_after = account_before + account_new;
					if (account_after > 10){ //한 행사 당 티켓은 10개까지 구매 가능
						account_after = 10;
						total_price = price * 10;
					}
				}
				map.put("account", account_after);
				map.put("total_price", price * account_after);
				map.put("cno", list.get(0).getCno());
				cartUpdate(map);
			} else { //장바구니에 없는 상품 새로 추가
				map.put("account", account_new);
				map.put("total_price", total_price);
				map.put("price", price);
				cartInsert(map);
			}
		}

		//cart count 세션에 갱신+json으로 보내기
		session.setAttribute("eventcart", eventCartCount(user_id));
		JSONObject obj=new JSONObject();
		obj.put("eventcart", eventCartCount(user_id));

		PrintWriter out;
		try {
			out = response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
//	장바구니 삭제
	@RequestMapping("event/cart_delete.do")
	public void event_cart_delete(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		int cno=Integer.parseInt(request.getParameter("cno"));
		boolean result=cartDelete(request.getParameter("cno")); //삭제 실행

		JSONObject obj=new JSONObject();
		if(result) {//삭제됐으면
			obj.put("statement", "success");
		}else{
			obj.put("statement", "failed");
		}

		//세션에서 아이디 정보
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");

		//cart count 세션에 갱신+json으로 보내기
		session.setAttribute("eventcart", eventCartCount(user_id));
		obj.put("eventcart", eventCartCount(user_id));
		PrintWriter out=null;
		try {
			out=response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("ioe오류");
		}
	}
	@RequestMapping("event/cart_ok.do")
	public String event_cart_ok(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
		JSONObject json = jsonParse(request, response); //merchant_uid, user_id
		String user_id = (String) json.get("user_id");
		String merchant_uid = (String) json.get("merchant_uid");
		System.out.println("merchant_uid:"+ merchant_uid);
		System.out.println("user_id:"+user_id);

		HashMap map = new HashMap();
		map.put("user_id", user_id);
		List<CartVO> list=cartList(map); //해당 유저의 장바구니 목록 (장바구니 전체 주문만 가능하도록 기능 제한함)
		for(CartVO vo:list){ //장바구니 목록 전체 주문 실행
			HashMap map2=new HashMap();
			map2.put("merchant_uid", merchant_uid);
			map2.put("account", vo.getAccount());
			map2.put("total_price", vo.getTotal_price());
			map2.put("content_id", vo.getCvo().getContent_id());
			map2.put("user_id", user_id);
			eventOrderInsert(map2);
		}
		cartDeleteAll(user_id); //주문 완료 후 장바구니 초기화

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/cart_ok.jsp");
		request.setAttribute("title", "장바구니");
		return "../main/main.jsp";
	}
// 주문저장
	@RequestMapping("event/order_ok.do")
	public void event_order_ok(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/x-json;charset=UTF-8");
		//request 파싱
		JSONObject json = jsonParse(request, response); //order_id, user_id
		String user_id = (String) json.get("user_id");
		String order_id = (String) json.get("order_id");
		System.out.println("order_id:"+order_id);
		System.out.println("user_id:"+user_id);

		HashMap map = new HashMap();
		map.put("user_id", user_id);
		List<CartVO> list=cartList(map); //해당 유저의 장바구니 목록 (장바구니 전체 주문만 가능하도록 기능 제한함)
		for(CartVO vo:list){ //장바구니 목록 전체 주문 실행
			HashMap map2=new HashMap();
			map2.put("order_id", order_id);
			map2.put("account", vo.getAccount());
			map2.put("total_price", vo.getTotal_price());
			map2.put("content_id", vo.getCvo().getContent_id());
			map2.put("user_id", user_id);
			eventOrderInsert(map2);
		}
		cartDeleteAll(user_id); //주문 완료 후 장바구니 초기화

		JSONObject obj=new JSONObject();
		obj.put("statement", "success");
		PrintWriter out=null;
		try {
			out=response.getWriter();
			out.write(obj.toJSONString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("ioe오류");
		}
	}
//	행사 구매 목록
	@RequestMapping("mypage/event_list.do")
	public String event_order_list(HttpServletRequest request, HttpServletResponse response) {
		//세션에서 아이디 정보
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("user_id:"+user_id);

		List<EventOrderVO> list=eventOrderList(user_id);
		System.out.println("list:"+list.size());
		request.setAttribute("list", list);

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../mypage/event_list.jsp");
		request.setAttribute("title", "내 이벤트");
		return "../main/main.jsp";
	}

//	행사 구매 상세
	@RequestMapping("mypage/event_detail.do")
	public String event_order_detail(HttpServletRequest request, HttpServletResponse response) {
		//세션에서 아이디 정보
		String order_id=request.getParameter("order_id");
		String content_id=request.getParameter("content_id");
		if(order_id==null || content_id==null){
			return "redirect:../main/main.do";
		}
		HashMap map = new HashMap();
		map.put("order_id", order_id);
		map.put("content_id", content_id);
		EventOrderVO vo=eventOrderDetail(map);
		request.setAttribute("vo", vo);

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../mypage/event_detail.jsp");
		request.setAttribute("title", "행사");
		return "../main/main.jsp";
	}
}
