<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../assets/css/bootstrapEdit.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">

$(function(){
	$('#canBtn').click(function(){
		parent.Shadowbox.close()
	})
	$('#logBtn').click(function(){
		let user_id=$('#user_id').val()
		if(user_id.trim()===""){
			$('#user_id').focus()
			return
		}
		
		let pwd=$('#pwd').val()
		if(pwd.trim()===""){
			$('#pwd').focus()
			return
		}
		
		$.ajax({
			type:'post',
			url:'../member/login_ok.do',
			data:{"user_id":user_id,"pwd":pwd},
			success:function(result){
				//alert(result)
				// NOID , NOPWD , OK   3중 하나 받아서옴
				if(result==='NOID'){
					alert("아이디가 존재하지 않습니다")
					$('#user_id').val("")
					$('#pwd').val("")
					$('#user_id').focus()
				}	
				
				else if(result==='NOPWD'){	
					alert("비밀번호가 틀립니다")
					$('#pwd').val("")
					$('#pwd').focus()
				}
				
				else{
					// 456
					//history.back();
					//parent.location.href="../main/main.do"
					parent.location.reload();
					parent.Shadowbox.close()
					//window.location.reload()
					alert('로그인되었습니다')
				}
				
				
			}
		})
	});
	
});
function join () {
	
	parent.location.href = '../member/join.do';
}
</script>
</head>
<body>
  <div class="container" style="margin-top: 30px">
   <div class="row" style="width:300px">
    <table class="table">
    <tr>
    <td>
        <h1 class="m-0 home" style="color: black;">Festeller</h1>
    </td>
	</tr>
     <tr>
      <th width=20%>ID</th>
      <td width=80%>
        <input type=text id="user_id" size=15 class="form-control-sm">
      </td>
     </tr>
     <tr>
      <th width=20%>PW</th>
      <td width=80%>
        <input type=password id="pwd" size=15 class="form-control-sm">
      </td>
     </tr>
     <tr>
      <td colspan="2" class="text-center">
       <input type=button id="logBtn" class="btn-sm btn-success" value="로그인">
       <input type=button id="canBtn" class="btn-sm btn-danger" value="취소">
      </td>
     </tr>
     <tr>
      <td colspan="3" class="text-center">
       <input type=button id="idSchBtn" class="btn-sm btn-primary" value="아이디찾기">
       <input type=button id="pwSchBtn" class="btn-sm btn-primary" value="비밀번호찾기">
       <input type=button id="joinBtn" class="btn-sm btn-warning" value="회원가입" onclick="join()">
      </td>
     </tr>
     
    </table>
   </div>
  </div>
</body>
</html>