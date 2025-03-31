<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.submit-btn-container {
    width: 100%;
    margin-top: 20px;
    text-align: right;
}
</style>
</head>
<body>
<div class="container">
	<div class="col-12">
		<div>
			<h2 style="margin: 50px 0 50px 0;">공지사항</h2>
		</div>
	</div>
	<table class="table">
		<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
		</colgroup>
		<tbody>
			<tr>
				<th>글 번호</th>
				<td>${vo.no }</td>
				<th>조회수</th>
				<td>${vo.hit }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.name }</td>
				<th>작성일</th>
				<td>${vo.dbday }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
				${vo.subject }
				</td>
			</tr>
			<tr>
				<td colspan="4" class="view_text">
				<pre style="white-space: normal;">${vo.content }</pre>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="submit-btn-container">
	<button class="btn btn-primary" onclick="history.back()">목록</button>
	<a href="../notice/notice_admin_update.do?no=${vo.no }"><button class="btn btn-primary" id="trans" style="margin-right: 0;">수정</button></a>
	<a href="../notice/notice_admin_delete.do?no=${vo.no }"><button class="btn btn-danger" style="margin-right: 0;">삭제</button></a>
	</div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
	    history.pushState(null, null, location.href);
	
	    $(window).on('popstate', function() {
	        location.reload();  // 페이지 새로고침
	    });
	});
</script>
</html>