package com.sist.model;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;
import com.sist.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.*;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class QnaModel {
	@RequestMapping("qna/qna_list.do")
	public String qna_list(HttpServletRequest request, HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		System.out.println(curpage);
		Map map=new HashMap();
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);
		List list = QnaDAO.qnaListData(map);
		int count= QnaDAO.qnaRowCount();
		int totalpage=(int)(Math.ceil(count/10.0));
		count=count-((10*curpage)-10);
		
		request.setAttribute("list", list);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("curpage", curpage);
		request.setAttribute("count", count);
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		request.setAttribute("main_jsp", "../qna/qna_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("qna/qna_insert.do")
	public String qna_insert(HttpServletRequest request, HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../qna/qna_insert.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("qna/qna_insert_ok.do")
	public String qna_insert_ok(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("인서트 진입");
		QnaVO vo =new QnaVO();
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String type=request.getParameter("type");
		String type_detail=request.getParameter("type_detail");
		String reserve_no=request.getParameter("reserve_no");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");
		System.out.println("스트링으로 데이터받고");
		//id와 name는 session에서 받아오기
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		System.out.println();
		//String name=(String)session.getAttribute("name");
		
		System.out.println("try진입전");
		try {
			Part filePart=request.getPart("filename"); //항상 ("")안에는 name 속성값이 들어가야한다
			String filename=filePart.getSubmittedFileName();
			System.out.println(filename);
			if(filename==null || filename.equals(""))//업로드가 안된상태
			{
				System.out.println("파일없을때");
				vo.setFilename(" ");
				System.out.println(vo.getFilename());
				vo.setFilesize(0);
			}
			else
			{
				String uploadDir="c:\\upload";
				File file=new File(uploadDir,filename);
				//오라클 -> 파일 업로드
				//try ~ resource -> 자동으로 input/output 바뀜
				try(InputStream input=filePart.getInputStream();
						FileOutputStream output=new FileOutputStream(file))
				{
					byte[] buffer=new byte[1024];
					int i=0;
					while((i=input.read(buffer,0,1024))!=-1)
					{
						output.write(buffer,0,i);
					}
				}
				System.out.println("파일업로드");
				vo.setFilename(filename);
				vo.setFilesize((int)file.length());
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println("파일오류");
		}
		System.out.println("트라이나와서");
		vo.setUser_id(user_id);
		vo.setName(name);
		vo.setEmail(email);
		vo.setPhone(phone);
		vo.setType(type);
		vo.setType_detail(type_detail);
		vo.setReserve_no(reserve_no);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		System.out.println("값 넣고");
		QnaDAO.qnaInsert(vo);
		System.out.println("인서트");
		return "redirect:../qna/qna_list.do";
	}
	
	@RequestMapping("qna/qna_detail.do")
	public String qna_detail(HttpServletRequest request, HttpServletResponse response)
	{
		String no=request.getParameter("no");
		System.out.println(no);
		QnaVO vo=QnaDAO.qnaDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("user_id");
		System.out.println(user_id);
		System.out.println(vo.getUser_id());
		request.setAttribute("main_jsp", "../qna/qna_detail.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("qna/qna_update.do")
	public String qna_update(HttpServletRequest request, HttpServletResponse response)
	{
		String no=request.getParameter("no");
		QnaVO vo=QnaDAO.qnaUpdateData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../qna/qna_update.jsp");
	    return "../main/main.jsp";
	}
	
	 @RequestMapping("qna/qna_update_ok.do")
	  public void qna_update_ok(HttpServletRequest request, HttpServletResponse res)
	  {
		  String subject=request.getParameter("subject");
		  String content=request.getParameter("content");
		  String no=request.getParameter("no");
		  
		  System.out.println("no="+no);
		  System.out.println("subject="+subject);
		  
		  QnaVO vo=new QnaVO();
		  vo.setSubject(subject);
		  vo.setContent(content);
		  vo.setNo(Integer.parseInt(no));
		  
		  QnaDAO.qnaUpdate(vo);
	  }
	 
	 
		 
	
	
	 @RequestMapping("qna/qna_delete.do")
	 public String qna_delete(HttpServletRequest request, HttpServletResponse res)
	 {
		  String group_id=request.getParameter("group_id");
		  QnaDAO.qnaDelete(Integer.parseInt(group_id));
		  return "redirect:../qna/qna_list.do";
	  }
	/* 관리자모드 */
	@RequestMapping("qna/qna_admin_list.do")
	public String qna_admin_list(HttpServletRequest request, HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		System.out.println(curpage);
		Map map=new HashMap();
		map.put("start", (10*curpage)-9);
		map.put("end", 10*curpage);
		
		List<QnaVO> list = QnaDAO.qnaAdminListData(map);
		int count= QnaDAO.qnaAdminRowCount();
		int totalpage=(int)(Math.ceil(count/10.0));
		count=count-((10*curpage)-10);
		request.setAttribute("list", list);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("curpage", curpage);
		request.setAttribute("count", count);
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		
		request.setAttribute("admin_jsp", "../qna/qna_admin_list.jsp");

		return "../adminpage/admin_main.jsp";
	}
	
	@RequestMapping("qna/qna_admin_insert.do")
	public String qna_admin_insert(HttpServletRequest request,HttpServletResponse response)
	  {
		   System.out.println("inser.do진입");
		   String gi=request.getParameter("gi"); //groud_id
		   QnaVO vo=QnaDAO.qnaAdminDetailData(Integer.parseInt(gi));
		   request.setAttribute("vo", vo);
		   request.setAttribute("admin_jsp", "../qna/qna_admin_insert.jsp");

			return "../adminpage/admin_main.jsp";
	  }  
	
	@RequestMapping("qna/qna_admin_insert_ok.do")
	  public String qna_admin_insert_ok(HttpServletRequest request,HttpServletResponse response)
	  {
		  System.out.println("insert_ok진입해서");
		  String subject=request.getParameter("subject");
		  String content=request.getParameter("content");
		  String group_id=request.getParameter("group_id");
		  
		  HttpSession session=request.getSession();
		  String user_id=(String)session.getAttribute("user_id");
		  // 데이터 유지 => 서버 자체 저장
		  System.out.println("user_id : "+user_id);
		  System.out.println("group_id : "+group_id);
		  System.out.println("subject : "+subject);
		  System.out.println("content : "+content);
		  QnaVO vo=new QnaVO();
		  vo.setUser_id(user_id);
		  vo.setGroup_id(Integer.parseInt(group_id));
		  vo.setSubject(subject);
		  vo.setContent(content);
		  System.out.println("vo저장");
		  System.out.println();
		  System.out.println("dao 진입");
		  QnaDAO.qnaAdminInsert(vo);
		  System.out.println("dao 성공");
		  return "redirect:../qna/qna_admin_list.do";
	  }  
	
	@RequestMapping("qna/qna_admin_update.do")
	public String qna_admin_update(HttpServletRequest request, HttpServletResponse response)
	{
		String group_id=request.getParameter("gi");
		System.out.println("어드민업데이트.두");
		QnaVO vo=QnaDAO.qnaAdminDetailData(Integer.parseInt(group_id));
		request.setAttribute("vo", vo);
		request.setAttribute("admin_jsp", "../qna/qna_admin_update.jsp");
	    return "../adminpage/admin_main.jsp";
	}
	
	 @RequestMapping("qna/fes_qna_admin_update_ok.do")
	  public void fes_qna_admin_update_ok(HttpServletRequest request, HttpServletResponse res)
	  {
		 System.out.println("어디민오케이");
		  String subject=request.getParameter("subject");
		  String content=request.getParameter("content");
		  String group_id=request.getParameter("group_id");
		  
		  System.out.println("group_id="+group_id);
		  System.out.println("subject="+subject);
		  
		  QnaVO vo=new QnaVO();
		  vo.setSubject(subject);
		  vo.setContent(content);
		  vo.setGroup_id(Integer.parseInt(group_id));
		  
		  QnaDAO.qnaUpdate(vo);
	  }
	@RequestMapping("qna/qna_admin_delete.do")
	public String qna_admin_delete(HttpServletRequest request,HttpServletResponse response)
	{
		String gi=request.getParameter("gi");
		QnaDAO.qnaAdminDelete(Integer.parseInt(gi));;
		return  "redirect:../qna/qna_admin_list.do";
	}
	

}
