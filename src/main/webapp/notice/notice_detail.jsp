<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</div>
</body>
</html>