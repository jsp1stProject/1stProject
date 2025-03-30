<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
</head>
<body>
  <div class="container pt-5 pt-lg-3" style="margin: 0 auto;">
     <div class="row justify-content-center">
      <div class="col-lg-9 col-12" >
        <h3 class="pt-3 pt-lg-0 pb-3">QnA 내용보기</h3>
        <div class="container" style="margin: 0 auto;">
            <div class="row" style="width:800px; ">
            <form method="post" action="../qna/qna_insert_ok.do" enctype="multipart/form-data">
             <table class="table">
              
              <tr>
               <th class="texet-center" width=15%>이름</th>
               <td width=85%>
                ${vo.name }
               </td>
              </tr>
                          
              <tr>
               <th class="texet-center" width=15%>제목</th>
               <td width=85%>
                [${vo.type }][${vo.type_detail }] ${vo.subject }
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>이메일</th>
               <td width=85%>
                ${vo.email }
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>핸드폰번호</th>
               <td width=85%>
                ${vo.phone }
               </td>
              </tr>

               <tr>
               <th class="texet-center" width=15%>예약번호</th>
               <td width=85%>
                ${vo.reserve_no }
               </td>
              </tr>
              <tr>
               <th class="texet-center" width=15%>내용</th>
               <td width=85% colspan="4" style="text-align: left;"
                  valign="top" height="200"><pre style="white-space:pre-wrap;border:none;background-color: white">${vo.content }</pre>
    
               </td>
              </tr>
              
            
              
              <tr>
               <th class="texet-center" width=15%>첨부파일</th>
               <td width=85%>
                ${vo.filename }
               </td>
              </tr>
              
              
              <tr>
               <td colspan="2" class="text-center">
               <c:if test="${sessionScope.user_id!=null and sessionScope.user_id==vo.user_id}">
                <a href="../qna/qna_update.do?no=${vo.no }" class="btn btn-xs btn-success">수정</a>
                <a href="../qna/qna_delete.do?group_id=${vo.group_id }" class="btn btn-xs btn-danger">삭제</a>
                </c:if>
                <a href="../qna/qna_list.do" class="btn btn-xs btn-info">목록</a>
                </td>
              </tr>
              
             </table>
             </form>
        </div>
        
     </div>
     </div>
    </div>
</div>
</body>
</html>


<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>묻고답하기</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="breadcumb-nav">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><i class="fa fa-home" aria-hidden="true"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">chef-list Page</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ****** -->
    <section class="archive-area section_padding_80">
        <div class="container">
            <div class="row" style="width:800px; margin:0px auto">
             <table class="table">
               <tr>
                <th class="text-center table-danger" width=20%>번호</th>
                <td class="text-center" width=30%>${vo.no }</td>
                <th class="text-center table-danger" width=20%>작성일</th>
                <td class="text-center" width=30%>${vo.dbday }</td>
               </tr>
               <tr>
                <th class="text-center table-danger" width=20%>이름</th>
                <td class="text-center" width=30%>${vo.name }</td>
                <th class="text-center table-danger" width=20%>조회수</th>
                <td class="text-center" width=30%>${vo.hit }</td>
               </tr>
               <tr>
                <th class="text-center table-danger" width=20%>제목</th>
                <td colspan="3">${vo.subject }</td>
               </tr>
               <tr>
                <td colspan="4" class="text-left"
                  valign="top" height="200"><pre style="white-space:pre-wrap;border:none;background-color: white">${vo.content }</pre></td>
               </tr>
               <tr>
                <td colspan="4" class="text-right">
                 <c:if test="${sessionScope.id!=null and sessionScope.id=vo.id}">
                 <a href="../qna/qna_update.do?no=${vo.no }" class="btn btn-xs btn-success">수정</a>
                 <a href="../qna/qna_delete.do?group_id=${vo.group_id }" class="btn btn-xs btn-danger">삭제</a>
                 </c:if>
                 <a href="../qna/qna_list.do" class="btn btn-xs btn-info">목록</a>
                </td>
               </tr>
              </table>
           </div>
        </div>
    </section>  
</body>
</html> --%>