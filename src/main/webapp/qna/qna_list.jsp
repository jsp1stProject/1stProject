<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
</head>
<body>
<style>
    span.type, span.type2 {
        color:#626262;
        padding: 2px 4px;
        border:1px solid #c4c4c4;
    }
    span.type{
        margin-right:4px;
    }
</style>
    <div class="container pt-5 pt-lg-3" style="margin: 0 auto;">
        <div class="row" style="width:800px; margin: 0 auto; ">
            <h3 class="pt-3 pt-lg-0 pb-3">QnA</h3>
            <c:if test="${sessionScope.user_id!=null and sessionScope.admin=='N' }">
            <table class="table">
                <tr>
                    <td>
                        <a href="../qna/qna_insert.do" class="btn btn-outline-danger btn-sm">문의글 작성</a>
                    </td>
                </tr>
            </table>
             </c:if>
            <table class="table tb-df">
                <tr>
                    <th width="10%" class="text-center">번호</th>
                    <th width="*" class="text-center">제목</th>
                    <th width="90px" class="text-center">이름</th>
                    <th width="100px" class="text-center">작성일</th>
                    <th width="50px" class="text-center">조회수</th>
                </tr>
                <c:set var="count" value="${count }"/>
            <c:forEach var="vo" items="${list }">
                <tr>
                    <td class="text-center">${vo.no }</td>
                    <td>
                        <c:if test="${vo.group_tab==1 }">
                            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
                                <path d="M10.6569 5V16.3137H21.9706" stroke="#A3A3A3" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M19 21L24 16.5L19 12" stroke="#A3A3A3" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </c:if>
                        <a class="relative" href="../qna/qna_detail.do?no=${vo.no }"><span class="type">${vo.type }</span><span class="type2">${vo.type_detail }</span> ${vo.subject }
                         <c:if test="${vo.dbday==today }">
                             <sup class="newicon"></sup>
                         </c:if>
                        </a>
                    </td>
                    <td class="text-center">${vo.name }</td>
                    <td class="text-center">${vo.dbday }</td>
                    <td class="text-center">${vo.hit }</td>
                </tr>
            </c:forEach>
            </table>
            <div class="d-flex justify-content-center">
                <div>
                    <a href="../qna/qna_list.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-outline-info btn-sm">이전</a>
                    ${curpage } page / ${totalpage } pages
                    <a href="../qna/qna_list.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-outline-success btn-sm">다음</a>
                </div>
            </div>
            <c:set var="count" value="${count -1}"/>
        </div>
    </div>
</body>
</html>