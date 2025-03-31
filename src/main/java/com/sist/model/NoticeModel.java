package com.sist.model;

import java.util.*;
import org.jsoup.Jsoup;
import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.NoticeDAO;
import com.sist.vo.NoticeVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class NoticeModel {
	@RequestMapping("notice/notice_admin_list.do")
	public String notice_admin_list(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		String searchType = request.getParameter("searchType");
		String search = request.getParameter("search");
		System.out.println("type: " + searchType);
		System.out.println("search: " + search);
		if (page == null) {
			page = "1";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		int curPage = Integer.parseInt(page);
		int start = (10 * curPage) - 9;
		int end =(10 * curPage);
		
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		map.put("searchType", searchType);
		
		List<NoticeVO> list = NoticeDAO.noticeListData(map);
		int count = NoticeDAO.noticeTotalPage(map);
		System.out.println("count1: " + count);
		int totalPage = (int)(Math.ceil(count / 10.0));
		count = count - ((curPage * 10) - 10);
		System.out.println("count: " + count);
		System.out.println("totalPage: " + totalPage);
		
		final int BLOCK = 10;
		int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
		System.out.println("endPage: " + endPage);
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		request.setAttribute("curPage", curPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		request.setAttribute("totalPage", totalPage); 
		request.setAttribute("wide", "y");
		request.setAttribute("admin_jsp", "../notice/notice_admin_list.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("notice/notice_admin_detail.do")
	public String notice_admin_detail(HttpServletRequest request, HttpServletResponse response) {
		
		int no = Integer.parseInt(request.getParameter("no"));
		NoticeVO vo = NoticeDAO.noticeDetailData(no);
		request.setAttribute("vo", vo);
		request.setAttribute("wide", "y");
		request.setAttribute("admin_jsp", "../notice/notice_admin_detail.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("notice/notice_admin_insert.do")
	public String notice_admin_insert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("wide", "y");
		request.setAttribute("admin_jsp", "../notice/notice_admin_insert.jsp");
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("notice/notice_admin_insert_ok.do")
	public String notice_admin_insert_ok(HttpServletRequest request, HttpServletResponse response) {
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		//String content = Jsoup.parse(beforeContent).text();
		String type = request.getParameter("type");
		NoticeVO vo = new NoticeVO();
		
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setType(type);
		
		NoticeDAO.noticeInsert(vo);
		return "redirect:../notice/notice_admin_list.do";
	}
	
	@RequestMapping("notice/notice_admin_update.do")
	public String notice_update(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("no"));
		
		NoticeVO vo = NoticeDAO.noticeDetailData(no);
		
		request.setAttribute("vo", vo);
		request.setAttribute("admin_jsp", "../notice/notice_admin_update.jsp");
		
		return "../adminpage/admin_main.jsp";
	}
	@RequestMapping("notice/notice_admin_update_ok.do")
	public String notice_update_ok(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("no"));
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String type = request.getParameter("type");
		//System.out.println("no: " + no);
		//System.out.println("sub: " + subject);
		//System.out.println("con: " + content);
		//System.out.println("type: " + type);
		
		NoticeVO vo = new NoticeVO();
		
		vo.setNo(no);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setType(type);
		
		NoticeDAO.noticeUpdate(vo);
		
		return "redirect:../notice/notice_admin_detail.do?no=" + no;
		
	}
	
	@RequestMapping("notice/notice_list.do")
	public String notice_list(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		String searchType = request.getParameter("searchType");
		String search = request.getParameter("search");
		System.out.println("type: " + searchType);
		System.out.println("search: " + search);
		if (page == null) {
			page = "1";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		int curPage = Integer.parseInt(page);
		int start = (10 * curPage) - 9;
		int end =(10 * curPage);
		
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		map.put("searchType", searchType);
		
		List<NoticeVO> list = NoticeDAO.noticeListData(map);
		int count = NoticeDAO.noticeTotalPage(map);
		System.out.println("count1: " + count);
		int totalPage = (int)(Math.ceil(count / 10.0));
		count = count - ((curPage * 10) - 10);
		System.out.println("count: " + count);
		System.out.println("totalPage: " + totalPage);
		
		final int BLOCK = 10;
		int startPage = ((curPage - 1) / BLOCK * BLOCK) + 1;
		int endPage = ((curPage - 1) / BLOCK * BLOCK) + BLOCK;
		System.out.println("endPage: " + endPage);
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		request.setAttribute("curPage", curPage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		request.setAttribute("totalPage", totalPage); 
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../notice/notice_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("notice/notice_detail.do")
	public String notice_detail(HttpServletRequest request, HttpServletResponse response) {
		
		int no = Integer.parseInt(request.getParameter("no"));
		NoticeVO vo = NoticeDAO.noticeDetailData(no);
		request.setAttribute("vo", vo);
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../notice/notice_detail.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("notice/notice_admin_delete.do")
	public String notice_delete(HttpServletRequest request, HttpServletResponse response) {
		String noStr = request.getParameter("no");
		int no = Integer.parseInt(noStr);
		NoticeDAO.noticeDelete(no);
		return "redirect:../notice/notice_admin_list.do";
	}
}
