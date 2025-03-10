<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-3 py-3 px-0">
				<div class="d-flex justify-content-between px-2">
					<button class="cpsbtn" data-bs-toggle="collapse" data-bs-target="#filter">필터</button>
					<button type="button" class="btn btn-light resetbtn">초기화</button>
				</div>
				<div class="filter-wrap collapse show" id="filter">
					<div class="d-flex justify-content-end">

					</div>
					<div class="filter-item"> <!-- range 타입 -->
						<h6>가격대</h6>
						<div id="range-slider"></div>
						<div class="d-flex justify-content-center range-value-wrap">
							<span class="start">0원</span><span class="ignr"> ~ </span><span class="end">100000</span>
						</div>
					</div>
					<div class="filter-item"> <!--checkbox 타입-->
						<h6>축제 유형</h6>
						<div class="checkbtn-wrap">
							<input type="checkbox" name="type" id="t1">
							<label for="t1">문화관광축제</label>
							<input type="checkbox" name="type" id="t2">
							<label for="t2">일반축제</label>
							<input type="checkbox" name="type" id="t3">
							<label for="t3">전통공연</label>
							<input type="checkbox" name="type" id="t4">
							<label for="t4">연극</label>
							<input type="checkbox" name="type" id="t5">
							<label for="t5">뮤지컬</label>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-9 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<form action="" method="post" name="page-search">
							<div class="sch_wrap page">
								<input type="text" name="key" placeholder="검색어를 입력하세요.">
								<input type="submit" value="검색">
							</div>
						</form>
					</div>
				</div>
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<h4 class="search-title mb-3"><span>제주도</span>에 대한 총 <span>1,324</span> 건의 검색 결과</h4>
						<ul class="content-ul event">
							<c:forEach begin="0" end="3">
								<li><!--호텔 li-->
									<a href="#" class="d-flex">
										<div class="thumb-wrap" style="background-image:url(../assets/img/hotel2.jpg)">
											<button type="button" class="bookmark-btn" name="bm-btn" data-id="${conid}"></button>
										</div>
										<div class="d-flex flex-column flex-md-row right">
											<div class="title-wrap">
												<p class="cat"><span class="hotel">관광호텔</span><!--cat3으로 구분--></p>
												<p class="content-name">강릉 퀴스테스파&풀빌라펜션</p>
												<p class="location">서울 성동구 뚝섬로</p>
												<p class="score">4.3(23)</p>
											</div>
											<div class="price-wrap">
												<p class="price">125,000원~</p>
											</div>
										</div>
									</a>
								</li>
								<li><!--행사/축제 li-->
									<a href="#" class="d-flex">
										<div class="thumb-wrap" style="background-image:url(../assets/img/hotel1.jpg)">
											<button type="button" class="bookmark-btn on"></button>
										</div>
										<div class="d-flex flex-column flex-md-row right">
											<div class="title-wrap">
												<p class="cat"><span class="event1">행사</span><!--<span class="event2">공연/축제</span>   cat2로 구분--></p>
												<p class="content-name">강원관광두레 팝업스토어</p>
												<p class="location">서울 성동구 뚝섬로</p>
												<p class="enddate">2025.12.13까지</p>
											</div>
											<div class="price-wrap">
												<p class="price">7,000원</p>
											</div>
										</div>
									</a>
								</li>
								<li><!--행사/축제 li-->
									<a href="#" class="d-flex">
										<div class="thumb-wrap" style="background-image:url(../assets/img/hotel5.jpg)">
											<button type="button" class="bookmark-btn on"></button>
										</div>
										<div class="d-flex flex-column flex-md-row right">
											<div class="title-wrap">
												<p class="cat"><span class="event2">공연/축제</span><!--   cat2로 구분--></p>
												<p class="content-name">강원관광두레 팝업스토어</p>
												<p class="location">서울 성동구 뚝섬로</p>
												<p class="enddate">2025.12.13까지</p>
											</div>
											<div class="price-wrap">
												<p class="price">7,000원</p>
											</div>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="container-xxl py-3 px-0">
					<div class="container d-flex">
						<ul class="pagination">
							<c:if test="${startPage>1 }">
								<a href="list.do?page=1" class="bfarr">
									<div class="arr left" style="left:9px;"></div>
									<div class="arr left" style="left:16px;"></div>
								</a>
								<a href="list.do?page=${startPage-1 }" class="bfarr">
									<div class="arr left"></div>
								</a>
							</c:if>
							<c:forEach begin="${startPage }" end="${endPage }" var="i">
								<c:choose>
									<c:when test="${i eq curpage}">
										<a href="list.do?page=${i }" class="active">${i }</a>
									</c:when>
									<c:otherwise>
										<a href="list.do?page=${i }">${i }</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${endPage<totalpage }">
								<a href="list.do?page=${endPage+1 }" class="afarr">
									<div class="arr right"></div>
								</a>
								<a href="list.do?page=${totalpage }" class="afarr">
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

<script type="text/javascript">
	$('.bookmark-btn').on('click',function(){
		$(this).toggleClass('on');
	});
	rangeSlider(document.querySelector('#range-slider'), {
		min: 0,
		max: 100000,
		step: 1000, //step size
		value: [0, 100000], //initial values
		onInput: function(valueSet) {
			console.log(valueSet);
			$('span.start').text(valueSet[0].toLocaleString('ko-KR')+'원');
			$('span.end').text(valueSet[1].toLocaleString('ko-KR')+'원');
		},
	});
</script>
</body>
</html>