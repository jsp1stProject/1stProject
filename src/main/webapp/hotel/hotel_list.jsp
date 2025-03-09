<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
<style type="text/css">
.hotel{
	overflow: hidden;
	text-overflow: ellipsis;
}
a:hover{
	cursor: pointer;
}
</style>
<script type="text/javascript">
	
	function commons(page) {
		let search = $('#search').val();
		$.ajax({
			type: 'post',
			url: '../hotel/hotel_list_ajax.do',
			data: {'search': search, 'page': page},
			success: function(result) {
				//console.log(result);
				if (result.trim() === '') {
		            console.error('response NULL 임');
		        }
				let json = JSON.parse(result);
				console.log(json);
				jsonView(json);
				window.scrollTo({ top: 200, behavior: 'smooth' });
			},
			error: function(xhr, status, error) {
		        console.error('AJAX request failed:', status, error);
		    }
		});
	}
	function prev(page) {
		commons(page);
	}
	function next(page) {
		commons(page);
	}
	function pageChange(page) {
		commons(page);
	}
	function jsonView(json) {
		let html = '';
		let htmlPage = '';
		
		json.map(function(hotel) {
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
		        + '<p class="score">4.3(23)</p>'
		        + '</div>'
		        + '<div class="price-wrap">'
		        + '<p class="price">125,000원~</p>'
		        + '</div>'
		        + '</div>'
		        + '</a>'
		        + '</li>';
		})
		
        let startPage = json[0].startPage;
        let endPage = json[0].endPage;
        let curPage = json[0].curPage;
        let totalPage = json[0].totalPage;	 
        
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
	        htmlPage += '<a class="afarr" onclick="next(' + (endPage + 1) + ')">'
	            + '<div class="arr right"></div>'
	            + '</a>'
	            + '<a class="afarr" onclick="next(' + totalPage + ')">'
	            + '<div class="arr right" style="left: 9px;"></div>'
	            + '<div class="arr right" style="left: 16px;"></div>'
	            + '</a>';
	    }

	    htmlPage += '</ul></div>';
	    
	    $('#view').html(html);
	    $('#viewPage').html(htmlPage);
			    
		
	}
	function location() {
		/*
			TO-DO
			지역 case 구분
		*/
	}
	/*
		TO-DO
		ajax JOIN 
	*/
</script>
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
						<h6>숙소 유형</h6>
						<div class="checkbtn-wrap">
							<input type="checkbox" name="type" id="t1">
							<label for="t1">관광호텔</label>
							<input type="checkbox" name="type" id="t2">
							<label for="t2">펜션</label>
							<input type="checkbox" name="type" id="t3">
							<label for="t3">모텔</label>
							<input type="checkbox" name="type" id="t4">
							<label for="t4">민박</label>
							<input type="checkbox" name="type" id="t5">
							<label for="t5">홈스테이</label>
							<input type="checkbox" name="type" id="t6">
							<label for="t6">게스트하우스</label>
						</div>
					</div>
					<div class="filter-tiem">
						<h6>#지역</h6>
						<div class="checkbtn-wrap">
							<input type="checkbox" name="type" id="l1">
							<label for="l1">서울</label>
							<input type="checkbox" name="type" id="l2">
							<label for="l2">인천</label>
							<input type="checkbox" name="type" id="l3">
							<label for="l3">대전</label>
							<input type="checkbox" name="type" id="l3">
							<label for="l4">대구</label>
							<input type="checkbox" name="type" id="l4">
							<label for="l5">광주</label>
							<input type="checkbox" name="type" id="l5">
							<label for="l6">부산</label>
							<input type="checkbox" name="type" id="l6">
							<label for="l7">울산</label>
							<input type="checkbox" name="type" id="l7">
							<label for="l8">세종</label>
							<input type="checkbox" name="type" id="l8">
							<label for="l31">경기</label>
							<input type="checkbox" name="type" id="l31">
							<label for="l32">강원</label>
							<input type="checkbox" name="type" id="l32">
							<label for="l33">충북</label>
							<input type="checkbox" name="type" id="l33">
							<label for="l34">충남</label>
							<input type="checkbox" name="type" id="l34">
							<label for="l35">경북</label>
							<input type="checkbox" name="type" id="l35">
							<label for="l36">경남</label>
							<input type="checkbox" name="type" id="l37">
							<label for="l37">전북</label>
							<input type="checkbox" name="type" id="l38">
							<label for="l38">전남</label>
							<input type="checkbox" name="type" id="l39">
							<label for="l39">제주</label>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-9 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<form action="" method="post" name="page-search">
							<div class="sch_wrap page">
								<input type="text" name="key" id="search" placeholder="검색어를 입력하세요.">
								<input type="submit" value="검색">
							</div>
						</form>
					</div>
				</div>
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<h4 class="search-title mb-3"><span>서울</span>에 대한 총 <span>1,324</span> 건의 검색 결과</h4>
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
	$(function() {
		$('#search').val('서울');
		commons(1);
	
	})

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