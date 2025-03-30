<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
</head>
<body>
  <div class="container pt-5 pt-lg-3" style="margin: 0 auto;">
     <div class="row justify-content-center">
      <div class="col-lg-9 col-12" >
        <h3 class="pt-3 pt-lg-0 pb-3">QnA</h3>
	 <div class="container">
            <div class="row" style="width:800px; margin: 0 auto; ">
            <c:if test="${sessionScope.user_id!=null and sessionScope.admin=='N' }">
             <table class="table">
              <tr>
               <td>
                <a href="../qna/qna_insert.do" class="btn btn-outline-danger btn-sm">문의글 작성</a>
               </td>
              </tr>
             </table>
             </c:if>
             <table class="table">
              <tr>
               <th width=10% class="text-center">번호</th>
               <th width=45% class="text-center">제목</th>
               <th width=15% class="text-center">이름</th>
               <th width=20% class="text-center">작성일</th>
               <th width=10% class="text-center">조회수</th>
              </tr>
              <c:set var="count" value="${count }"/>
              <c:forEach var="vo" items="${list }">
              <tr>
               <td width=10% class="text-center">${vo.no }</td>
               <td width=45%>
                 <c:if test="${vo.group_tab==1 }">
                    &nbsp;&nbsp;<img src="../assets/img/re_icon.png">
                  </c:if>
                 <c:if test="${vo.group_tab==1 }">
                  &nbsp;&nbsp;<img src="../assets/img/re_icon.png">
                 </c:if>
                 <a href="../qna/qna_detail.do?no=${vo.no }">[${vo.type }][${vo.type_detail }] ${vo.subject }
                 </a>
                <c:if test="${vo.dbday==today }">
                 <sup><img src="../assets/img/new.gif"></sup>
                </c:if>
               </td>
               <td width=15% class="text-center">${vo.name }</td>
               <td width=20% class="text-center">${vo.dbday }</td>
               <td width=10% class="text-center">${vo.hit }</td>
              </tr>
              </c:forEach>
             </table>
             <table class="table">
              <tr>
           
               <td class="text-right">
                <a href="../qna/qna_list.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-outline-info btn-sm">이전</a>
                ${curpage } page / ${totalpage } pages
                <a href="../qna/qna_list.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-outline-success btn-sm">다음</a>
               </td>
              </tr>
              <c:set var="count" value="${count -1}"/>
             </table>
            </div>
        </div>
	</div>
	</div>
	</div>
    
</body>
</html>