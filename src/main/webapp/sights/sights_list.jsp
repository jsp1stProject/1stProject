<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
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
				<div class="filter-container">
					<div class="d-flex justify-content-between px-2">
						<button class="cpsbtn">필터</button>
						<button type="button" class="btn btn-light resetbtn" onclick="reset()">초기화</button>
					</div>
					<div class="filter-inner">
						<div class="filter-wrap" id="filter">
							<!-- range 가격대 -->
							<div class="filter-item"> <!--checkbox 타입-->
								<h6>관광지 유형</h6>
								<div class="checkbtn-wrap">
									<input type="checkbox" name="cat1" id="t1" value="자연">
									<label for="t1" data-id=${vo.cat1 }>자연</label>
									<input type="checkbox" name="cat1" id="t2" value="문화">
									<label for="t2" data-id=${vo.cat1 }>문화</label>
								</div>
							</div>
							<div class="filter-item"> <!--checkbox 타입-->
							<form method=post action="../sights/sights_list.do">
								<h6>지역</h6>
								<div class="checkbtn-wrap">
									<input type="checkbox" name="type" id="t1">
									<label for="t1">서울</label>
									<input type="checkbox" name="type" id="t2">
									<label for="t2">경기</label>
									<input type="checkbox" name="type" id="t3">
									<label for="t3">인천</label>
									<input type="checkbox" name="type" id="t4">
									<label for="t4">강원도</label>
									<input type="checkbox" name="type" id="t5">
									<label for="t5">충청도</label>
									<input type="checkbox" name="type" id="t6">
									<label for="t6">전라도</label>
									<input type="checkbox" name="type" id="t7">
									<label for="t7">경상도</label>
									<input type="checkbox" name="type" id="t8">
									<label for="t8">부산</label>
									<input type="checkbox" name="type" id="t9">
									<label for="t9">제주도</label>
								</div>
							</form>
							</div>
							<div class="filter-item">
								<button type="button" class="filterschbtn" onclick="filtersubmit();">검색</button>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="col-lg-9 px-0">
				<div class="container-xxl py-lg-3 pt-5 pb-3 px-0">
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
						<h4 class="search-title mb-3"><span>관광지</span>에 대한 총 <span>${list.size() }</span> 개의 검색 결과</h4>
						<ul class="content-ul event">
							<!-- ORDER BY DBMS_RANDOM.VALUE mapper listdata 에 안쪽 서브쿼리에 넣으면 데이터가 랜덤으로 바뀜 -->
							 <c:forEach var="vo" items="${list }">
							  <li>
							  	<a href="../sights/sights_detail.do?content_id=${vo.content_id }" class="d-flex">
							  	<div class="thumb-wrap" style="background-image:url(${vo.first_image})">
							  		
									<button type="button" class="bookmark-btn" name="bm-btn" data-id="${content_id}"></button>
								</div>
								<div class="d-flex flex-column flex-md-row right">
											<div class="title-wrap">
												<p class="cat">${vo.cat3 }<!--cat3으로 구분--></p>
												<p class="content-name">${vo.title }</p>
												<p class="location">${vo.addr1 }</p>
												<p class="score"id="randomScore"></p>
											</div>
											<!-- 관광지 가격은 나중에 <div class="price-wrap">
												<p class="price">ex.125,000원~</p>
											</div>-->
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
								<a href="../sights/sights_list.do?page=1" class="bfarr">
									<div class="arr left" style="left:9px;"></div>
									<div class="arr left" style="left:16px;"></div>
								</a>
								<a href="../sights/sights_list.do?page=${startPage-1 }" class="bfarr">
									<div class="arr left"></div>
								</a>
							</c:if>
							<c:forEach begin="${startPage }" end="${endPage }" var="i">
								<c:choose>
									<c:when test="${i eq curpage}">
										<a href="../sights/sights_list.do?page=${i }" class="active">${i }</a>
									</c:when>
									<c:otherwise>
										<a href="../sights/sights_list.do?page=${i }">${i }</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${endPage<totalpage }">
								<a href="../sights/sights_list.do?page=${endPage+1 }" class="afarr">
									<div class="arr right"></div>
								</a>
								<a href="../sights/sights_list.do?page=${totalpage }" class="afarr">
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
		<%--북마크 클릭 이벤트 --%>
		$('.bookmark-btn').on('click',function(e){
			e.preventDefault();
			$(this).toggleClass('on');
		});

		<%-- 필터창 on/off 이벤트 --%>
		$(document).on("click",".cpsbtn",function(){
			var con=$(this).closest('.filter-container')
			if(con.hasClass('active')){
				con.removeClass('active');
			}else{
				con.addClass('active');
			}
		});

		<%-- 필터 input range 라이브러리 --%>
		rangeSlider(document.querySelector('#range-slider'), {
			min: 0,
			max: 100000,
			step: 1000, //step size
			value: [0,100000], //initial values
			onInput: function(valueSet) {
				console.log(valueSet);
				rangeset(valueSet[0],valueSet[1]);
			},
		});
		function rangeset(min, max){
			$('input.start').val(min.toLocaleString('ko-KR')+'원');
			$('input.end').val(max.toLocaleString('ko-KR')+'원');
		}
		rangeset(0,100000);

		<%--필터 absolute 애니메이트--%>
		let floatPosition = parseInt($(".filter-container").css('top'));
		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";
			if(scrollTop + $(window).height()+300 < $(document).height()||$("body").hasClass('is')) {
				$(".filter-container").stop().animate({
					"top" : newPosition
				}, 50);
			}
		}).scroll();

		<%-- 필터창 스크롤 라이브러리 --%>
		$(function(){
			$('#filter').slimScroll({
				height: 'auto',
				railVisible: false,
				railColor: '#222',
				railOpacity: 0.3,
				wheelStep: 10,
				allowPageScroll: false,
				disableFadeOut: false
			})
		});
		
		// 랜덤 리뷰 나오게 해보기
		function getRandomScore() {
	        return (Math.random() * (5.0 - 2.0) + 2.0).toFixed(1); // 소수점 1자리까지
	    }

	    // 10~99 사이 랜덤 숫자(리뷰 수) 생성
	    function getRandomReviews() {
	        return Math.floor(Math.random() * (99 - 10 + 1)) + 10;
	    }

	    // 랜덤 점수 및 리뷰 수 표시
	    document.getElementById("randomScore").textContent = getRandomScore() + " (" + getRandomReviews() + ")";

	</script>
</body>
</html>