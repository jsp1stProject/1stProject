<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
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

window.onpageshow = function(event){   // onpageshow는 page 호출되면 캐시든 아니든 무조건 호출된다.
    if (event.persisted || (window.performance && window.performance.navigation.type == 2)){
        // 그외 브라우저(크롬 등)에서는 || 뒤에 있는 조건으로 뒤로가기인지 체크가 가능하다
        window.location.reload();
    }
};

	$(function() {
		let type = $('.dropdownButton').val();
		console.log('type:' + type);
	});
	function search(title, type) {
		let subject = $('#subject').val();
		$.ajax({
			type: 'post',
			url: '../notice/notice_admin_list.do',
			data: {
				'subject': subject,
				'type': type
			}
		});		
	}

</script>
<style type="text/css">
.select-type {
	width: 81px;
	flex-grow: 0;
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
				<div class="input-group mb-3">
					<select class="form-select select-type" aria-label="Default select example" style="flex-grow: 0; width: 81px;">
						<option selected>일반</option>
						<option value="1">행사</option>
						<option value="2">축제</option>
						<option value="3">숙소</option>
					</select>
					<input type="text" style="margin-left: 10px; width: 75%;">
				</div>
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
			<c:forEach var="vo" items="${list }">
			<tr>
				<td width="9%" class="text-center">${vo.no }</td>
				<td width="11%" class="text-center">${vo.type }</td>
				<td width="45%"><a href="../notice/notice_detail.do?no=${vo.no }">${vo.subject }</a></td>
				<td width="10%" class="text-center">${vo.name}</td>
				<td width="15%" class="text-center">${vo.dbday }</td>
				<td width="10%" class="text-center">${vo.hit }</td>
			</tr>
			</c:forEach>
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