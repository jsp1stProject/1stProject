package com.sist.model;

import java.io.PrintWriter;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.JoinDAO;
import com.sist.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class JoinModel {
	@RequestMapping("member/join.do")
	public String member_join(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../member/join.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("member/join_idcheck_ok.do")
	public void member_id_ok(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		
		int idCount = JoinDAO.userIdCheck(id);
		
		try {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(String.valueOf(idCount));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	@RequestMapping("member/join_ok.do")
	public String member_join_ok(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String nickname = request.getParameter("nickname");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String addr1 = request.getParameter("addr1");
		String zipcode = request.getParameter("zipcode");
		String phone = request.getParameter("phone");
		
		System.out.println("id: " + id);
		System.out.println("pwd: " + pwd);
		System.out.println("name: " + name);
		System.out.println("nickname: " + nickname);
		System.out.println("birthday: " + birthday);
		System.out.println("email: " + email);
		System.out.println("addr1: " + addr1);
		System.out.println("zipcode: " + zipcode);
		System.out.println("phone: " + phone);
		
		UserVO vo = new UserVO();
		
		vo.setUser_id(id);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setNickname(nickname);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setAddr1(addr1);
		vo.setPost(zipcode);
		vo.setPhone(phone);
		
		JoinDAO.userIdInsert(vo);
		return "redirect:../main/main.do";
	}
	
}
