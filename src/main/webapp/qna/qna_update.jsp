<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
 <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('#updateBtn').click(function(){
		let no=$('#no').val()
		// 데이터 전송 (수정 요청)
		$.ajax({
			type:'post',
			url:'../qna/qna_update_ok.do',
			data:$('#frm').serialize(),
			success:function(result)
			{
				location.href="../qna/qna_detail.do?no="+no
			},
			error:function(err)
			{
				alert(err)
			}
		})
	})
})
</script>
</head>
<body>
  <div class="container pt-5 pt-lg-3" style="margin: 0 auto;">
     <div class="row justify-content-center">
      <div class="col-lg-9 col-12" >
        <h3 class="pt-3 pt-lg-0 pb-3">QnA 수정하기</h3>
        <div class="container" style="margin: 0 auto;">
            <div class="row" style="width:800px; ">
            <form method="get" id="frm" enctype="multipart/form-data">
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
               <input type=text name=subject id=subject size=50
                  class="form-control-sm" required value="${vo.subject }">
                 <input type=hidden name=no value="${vo.no }" id="no">
                 <%-- DML (INSERT,UPDATE,DELETE)  --%>
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
                  valign="top" height="200">
               <textarea rows="10" cols="52" name=content required>${vo.content }</textarea>
               </td>
              </tr>

              <tr>
               <td colspan="2" class="text-center">
                <input type=button value="수정" class="btn-outline-primary btn-sm"  id="updateBtn">
                <input type=button value="취소" class="btn-outline-danger btn-sm" onclick="javascript:history.back()">
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
