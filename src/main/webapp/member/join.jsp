<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.center-wrap {
    margin: 0 auto;
    width: 100%;
    max-width: 600px;
    padding: 32px 24px;
}
.form_item {
    display: flex;
    align-items: center;
    position: relative;
    box-sizing: border-box;
    max-width: 100%;
    min-height: 50px;
    padding: 0 10px 0 45px;
}
.input {
    flex: 1 1 auto;
    box-sizing: border-box;
    width: 100%;
    font-size: 16px;
    line-height: 22px;
    color: #222;
    caret-color: #222
}
.card-body {
    flex: 1 1 auto;
    padding: 0;
    width: 554px;
}
.card {
	width: 420px;
}
.form-control {
	border-radius: 0;
	height: 3rem;
	width: 420px;
	paddig: 0.375rem 1rem;
}
.user {
	margin-bottom: 5rem;
}
.joinB{
	position: relative;
	width: 420px;
	height: 40px;
	margin-top: 40px;
}
.joinDiv {
	position: relative;
	margin: 0px auto;
}
input:focus, textarea:focus, select:focus {
    box-shadow: none !important;
    outline: none !important;
}
input {
    background-position: left 10px center; /* 이미지를 왼쪽 중앙에 배치 */
    background-repeat: no-repeat; /* 이미지 반복하지 않도록 설정 */
    background-size: 24px 24px; /* 이미지 크기 조정 */
    padding-left: 50px; /* 텍스트와 이미지 사이의 여백 */
}
input::placeholder {
    padding-left: 27px; /* placeholder와 이미지 사이의 간격 조정 */
}
</style>
</head>
<body>
	<div class="joinDiv">
		<div class="center-wrap">
			<div class="user user d-flex flex-column align-items-center">
		    	<input type="text" class="form-control form_list" id="id" placeholder="아이디" required style="border-radius: 10px 10px 0 0; background-image: url(../assets/img/id.png)">
		    	<input type="password" class="form-control form_list" id="pwd" placeholder="비밀번호" required>
		    	<input type="text" class="form-control form_list" id="name" placeholder="이름" required style="border-radius: 0 0 10px 10px">
    	 	</div>
    	 	<div class="user user d-flex flex-column align-items-center">
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="닉네임" required style="border-radius: 10px 10px 0 0;">
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="성별" required>
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="생일" required>
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="이메일" required>
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="주소" required>
		    	<input type="text" class="form-control" id="validationCustom01" placeholder="전화번호" required style="border-radius: 0 0 10px 10px">
	    	</div>
	    	<div class="user user d-flex flex-column align-items-center">
	    		<button class="btn btn-primary joinB" type="submit">회원가입</button>
	    	</div>
		</div>
	</div>
</body>
</html>