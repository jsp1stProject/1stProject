<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function changeButtonText(element) {
  var selectedText = element.textContent;
  document.getElementById("dropdownButton").textContent = selectedText;
}
</script>
<style type="text/css">
</style>
</head>
<body>
	<div class="container h-100">
		<div class="col-12">
			<div>
				<h2 style="margin: 50px 0 50px 0;">공지사항</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-7">
				<a href="../notice/notice_admin_insert.do" class="btn btn-secondary">새글</a>
			</div>
			<div class="col-5" style="margin-bottom: 4px">
			<div class="input-group mb-3">
			  <input type="text" class="form-control" aria-label="Text input with dropdown button" style="padding: 4px; text-align: right;">
			  <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false" id="dropdownButton">분류</button>
			  <ul class="dropdown-menu dropdown-menu-end">
			    <li><a class="dropdown-item" onclick="changeButtonText(this)">행사</a></li>
			    <li><a class="dropdown-item" onclick="changeButtonText(this)">축제</a></li>
			    <li><a class="dropdown-item" onclick="changeButtonText(this)">숙소</a></li>
			  </ul>
			</div>
				<!-- 
				<select class="form-select" aria-label="Default select example" style="width: 79px">
				  <option selected>일반</option>
				  <option value="1">행사</option>
				  <option value="2">숙소</option>
				  <option value="3">축제</option>
				</select>
				 -->
			</div>
		</div>
		<table class="table table-hover">
			<thead class="table-light" style="border-top: 1px solid black;">
			<tr>
				<th width="9%" class="text-center">번호</th>
				<th width="11%" class="text-center">분류</th>
	 			<th width="45%" class="text-center">제목</th>
	 			<th width="10%" class="text-center">이름</th>
	 			<th width="15%" class="text-center">작성일</th>
	 			<th width="10%" class="text-center">조회수</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td width="9%" class="text-center">1</td>
				<td width="11%" class="text-center">행사</td>
				<td width="45%"><a href="#">2025년 KO-PICK 쇼케이스: 칸 프로듀서스 네트워크 참가 프로듀서 모집 </a></td>
				<td width="10%" class="text-center">관리자</td>
				<td width="15%" class="text-center">2025.03.08</td>
				<td width="10%" class="text-center">1</td>
			</tr>
			<tr>
				<td width="9%" class="text-center">2</td>
				<td width="11%" class="text-center">숙소</td>
				<td width="45%">2025년 KO-PICK 쇼케이스: 홍콩 필마트 프로듀서스 네트워킹 프로그램 참가 프로듀서 선정 결과 공고</td>
				<td width="10%" class="text-center">관리자</td>
				<td width="15%" class="text-center">2025.03.08</td>
				<td width="10%" class="text-center">1</td>
			</tr>
			<tr>
				<td width="9%" class="text-center">3</td>
				<td width="11%" class="text-center">축제</td>
				<td width="45%">2025년 전기직(일반계약직) 공개채용 공고  </td>
				<td width="10%" class="text-center">관리자</td>
				<td width="15%" class="text-center">2025.03.08</td>
				<td width="10%" class="text-center">1</td>
			</tr>
			</tbody>
		</table>
	</div>
</body>
</html>