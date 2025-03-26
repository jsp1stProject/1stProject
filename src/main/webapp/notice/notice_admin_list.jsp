<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$('#search').keydown(function(event) {
			if (event.key === "Enter") {
				event.preventDefault();
				$('#searchForm').submit();
			}
		});
	});
	
</script>
<style type="text/css">
.select-type {
	width: 81px;
	flex-grow: 0;
}
.d-flex {
    justify-content: center;
}
</style>
</head>
<body>
	<div class="container h-100">
		<div class="col-12">
			<div>
				<h2 style="margin: 50px 0 50px 0;">공지사항</h2>
				<hr class="text-muted">
			</div>
		</div>
		<div class="row">
			<div class="col-7">
				<a href="../notice/notice_admin_insert.do" class="btn btn-secondary">새글</a>
			</div>
			<div class="col-5" style="margin-bottom: 4px">
				<form method="post" action="../notice/notice_admin_list.do" id="searchForm">
				<div class="input-group mb-3">
					<select class="form-select select-type" id="searchType" name="searchType" aria-label="Default select example" style="flex-grow: 0; width: 81px;">
						<option value="일반" selected>일반</option>
						<option value="행사">행사</option>
						<option value="축제">축제</option>
						<option value="숙소">숙소</option>
					</select>
					<input type="text" id="search" name="search" style="margin-left: 10px; width: 75%;">
				</div>
				</form>
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
			<c:choose>
            <c:when test="${empty list}">
                <tr>
                    <td colspan="6" class="text-center">검색결과가 없습니다.</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="vo" items="${list}">
                    <tr>
                        <td width="9%" class="text-center">${vo.no}</td>
                        <td width="11%" class="text-center">${vo.type}</td>
                        <td width="45%"><a href="../notice/notice_admin_detail.do?no=${vo.no}">${vo.subject}</a></td>
                        <td width="10%" class="text-center">${vo.name}</td>
                        <td width="15%" class="text-center">${vo.dbday}</td>
                        <td width="10%" class="text-center">${vo.hit}</td>
                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>
			</tbody>
		</table>
		<div class="container d-flex">
   		<ul class="pagination">
        <!-- 이전 버튼 -->
        <c:if test="${startPage > 1}">
            <a class="bfarr" href="../notice/notice_admin_list.do?page=1">
                <div class="arr left" style="left:9px;"></div>
                <div class="arr left" style="left:16px;"></div>
            </a>
            <a class="bfarr" href="../notice/notice_admin_list.do?page=${startPage - 1 }">
                <div class="arr left"></div>
            </a>
        </c:if>

        <!-- 번호 버튼 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
            <a class="${i == curPage ? 'active' : ''}" href="../notice/notice_admin_list.do?page=${i }">${i}</a>
        </c:forEach>

        <!-- 다음 버튼 -->
        <c:if test="${endPage < totalPage}">
            <a class="afarr" href="../notice/notice_admin_list.do?page=${endPage + 1 }">
                <div class="arr right"></div>
            </a>
            <a class="afarr" href="../notice/notice_admin_list.do?page=${totalPage }">
                <div class="arr right" style="left: 9px;"></div>
                <div class="arr right" style="left: 16px;"></div>
            </a>
        </c:if>
    </ul>
</div>
	</div>
</body>
</html>