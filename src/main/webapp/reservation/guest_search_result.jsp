<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> 
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
				<td id="status">
				<c:choose>
					<c:when test="${fn:trim(vo.status) eq 'O'}">예약 승인 거절</c:when>
			    	<c:when test="${fn:trim(vo.status) eq 'C'}">예약 완료</c:when>
			   		<c:when test="${fn:trim(vo.status) eq 'X'}">예약 취소 대기중</c:when>
			   	 	<c:when test="${fn:trim(vo.status) eq 'A'}">취소 완료</c:when>
					<c:when test="${fn:trim(vo.status) eq 'R'}">
						예약 대기중
						<form action="../reservation/reservation_cancel.do" method="post">
							<input type="hidden" name="rsv-id" value="${vo.reserve_id}"/>
							<button type="submit" class="btn btn-danger">예약 취소</button>
						</form>
					</c:when>
					<c:otherwise>알 수 없는 상태</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</table>
		</c:when>
		<c:otherwise>
			<h3 style="margin: 100px 0 100px 0;">예약 된 숙소가 없습니다.</h3>
		</c:otherwise>
		</c:choose>
	</div>
</body>
<script type="text/javascript">
	/*
		TO-DO 
		숙박 예약도 동일하게
		쿠폰
		이메일 인증
	*/ 
	var status = '${vo.status}';
	console.log('status: ' + status);
	var statusText = '';
	switch(status.trim()) {
	    case 'O':
	        statusText = '예약 승인 거절';
	        $('#status').text(statusText);
	        break;
	    case 'C':
	        statusText = '예약 완료';
	        $('#status').text(statusText);
	        break;
	    case 'X':
	        statusText = '예약 취소 대기중';
	        $('#status').text(statusText);
	        break;
	    case 'A':
	        statusText = '취소 완료';
	        $('#status').text(statusText);
	        break;
	}
	
	
</script>
</html>