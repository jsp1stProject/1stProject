<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-js"></script>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-3 py-3 px-0" style="position:relative">
				<div class="filter-container active">
					<div class="d-flex justify-content-between px-2">
						<button class="cpsbtn">필터</button>
						<button type="button" class="btn btn-light resetbtn">초기화</button>
					</div>
					<div class="filter-wrap" id="filter">						
						<div class="filter-item"> <!--checkbox 타입-->
						<form method=post action="#">
							<!-- 
								서울   1
								인천   2
								대전   3
								대구   4
								광주   5
								부산   6
								울산   7
								세종   8
								경기   31
								강원   32
								충북   33		
								충남   34
								경북   35		
								경남   36
								전북   37		
								전남   38
								제주   39							
							 -->
							<h6>지역별</h6>
							<div class="checkbtn-wrap" id="areacode">
								<input type="checkbox" name="ac" id="t3" value=1  onclick="acClick()">
								<label for="t3">서울</label>
								<input type="checkbox" name="ac" id="t4" value=2  onclick="acClick()">
								<label for="t4">인천</label>
								<input type="checkbox" name="ac" id="t5" value=3 onclick="acClick()">
								<label for="t5">대전</label>
								<input type="checkbox" name="ac" id="t6" value=4 onclick="acClick()">
								<label for="t6">대구</label>
							</div>
							<!-- 
							<h6>정렬</h6>
							<div class="checkbtn-wrap">
								<input type="checkbox" name="type" id="t7">
								<label for="t1">오름차순</label>
								<input type="checkbox" name="type" id="t8">
								<label for="t2">내림차순</label>
								<input type="checkbox" name="type" id="t9">
								<label for="t1">리뷰</label>
								<input type="checkbox" name="type" id="t10">
								<label for="t2">조회</label>
							</div>
							</div> -->
							</form>
						</div>
					</div>
				</div>

			</div>
	<section class="archive-area section_padding_80">
        <div class="container">
            <div class="row">
			<div class="col-9">
			  <c:forEach var="vo" items="${list }">
                <div class="col-9">
                    <div class="single-post wow fadeInUp" data-wow-delay="0.1s">
						<div class="post-thumb">
                          <a href="../sights/sights_detail.do?">
                          	<h4 class="post-headline">${vo.title }</h4>
                            <img src="${vo.first_image}" alt="">
                          </a>
                        </div>
			
			
					 </div>
				</div>
			</c:forEach>
                    <div class="pagination-area d-sm-flex mt-15">
                        <nav aria-label="#">
                            <ul class="pagination">
                               <c:if test="${startPage>1 }">
                                 <li class="page-item">
                                    <a class="page-link" href="../sights/sights_list.do?page=${startPage-1 }">이전 <i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
                                 </li>
                                </c:if>
                                
                                <c:forEach var="i" begin="${startPage }" end="${endPage }">
                                 <li class="page-item ${i==curpage?'active':'' }"><a class="page-link" href="../sights/sights.do?page=${i }">${i }</a></li>
                                </c:forEach>
                                
                                <c:if test="${endPage<totalpage }">
                                 <li class="page-item">
                                    <a class="page-link" href="../sights/sights_list.do?page=${endPage+1 }">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                 </li>
                                </c:if>
                            </ul>
                        </nav>
                        <div class="page-status">
                            <p>Page ${curpage } of ${totalpage } results</p>
                        </div>
                    </div>
                </div>
			
		</div>
		
	</div>
  </section>
  </div>
  </div>
</body>
</html>