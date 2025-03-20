<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
 <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Responsive Hover Table</h3>

                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input type="text" name="table_search" class="form-control float-right" placeholder="Search">

                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default">
                        <i class="fas fa-search"></i>
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>이름</th>
                      <th>작성일</th>
                      <th>상태</th>
                    </tr>
                  </thead>
                  <tbody>
		   <c:set var="count" value="${count }"/>  
                    <c:forEach var="vo" items="${list }">
                    <tr>
                      <td>${count }</td>
		      <td>${vo.subject }</td>
                      <td>${vo.name }</td>
                      <td>${vo.dbday }</td>
                      <td>
                       <c:if test="${vo.anok=='Y' }">
	                    <a href="#" class="btn btn-warning btn-sm">수정</a>
	                    <a href="../qna/qna_admin_delete.do?gi=${vo.group_id }" class="btn btn-danger btn-sm">삭제</a>
	                   </c:if>
	                   <c:if test="${vo.anok=='n' }">
	                    <a href="../qna/qna_admin_insert.do?gi=${vo.group_id }" class="btn btn-primary btn-sm">답변대기</a>
	                   </c:if>
	                  </td>
                    </tr>
                    <c:set var="count" value="${count-1 }"/>
                   </c:forEach>
                  </tbody>
                </table>
		<table class="table">
               <tr>
                
                <td class="text-right">
                 <a href="../qna/qna_admin_list.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-info btn-sm">이전</a>
                  ${curpage } page / ${totalpage } pages
                 <a href="../qna/qna_admin_list.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-info btn-sm">다음</a>
                </td>
               </tr>
             </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
        </div>
 

             <%-- <table class="table">
              <tr class="table-info">
                <th width=10% class="text-center">번호</th>
                <th width=40% class="text-center">제목</th>
                <th width=10% class="text-center">이름</th>
                <th width=15% class="text-center">작성일</th>
                <th width=15% class="text-center"></th>
              </tr>
              <c:set var="count" value="${count }"/>  
              <c:forEach var="vo" items="${list }">
                <tr>
                 <td width=10% class="text-center">${count }</td>
                 <td width=40%>
           
                  
                  ${vo.subject }
                 
                  
                 </td>
                 <td width=10% class="text-center">${vo.name }</td>
                 <td width=15% class="text-center">${vo.dbday }</td>
                 <td width=10% class="text-center">${vo.hit }</td>
                 <td width="15%" class="text-center">
                  <c:if test="${vo.anok=='Y' }">
                   <!-- <span class="btn btn-success btn-sm">답변완료</span> -->
                   <a href="../qna/qna_admin_update.do?no=${vo.no }" class="btn btn-warning btn-sm">수정</a>
                   <a href="../qna/qna_admin_delete.do?gi=${vo.group_id }" class="btn btn-warning btn-sm">삭제</a>
                  </c:if>
                  <c:if test="${vo.anok=='n' }">
                   <a href="../qna/qna_admin_insert.do?gi=${vo.group_id }" class="btn btn-danger btn-sm">답변대기</a>
                  </c:if>
                 </td>
               </tr>
               <c:set var="count" value="${count-1 }"/>
              </c:forEach>
             </table>
             <table class="table">
               <tr>
                
                <td class="text-right">
                 <a href="../qna/qna_list.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-info btn-sm">이전</a>
                  ${curpage } page / ${totalpage } pages
                 <a href="../qna/qna_list.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-success btn-sm">다음</a>
                </td>
               </tr>
             </table> --%>
          
</body>
</html>