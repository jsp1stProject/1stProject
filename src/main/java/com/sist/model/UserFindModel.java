package com.sist.model;
import java.io.PrintWriter;
import java.util.*;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Controller
public class UserFindModel {
	@RequestMapping("member/idfind.do")
	   public String user_idfind(HttpServletRequest request,
			   HttpServletResponse response)
	   {
		   request.setAttribute("main_jsp", "../member/idfind.jsp");
		   return "../main/main.jsp";
	   }
	   @RequestMapping("member/idfind_ok1.do")
	   public void user_idfind_ok1(HttpServletRequest request,HttpServletResponse response)
	   {
	 	  String name=request.getParameter("name");
	 	  String email=request.getParameter("email");
	 	  UserVO vo=new UserVO();
	 	  vo.setName(name);
	 	  vo.setEmail(email);
	 	  // 데이터베이스 연동 
	 	  String result=UserFindDAO.userIdFindData_Email(vo); 
	 	  // Ajax로 값 전송 
	 	  try
	 	  {
	 		  PrintWriter out=response.getWriter();
	 		  out.write(result);
	 	  }catch(Exception ex) {}
	   }
	   @RequestMapping("member/idfind_ok2.do")
	   public void user_idfind_ok2(HttpServletRequest request,HttpServletResponse response)
	   {
	 	  String name=request.getParameter("name");
	 	  String phone=request.getParameter("phone");
	 	  StringBuffer phone1 = new StringBuffer(phone);
	 	  phone1.insert(3, "-");
	 	  phone1.insert(8, "-");
	 	  System.out.println("phone1:"+phone);
	 	  System.out.println(phone1.length());
	 	  String phone2=phone1.toString();
	 	  UserVO vo=new UserVO();
	 	  vo.setName(name);
	 	  vo.setPhone(phone2);
	 	  // 데이터베이스 연동 
	 	  String result=UserFindDAO.userIdFindData_Phone(vo); 
	 	  // Ajax로 값 전송 
	 	  try
	 	  {
	 		  PrintWriter out=response.getWriter();
	 		  out.write(result);
	 	  }catch(Exception ex) {}
	   }
}
