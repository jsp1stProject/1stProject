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
		if (page == null) {
			page = "1";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		int curPage = Integer.parseInt(page);
		int start = (10 * curPage) - 9;
		int end =(10 * curPage);
		
		map.put("start", start);
		map.put("end", end);
		
		List<NoticeVO> list = NoticeDAO.noticeListData(map);
		
		
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../notice/notice_admin_list.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("notice/notice_admin_insert.do")
	public String notice_admin_insert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("wide", "y");
		request.setAttribute("main_jsp", "../notice/notice_admin_insert.jsp");
		return "../main/main.jsp";
	}
	@RequestMapping("notice/notice_admin_insert_ok.do")
	public String notice_admin_insert_ok(HttpServletRequest request, HttpServletResponse response) {
		String subject = request.getParameter("subject");
		String beforeContent = request.getParameter("content");
		String content = Jsoup.parse(beforeContent).text();
		String type = request.getParameter("type");
		System.out.println("content: " + content);
		NoticeVO vo = new NoticeVO();
		
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setType(type);
		
		NoticeDAO.noticeInsert(vo);
		return "redirect:../notice/notice_admin_list.do";
	}
}
