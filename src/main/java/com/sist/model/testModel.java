package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class testModel {
    @RequestMapping("main/search.do")
    public String main_main(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("main_jsp", "../template/search.jsp");
        request.setAttribute("title", "검색 결과");
        request.setAttribute("wide", "y"); //본문 가로폭 넓히려면 attribute에 wide:y 추가
        return "../main/main.jsp";
    }

}
