<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<
<style type="text/css">
/*pagination*/
.pagination{
    margin: 0 auto;
    font-size:0;
}

.pagination a{
    display: inline-block;
    position: relative;
    width: 36px;
    height: 36px;
    transition:.1s;
    line-height: 36px;
    text-align: center;
    vertical-align: bottom;
    font-size:16px;
    border: 1px solid #dddddd;
}
.pagination a:not(:last-child){
    border-right:none;
}
.pagination a:hover{
    background: #f1f1f1;
}
.pagination a.active{
    background: var(--primary);
    border-color: var(--primary);
    color:#ffffff;
    font-weight:600;
}
.pagination a.disabled{
    background:#dddddd!important;
    cursor:default;
}
.arr {
    position: absolute;
    width: 12px;
    height: 12px;
    top: 12px;
    left: 12px;
}
.arr:before {
    content:'';
    display:block;
    width:2px;
    height: 100%;
    background:#828282;
    position:absolute;
    top: 2px;
    left: 2px;
}
.arr:after{
    content:'';
    display:block;
    width: 100%;
    height:2px;
    background:#828282;
    position:absolute;
    top: 2px;
    left: 2px;
}
.arr.left{
    transform: rotate(-45deg);
}
.arr.right{
    transform: rotate(135deg);
}
.pagination span{
    display: inline-block;
    line-height: 32px;
    vertical-align: top;
    padding: 0 12px;
}
/*pagination end*/

</style>
 <script src="https://code.jquery.com/jquery.js"></script>
</head>
<body>
  <div class="container">
    <div class="row">
     <div class="card col-12">
  <!-- 검색부분 -->
<div class="card-header text-end" id="food_find">
    <h3 class="card-title"><b>맛집 게시물 관리</b></h3>
</div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                  <thead>
                  
                  <tr>
                    <th>No</th>
                    <th>맛집명</th>
                    <th>타입</th>
                    <th>조회수</th>
                    <th>좋아요수</th>
                    <th>버튼</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="f" items="${aList }">
                  <tr>
                    <td>${f.fno }</td>
                    <td><a href="../food/food_detail.do?fno=${f.fno }" class="text">${f.name }</a>      </td>
                    <td>${f.type }</td>
                    <td>${f.hit }</td>
                    <td>${f.likecount }</td>
                    <td>
                    <a href="../food/admin_update.do?fno=${f.fno }" class="btn btn-info btn-sm">수정</a>
                    <button class="btn btn-danger btn-sm btn-delete" data-fno="${f.fno}">삭제</button>
                    </td>
                  </tr>
                  </c:forEach>

                  </tbody>
                  <tfoot>
                  <tr>
                     <th>번호</th>
                    <th>맛집명</th>
                    <th>타입</th>
                    <th>조회수</th>
                    <th>좋아요수</th>
                    <td>
                     <a href="../food/food_insert.do" class="btn btn-primary btn-sm">게시물 추가</a>
                    </td>
                  </tr>
                  </tfoot>
                </table>
                <div class="container-xxl py-3 px-0">
					<div class="container d-flex">
						<ul class="pagination">
							<c:if test="${startPage>1 }">
								<a href="../food/admin_food_list.do?page=1" class="bfarr">
									<div class="arr left" style="left:9px;"></div>
									<div class="arr left" style="left:16px;"></div>
								</a>
								<a href="../food/admin_food_list.do?page=${startPage-1 }" class="bfarr">
									<div class="arr left"></div>
								</a>
							</c:if>
							<c:forEach begin="${startPage }" end="${endPage }" var="i">
								<c:choose>
									<c:when test="${i eq curpage}">
										<a href="../food/admin_food_list.do?page=${i }" class="active">${i }</a>
									</c:when>
									<c:otherwise>
										<a href="../food/admin_food_list.do?page=${i }">${i }</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${endPage<totalpage }">
								<a href="../food/admin_food_list.do?page=${endPage+1 }" class="afarr">
									<div class="arr right"></div>
								</a>
								<a href="../food/admin_food_list.do?page=${totalpage }" class="afarr">
									<div class="arr right" style="left:9px;"></div>
									<div class="arr right" style="left:16px;"></div>
								</a>
							</c:if>
						</ul>
					</div>
				</div>
              </div>
              
    </div>
    </div>
  </div>
<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>정말 삭제하시겠습니까?</p>
                <input type="hidden" id="deleteFno"> <!-- 삭제할 게시물 번호 저장 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">삭제</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 삭제 버튼 클릭 시 모달 표시
    $(document).on("click", ".btn-delete", function() {
        let fno = $(this).data("fno"); // 게시물 번호 가져오기
        $("#deleteFno").val(fno);
        $("#deleteModal").modal("show"); // 모달 열기
    });

    // 모달 내 삭제 버튼 클릭 시
    $("#confirmDelete").click(function() {
        let fno = $("#deleteFno").val();

        // AJAX 요청으로 게시물 삭제
        $.ajax({
            type: "POST",
            url: "../food/admin_delete.do",
            data: { fno: fno },
            success: function(result) {
                alert("삭제되었습니다.");
                location.reload(); // 페이지 새로고침
            },
            error: function() {
                alert("삭제 실패. 다시 시도하세요.");
            }
        });
    });
});
</script>
  
  
<!-- jQuery (Bootstrap보다 먼저 로드) -->


<!-- Bootstrap Bundle (JavaScript 포함) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- DataTables  & Plugins -->
<script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="../../plugins/jszip/jszip.min.js"></script>
<script src="../../plugins/pdfmake/pdfmake.min.js"></script>
<script src="../../plugins/pdfmake/vfs_fonts.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->
  x
  
</body>
</html>