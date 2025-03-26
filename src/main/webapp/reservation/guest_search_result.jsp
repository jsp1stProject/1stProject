<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container d-flex justify-content-center">
		<c:choose>
		<c:when test="${vo ne null  }">
		<table class="table mt-5" style="margin-bottom: 500px">
			<tr>
				<th>예약번호</th>
				<th>예약자 성명</th>
				<th>객실 명</th>
				<th>가격</th>
				<th>예약 날짜</th>
				<th>입실 및 퇴실 날짜</th>
				<th>예약 상태</th>
			</tr>
			<tr>
				<td>${vo.reserve_id }</td>
				<td>${vo.guest_name }</td>
				<td>${roomtitle }</td>
				<td><fmt:formatNumber value="${vo.pay_amount }" pattern="#,###"/> 원</td>
				<td><fmt:formatDate value="${vo.reserve_date}" pattern="yyyy.MM.dd (E)" /></td>
				<td>
					<fmt:formatDate value="${vo.check_in_date}" pattern="yyyy.MM.dd (E)" /> ~ 
					<fmt:formatDate value="${vo.check_out_date}" pattern="yyyy.MM.dd (E)" />
				</td>
				<td id="status"></td>
			</tr>
		</table>
		</c:when>
		<c:otherwise>
			<h3 style="margin: 100px 0 100px 0;">존재하지 않는 예약입니다.</h3>
		</c:otherwise>
		</c:choose>
	</div>
</body>
<script type="text/javascript">
	/*
		TO-DO 
		예약 취소 기능
		예약 페이지 유효성 검사
		비회원 조회 유효성 검사
		숙박 예약도 동일하게
	*/ 
	var status = '${vo.status}';
	console.log('status: ' + status);
	var statusText = '';
	switch(status.trim()) {
	    case 'O':
	        statusText = '예약가능';
	        break;
	    case 'R':
	        statusText = '예약 중';
	        break;
	    case 'C':
	        statusText = '예약 완료';
	        break;
	    case 'X':
	        statusText = '예약 취소';
	        break;
	    case 'A':
	        statusText = '취소 대기 중';
	        break;
	    default:
	        statusText = "관리자 문의";
	}
	
	$('#status').text(statusText);
</script>
</html>