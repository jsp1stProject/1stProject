package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.EventDAO;
import com.sist.dao.MailDAO;
import com.sist.vo.ContentVO;
import com.sist.vo.EventVO;
import com.sist.vo.MemberVO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

//메일
	@RequestMapping("mail/mail.do")
	public String mail(HttpServletRequest request, HttpServletResponse response)  {
		request.setAttribute("main_jsp", "../event/mail.jsp");
		return "../main/main.jsp";
	}
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

	@RequestMapping("event/event_detail.do")
	public String event_detail(HttpServletRequest request, HttpServletResponse response) {
		String contid=request.getParameter("id");
		int id=Integer.parseInt(contid);
		EventVO vo= eventDetailData(id);
		List<EventVO> imglist= eventDetailImg(id);
		List<EventVO> infolist= eventDetailInfo(id);

		System.out.println("areacode: "+vo.getCvo().getAreacode());
		List<ContentVO> nearlist= eventDetailHotel(vo.getCvo().getAreacode());
		System.out.println("nearlist:"+nearlist.size());
		request.setAttribute("imglist", imglist);
		request.setAttribute("infolist", infolist);
		request.setAttribute("vo", vo);
		request.setAttribute("nearlist", nearlist);

		Cookie cookie=new Cookie("event_"+contid,contid);
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24);
		// 전송
		response.addCookie(cookie);

		List<EventVO> clist=new ArrayList<EventVO>();
		Cookie[] cookies=request.getCookies();
		if(cookies!=null) {
			for(int i=cookies.length-1;i>=0;i--){
				if(cookies[i].getName().startsWith("event_")){
					String ckid =cookies[i].getValue();
					EventVO ckvo= eventDetailData(Integer.parseInt(ckid));
					categorySet(ckvo);
					clist.add(ckvo);
				}
				if(cookies.length-i==6) break;
			}
		}
		request.setAttribute("clist", clist);

		request.setAttribute("event", "y"); //event page
		request.setAttribute("main_jsp", "../event/event_detail.jsp");
		request.setAttribute("title", "상세보기");
		return "../main/main.jsp";
	}
}
