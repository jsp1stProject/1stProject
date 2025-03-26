<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.form-floating > .form-control {
	min-width: 500px;
}
</style>
</head>
<body>
	<div class="container d-flex justify-content-center">
		<form class="form-floating" method="post" action="../reservation/guest_search_result.do">
			<h2 class="text-center mt-4">비회원 예약 조회</h2>
			<div class="d-flex flex-column mt-4">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="name" name="name" placeholder="성명을 입력해주세요.">
					<label for="name">예약자 성명</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="phone" name="phone" placeholder="hehe">
					<label for="phone">휴대폰 번호</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="rsv-id" name="rsv-id" placeholder="hehe">
					<label for="rsv-id">예약 번호</label>
				</div>
			</div>
			<div class="d-grid gap-2 mt-3">
				<button class="btn btn-primary" type="submit">조회하기</button>
			</div>
		</form>
	</div>
</body>
</html>