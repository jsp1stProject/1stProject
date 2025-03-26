<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <h3 class="pt-3 pt-lg-0 pb-3">QnA 작성하기</h3>
        <div class="container" style="margin: 0 auto;">
            <div class="row" style="width:800px; ">
            <form method="post" action="../qna/qna_insert_ok.do" enctype="multipart/form-data">
             <table class="table">
              
              <tr>
               <th class="texet-center" width=15%>이름</th>
               <td width=85%>
                <input type=text name=name id=name size=20 class="form-control-sm"required>
               </td>
              </tr>
                          
              <tr>
               <th class="texet-center" width=15%>제목</th>
               <td width=85%>
                <input type=text name=subject id=subject size=50 class="form-control-sm" required>
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>이메일</th>
               <td width=85%>
                <input type=text name=email id=email size=50 class="form-control-sm" required>
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>핸드폰번호</th>
               <td width=85%>
                <input type=text name=phone id=phone size=50 class="form-control-sm" required>
               </td>
              </tr>
              
               <tr>
               <th class="texet-center" width=15%>타입</th>
               <td width=85%>
               <select name='type' id='type'>
			    <option value='' selected>--선택--</option>
			    <option value='숙박'>숙박</option>
			    <option value='행사'>행사</option>
			    <option value='축제'>축제</option>
			    <option value='맛집'>맛집</option>
			    <option value='관광지'>관광지</option>
			   </select>
               </td>
              </tr>
              
               <tr>
               <th class="texet-center" width=15%>타입상세</th>
               <td width=85%>
                <select name='type_detail' id='type_detail'>
			    <option value='' selected>--선택--</option>
			    <option value='예약문의'>예약문의</option>
			    <option value='결제문의'>결제문의</option>
			    <option value='환불문의'>환불문의</option>
			    <option value='불편사항'>불편사항</option>
			   </select>
               </td>
              </tr>
              
               <tr>
               <th class="texet-center" width=15%>예약번호</th>
               <td width=85%>
                <input type=text name=reserve_no id=reserve_no size=50 class="form-control-sm" required>
               </td>
              </tr>
              <tr>
               <th class="texet-center" width=15%>내용</th>
               <td width=85%>
                <textarea rows="10" cols="52" name=content required></textarea>
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>비밀번호</th>
               <td width=85%>
                <input type="password" name=pwd id=pwde size=20 class="form-control-sm" required>
               </td>
              </tr>
              
              <tr>
               <th class="texet-center" width=15%>첨부파일</th>
               <td width=85%>
                <input type="file" name=filename id=filename size=30 class="form-control-sm" >
               </td>
              </tr>
              
              
              <tr>
               <td colspan="2" class="text-center">
                <input type="submit" value="질의" class="btn-outlint-primary btn-sm">
                <input type="button" value="취소" class="btn-outlint-danger btn-sm"
                 onclick="javascript:history.back()">
                >
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