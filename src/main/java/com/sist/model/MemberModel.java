package com.sist.model;

import java.io.PrintWriter;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.MemberDAO;
import com.sist.vo.MemberVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberModel {
//	@RequestMapping("member/join.do")
//	public String member_join(HttpServletRequest request,HttpServletResponse response) {
//		// include
//		request.setAttribute("main_jsp", "../member/join.jsp");
//		return "../main/main.jsp";
//	}
	
	
	@RequestMapping("member/idcheck.do")
	public String member_idcheck(HttpServletRequest request,HttpServletResponse response) {
		// include
		//request.setAttribute("main_jsp", "../member/idcheck.jsp");
		return "../member/idcheck.jsp";
	}
	//456
	
	@RequestMapping("member/idcheck_ok.do")
	public void member_idcheck_ok(HttpServletRequest request,HttpServletResponse response) {
		//void => 일반데이터
		// => JSON
		// data:{"id":id.trim()} ?id=aaa
		String user_id=request.getParameter("user_id");
		int count=MemberDAO.memberIdcheck(user_id);
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.write(String.valueOf(count));
			// int => char
		}catch(Exception ex) {}
	}
//	@RequestMapping("member/join_ok.do")
//	public String member_join_ok(HttpServletRequest request,HttpServletResponse response) {
//		String user_id=request.getParameter("user_id");
//		String pwd=request.getParameter("pwd");
//		String name=request.getParameter("name");
//		String sex=request.getParameter("sex");
//		String birthday=request.getParameter("day");
//		String email=request.getParameter("email");
//		String post=request.getParameter("post");
//		String addr1=request.getParameter("addr1");
//		String addr2=request.getParameter("addr2");
//		String phone1=request.getParameter("phone1");
//		String phone2=request.getParameter("phone2");
//		
//		MemberVO vo=new MemberVO();
//		vo.setUser_id(user_id);
//		vo.setPwd(pwd);
//		vo.setName(name);
//		vo.setSex(sex);     
//		vo.setBirthday(birthday);
//		vo.setEmail(email);
//		vo.setPost(post);
//		vo.setAddr1(addr1);
//		vo.setAddr2(addr2);
//		vo.setPhone(phone1+"-"+phone2);
//		
//		MemberDAO.memberInsert(vo);
//		return "redirect:../main/main.do";
//	}
	
	@RequestMapping("member/login.do")
	public String member_login(HttpServletRequest request,HttpServletResponse response) {
		
		return "../member/login.jsp";
	}
	// 로그인 처리 
	@RequestMapping("member/login_ok.do")
	public void member_login_ok(HttpServletRequest request,HttpServletResponse response) {
		String user_id=request.getParameter("user_id");
		String pwd=request.getParameter("pwd");
		System.out.println("user_id:"+user_id +"pwd"+pwd);
		MemberVO vo=MemberDAO.memberLogin(user_id, pwd);
		if(vo.getMsg().equals("OK")) {
			HttpSession session=request.getSession();
			session.setAttribute("user_id", vo.getUser_id());
			session.setAttribute("name", vo.getName());
			session.setAttribute("nickname", vo.getNickname());
			session.setAttribute("sex", vo.getSex());
			session.setAttribute("admin", vo.getAdmin());
			// post / addr1 / addr2 / email / phone
		}
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();  // ajax 일때만 씀 
			out.write(vo.getMsg());
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	// 로그아웃 처리
	@RequestMapping("member/logout.do")
	public String member_logout(HttpServletRequest request,HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.invalidate();  // 세션의 정보를 지울때 씀
		return "redirect:../main/main.do";
	}
}
