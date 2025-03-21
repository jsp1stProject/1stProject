<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
<style type="text/css">
.hotel{
	overflow: hidden;
	text-overflow: ellipsis;
}
a:hover{
	cursor: pointer;
}
.price {
    white-space: nowrap;
}
</style>
<script type="text/javascript">
/*
 	TO-DO
 	1. 페이지 변경 시 해당 필터 적용된 목록 출력 -> O
 		- 페이지 변경 함수 매개변수 수정
 	2. 주소 맨 앞 주소만 잘라 적용 -> O
 		- DB 에서 SUBSTR
 	3. 필터 중복 적용 동적 쿼리 수정 -> O
 		- mapper 수정
 	4. 맨 뒤 또는 맨 앞으로 가기 오류 수정 -> O (- CEIL / 15.0 추가하지 않았음)
 	5. 검색 창에서 호텔 이름으로 검색 -> O
 		- model 값 전송
	6. 검색 결과 text 출력 -> O
	7. 가격 출력 -> O
	8. 검색 결과 존재하지 않을 시 오류 수정 -> O
		- count(*) 값이 0이 나오면 1로 대체
	
 		
 */
	
	function commons(page, title, cat3, locations, min, max) {
 		/*
		console.log('commons 호출');
	    console.log('page:', page);
	    console.log('title:', title);
	    console.log('cat3:', cat3);
	    console.log('locations:', locations);
	    */
		$.ajax({
			type: 'post',
			url: '../hotel/hotel_list_ajax.do',
			data: {'title': title, 
				   'cat3': cat3,
				   'locations': locations,
				   'page': page,
				   'min': min,
				   'max': max
		    },
		    traditional: true,
			success: function(result) {
				//console.log(result);
				if (result.trim() === '') {
		            console.error('response NULL 임');
		        }
				let json = JSON.parse(result);
				console.log(json);
				jsonView(json);
				window.scrollTo({ top: 0, behavior: 'smooth' });
			},
			error: function(xhr, status, error) {
		        console.error('AJAX request failed:', status, error);
		    }
		});
	}
	function prev(page) {
		commons(page, title, cat3, locations);
	}
	function next(page) {
		commons(page, title, cat3, locations);
	}
	function pageChange(page) {
		commons(page, title, cat3, locations);
	}
	function jsonView(json) {
		let html = '';
		let htmlPage = '';
		
		try {
			
			json.map(function(hotel) {
				/*
				for (let i = 0; i < json.length; i++) {
				    let hotel = json[i];
				    
				    if (hotel && hotel.cvo) {
				        console.log("Content ID:", hotel.cvo.content_id);
				        console.log("Title:", hotel.cvo.title);
				        console.log("Addr1:", hotel.cvo.addr1);
				        console.log("First Image:", hotel.cvo.first_image);
				        console.log("Cat3:", hotel.cvo.cat3);
				    } else {
				        console.log("hotel.cvo is undefined for hotel at index " + i);
				    }
				}
				*/
				// 숙소 반복 출력
			   html += '<li>'
			        + '<a href="../hotel/hotel_detail.do?content_id=' + hotel.content_id + '" class="d-flex">'
			        + '<div class="thumb-wrap" style="background-image:url(' + hotel.first_image + ')">'
			        + '<button type="button" class="bookmark-btn" name="bm-btn" data-id=""></button>'
			        + '</div>'
			        + '<div class="d-flex flex-column flex-md-row right">'
			        + '<div class="title-wrap">'
			        + '<p class="cat"><span class="hotel">' + hotel.cat3 + '</span><!--cat3으로 구분--></p>'
			        + '<p class="content-name">' + hotel.title + '</p>'
			        + '<p class="location">' + hotel.addr1 + '</p>'
			        + '<p class="subfacility">';
			        if (hotel.subfacility !== 'N/A') {
			        	html += hotel.subfacility;
					} else {
						html += '';
					}
			   html += '</p>'
			        + '</div>'
			        + '<div class="price-wrap">'
			        + '<p class="price">' 
			        if (hotel.offseason_minfee1 !== 0) {
			        	html += hotel.offseason_minfee1.toLocaleString('ko-KR') + '원'; 
					} else {
						html += '해당 업소 문의';
					}
			        + '</p>' 
			        + '</div>'
			        + '</div>'
			        + '</a>'
			        + '</li>';
			})
			
			//console.log('jsonStartPage:' + json[0].startPage);
	        let startPage = json[0].startPage;
	        let endPage = json[0].endPage;
	        let curPage = json[0].curPage;
	        let totalPage = json[0].totalPage;	 
	        
	        /*
	        console.log('startPage:' + startPage);
	        console.log('endPage:' + endPage);
	        console.log('curPage:' + curPage);
	        console.log('totalPage:' + totalPage);
	        */
	        
			htmlPage += '<div class="container d-flex">'
			     	 + '<ul class="pagination">';
			// 이전 버튼
		    if (startPage > 1) {
		    	htmlPage += '<a class="bfarr" onclick="prev(' + 1 + ')">' // TO-DO onclick 추가
				    	 + '<div class="arr left" style="left:9px;"></div>'
				    	 + '<div class="arr left" style="left:16px;"></div>'
				    	 + '</a>'
				    	 + '<a class="bfarr" onclick="prev(' + (startPage - 1) + ')">'
				    	 + '<div class="arr left"></div>'
				    	 + '</a>';
			}
			// 번호 버튼
		    for(let i = startPage; i <= endPage; i++) {
		    	htmlPage += '<a class="' + (i === curPage ? 'active' : '') + '" onclick="pageChange(' + i + ')">' + i + '</a>';
		    }
			// 다음 버튼
		    if (endPage < totalPage) {
		        htmlPage += '<a class="afarr" onclick="next(' + (endPage + 1) + ')">' // 10 페이지 다음
		            + '<div class="arr right"></div>'
		            + '</a>'
		            + '<a class="afarr" onclick="next(' + totalPage + ')">' // 맨 끝 페이지
		            + '<div class="arr right" style="left: 9px;"></div>'
		            + '<div class="arr right" style="left: 16px;"></div>'
		            + '</a>';
		    }
		    htmlPage += '</ul></div>';
		    $('#view').html(html);
		    $('#viewPage').html(htmlPage);
		    //console.log('TC: ' + json[0].totalCount);
		    //console.log('TC1: ' + totalCount);
		    $('#totalCount').html(json[0].totalCount);
		} catch(error) {
			//console.log('검색 결과 존재하지 않음');
			$('#view').html('요청하신 검색 결과가 존재하지 않습니다.');
			$('#viewPage').html('');
			$('#totalCount').html('0');
		}
	}
</script>
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
						<div class="filter-item col-lg-12 col-md-4 col-sm-12"> <!-- range 타입 -->
							<h6>가격대</h6>
							<div id="range-slider"></div>
							<div class="d-flex justify-content-center range-value-wrap">
								<input type="text" class="start" id="start" disabled value="0"><span class="ignr"> ~ </span><input type="text" class="end" id="end" disabled value="100000">
							</div>
						</div>
					<div class="filter-item"> <!--checkbox 타입-->
						<h6>숙소 유형</h6>
						<div class="checkbtn-wrap">
							<input type="checkbox" name="cat3" id="t1" value="관광호텔">
							<label for="t1">관광호텔</label>
							<input type="checkbox" name="cat3" id="t2" value="펜션">
							<label for="t2">펜션</label>
							<input type="checkbox" name="cat3" id="t3" value="모텔">
							<label for="t3">모텔</label>
							<input type="checkbox" name="cat3" id="t4" value="민박">
							<label for="t4">민박</label>
							<input type="checkbox" name="cat3" id="t5" value="홈스테이">
							<label for="t5">홈스테이</label>
							<input type="checkbox" name="cat3" id="t6" value="게스트하우스">
							<label for="t6">게스트하우스</label>
						</div>
					</div>
					<div class="filter-tiem">
						<h6>#지역</h6>
						<div class="checkbtn-wrap">
							<input type="checkbox" name="location1" id="l1" value="서울">
						    <label for="l1">서울</label>
						    <input type="checkbox" name="location1" id="l2" value="인천">
						    <label for="l2">인천</label>
						    <input type="checkbox" name="location1" id="l3" value="대전">
						    <label for="l3">대전</label>
						    <input type="checkbox" name="location1" id="l4" value="대구">
						    <label for="l4">대구</label>
						    <input type="checkbox" name="location1" id="l5" value="광주">
						    <label for="l5">광주</label>
						    <input type="checkbox" name="location1" id="l6" value="부산">
						    <label for="l6">부산</label>
						    <input type="checkbox" name="location1" id="l7" value="울산">
						    <label for="l7">울산</label>
						    <input type="checkbox" name="location1" id="l8" value="세종">
						    <label for="l8">세종</label>
						    <input type="checkbox" name="location1" id="l31" value="경기">
						    <label for="l31">경기</label>
						    <input type="checkbox" name="location1" id="l32" value="강원">
						    <label for="l32">강원</label>
						    <input type="checkbox" name="location1" id="l33" value="충북">
						    <label for="l33">충북</label>
						    <input type="checkbox" name="location1" id="l34" value="충남">
						    <label for="l34">충남</label>
						    <input type="checkbox" name="location1" id="l35" value="경북">
						    <label for="l35">경북</label>
						    <input type="checkbox" name="location1" id="l36" value="경남">
						    <label for="l36">경남</label>
						    <input type="checkbox" name="location1" id="l37" value="전북">
						    <label for="l37">전북</label>
						    <input type="checkbox" name="location1" id="l38" value="전남">
						    <label for="l38">전남</label>
						    <input type="checkbox" name="location1" id="l39" value="제주">
						    <label for="l39">제주</label>
						</div>
					</div>
				</div>
			</div>
			</div>
			<div class="col-md-9 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<!-- <form action="" method="post" name="page-search"> -->
							<div class="sch_wrap page">
								<input type="text" name="key" id="title" placeholder="검색어를 입력하세요.">
								<input type="submit" value="검색">
							</div>
						 <!-- </form> -->
					</div>
				</div>
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<h4 class="search-title mb-3">총 <span id="totalCount"></span> 건의 검색 결과</h4>
						<ul class="content-ul event" id="view">
							<!-- 숙소 반복 -->
								
								
							<!-- 숙소 반복 끝 -->
						</ul>
					</div>
				</div>
				<div class="container-xxl py-3 px-0" id="viewPage">
					<!-- 페이지 -->
					
					<!-- 페이지 -->
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	let listend=false;
	$('.bookmark-btn').on('click',function(e){
		e.preventDefault();
		$(this).toggleClass('on');
	});

	$(document).on("click",".cpsbtn",function(){
		var con=$(this).closest('.filter-container')
		if(con.hasClass('active')){
			con.removeClass('active');
			$('.slimScrollDiv').fadeOut(300);
		}else{
			con.addClass('active');
			$('.slimScrollDiv').fadeIn(300);
		}
	});
	rangeSlider(document.querySelector('#range-slider'), {
		min: 0,
		max: 100000,
		step: 1000, //step size
		value: [0,100000], //initial values
		onInput: function(valueSet) {
			//console.log(valueSet);
			rangeset(valueSet[0],valueSet[1]);
		},
	});
	
	function rangeset(min, max){
		$('input.start').val(min.toLocaleString('ko-KR')+'원');
		$('input.end').val(max.toLocaleString('ko-KR')+'원');
	}
	
	//rangeset(0,100000);
	
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
	
	
	
	
	// ==========================================================
	let cat3 = [];
	let locations = [];
	//let title = $('#title').val() === '' || $('#title').val() === null ? '서울' : $('#title').val();
	let title = '';
	
	
	/** 검색 필터 */
	function updateFilters() {
		cat3 = [];
		locations = [];
		let title = $('#title').val();
		
		$('input[name="cat3"]:checked').each(function() {
			cat3.push($(this).val());
		});
		
		$('input[name="location1"]:checked').each(function() {
			locations.push($(this).val());
		});
		
		let min = $('#start').val();
		let max = $('#end').val();
		
		//console.log('cat3:', cat3);
		//console.log('locations:', locations);
		
		commons(1, title, cat3, locations, min, max);
	}
	
	$('input[name="cat3"]').on('change', function() {
		updateFilters();
	});
	$('input[name="location1"]').on('change', function() {
		updateFilters();
	});
	$(document).on('click', '#filter input, #range-slider', function() {
		let min = $('#start').val();
		let max = $('#end').val();
		console.log('min: ' + min);
		console.log('max: ' + max);
		updateFilters();
	});
	
	/** 숙소 이름 검색 */
	$(function() {
		console.log("title: " + title);
		commons(1, title);
		$('#title').keydown(function(e) {
			if (e.keyCode === 13) {
				title = $('#title').val();
				commons(1, title, cat3, locations);
			}
		});
	})
</script>
</body>
</html>