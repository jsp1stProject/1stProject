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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container d-flex justify-content-center">
		<table class="table mt-5">
			<tr>
				<th>예약번호</th>
				<th>예약자 성명</th>
				<th>객실 명</th>
				<th>가격</th>
				<th>예약 날짜</th>
				<th>입실 및 퇴실 날짜</th>
				<th>예약 상태</th>
				<th>관리</th>
			</tr>
			<c:choose>
			<c:when test="${empty list}">
				<h3 style="margin: 100px 0 100px 0;">현재 예약 대기 중인 예약이 없습니다.</h3>
			</c:when>
			<c:otherwise>
				<c:forEach var="vo" items="${list }">
				<tr>
					<td>${vo.reserve_id }</td>
					<td>${vo.guest_name }</td>
					<td>${vo.hrvo.roomtitle }</td>
					<td><fmt:formatNumber value="${vo.pay_amount }" pattern="#,###"/> 원</td>
					<td><fmt:formatDate value="${vo.reserve_date}" pattern="yyyy.MM.dd (E)" /></td>
					<td>
						<fmt:formatDate value="${vo.check_in_date}" pattern="yyyy.MM.dd (E)" /> ~ 
						<fmt:formatDate value="${vo.check_out_date}" pattern="yyyy.MM.dd (E)" />
					</td>
					<td class="status">
						<c:choose>
                            <c:when test="${fn:trim(vo.status) == 'O'}">예약 가능</c:when>
                            <c:when test="${fn:trim(vo.status) == 'R'}">예약 대기 중</c:when>
                            <c:when test="${fn:trim(vo.status) == 'C'}">예약 완료</c:when>
                            <c:when test="${fn:trim(vo.status) == 'X'}">예약 취소 대기</c:when>
                            <c:when test="${fn:trim(vo.status) == 'A'}">취소 완료</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
					</td>
					<td>
						<c:choose>
                            <c:when test="${fn:trim(vo.status) == 'O'}">예약가능</c:when>
                            <c:when test="${fn:trim(vo.status) == 'R'}">
                            	<form method="post" action="../reseravtion/reservation_approve.do" style="display:inline;">
                            		<input type="hidden" name="rsv-id" value="${vo.reserve_id}">
		                           	<button class="btn btn-primary" type="submit">승인</button>
                            	</form>
                            	<form method="post" action="../reservation/reseravtion_reject.do" style="display:inline;">
                            		<input type="hidden" name="rsv-id" value="${vo.reserve_id}">
		                           	<button class="btn btn-danger" type="submit">거절</button>
	                           	</form>
                            </c:when>
                            <c:when test="${fn:trim(vo.status) == 'C'}">예약 완료</c:when>
                            <c:when test="${fn:trim(vo.status) == 'X'}">
                            	<form action="../reservation/reservation_approve_cancel.do" style="display:inline;">
                            		<input type="hidden" name="rsv-id" value="${vo.reserve_id}">
                            		<button class="btn btn-primary" type="submit">승인</button>
                            	</form>
                            </c:when>
                            <c:when test="${fn:trim(vo.status) == 'A'}">취소 완료</c:when>
                            <c:otherwise>관리자 문의</c:otherwise>
                        </c:choose>
					</td>
				</tr>
			</c:forEach>
			</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>