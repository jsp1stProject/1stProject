<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
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
					<form action="" >
					<div class="filter-wrap" id="filter">
						<div class="filter-item col-lg-12 col-md-4 col-sm-12"> <!-- range 타입 -->
							<h6>가격대</h6>
							<div id="range-slider"></div>
							<div class="d-flex justify-content-center range-value-wrap">
								<input type="text" class="start" disabled value="0"><span class="ignr"> ~ </span><input type="text" class="end" disabled value="100000">
<%--								<span class="start">0원</span><span class="ignr"> ~ </span><span class="end">100000</span>--%>
							</div>
						</div>
						<div class="filter-item"> <!--checkbox 타입-->
							<h6>축제 유형</h6>
							<div class="checkbtn-wrap">
								<c:forEach items="${catelist}" var="cate" varStatus="i">
									<input type="checkbox" name="type" id="t${i.current}" checked>
									<label for="t${i.current}">${cate}</label>
								</c:forEach>
							</div>
						</div>
						<div class="filter-item">
							<button type="button" class="btn filterschbtn" onclick="data(1, this.form);">검색</button>
						</div>
					</div>
					</form>
				</div>
			</div>
			<div class="col-lg-9 px-0">
				<div class="container-xxl py-lg-3 pt-5 pb-3 px-0">
					<div class="container">
						<form action="../event/event_list.do" method="post" name="page-search">
							<div class="sch_wrap page">
								<input type="text" name="key" id="key" placeholder="검색어를 입력하세요." value="${param.key}">
								<input type="submit" value="검색">
							</div>
						</form>
					</div>
				</div>
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<h4 class="search-title mb-3"><span>${param.key}</span>에 대한 총 <span id="count">0</span> 건의 검색 결과</h4>
						<ul class="content-ul event"></ul>
					</div>
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
		min: ${minprice},
		max: ${maxprice},
		step: 1000, //step size
		value: [${minprice}, ${maxprice}], //initial values
		onInput: function(valueSet) {
			console.log(valueSet);
			rangeset(valueSet[0],valueSet[1]);
			// $('input.start').val(valueSet[0].toLocaleString('ko-KR')+'원');
			// $('input.end').val(valueSet[1].toLocaleString('ko-KR')+'원');
		},
	});
	function rangeset(min, max){
		$('input.start').val(min.toLocaleString('ko-KR')+'원');
		$('input.end').val(max.toLocaleString('ko-KR')+'원');
	}
	rangeset(${minprice},${maxprice});
	let floatPosition = parseInt($(".filter-container").css('top'));
	$(window).scroll(function() {
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";
		$(".filter-container").stop().animate({
			"top" : newPosition
		}, 50);

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

	//--------------------ajax
	async function data(page,form){
		try {
			let response=await axios({
				method:'post',
				url:'event_list_data.do',
				hearders:{
					"Content-Type":"application/json"
				},
				data:{
					"key": $('#key').val(),
					"curpage": page,
					"start":form.start.value, //form.name.값
					"end":form.end.value

				}
			});
			listadd(response.data);
		} catch (e) {
			console.log(e);
			throw new Error(e);
		}
	}
	function listadd(data){
		let html='';
		if(data.length!=0 && data[0].listend===true){
			listend=true;
		}else if(data.length===0){
			html+='<li class="noresult">일치하는 행사를 찾을 수 없습니다.</li>';
		}else{
			data.map(function(vo){
				html+=`<li>
<a href="#" class="d-flex">
<div class="thumb-wrap" style="background-image:url(`+vo.first_image+`)">
<button type="button" class="bookmark-btn on"></button>
</div>
<div class="d-flex flex-column flex-md-row right">
<div class="title-wrap">
<p class="cat"><span class="event1">`+vo.dbcate+`</span></p>
<p class="content-name">`+vo.title+`</p>
<p class="location">`+vo.addr1+`</p>
<p class="enddate">`+vo.dbend+`까지</p>
</div>
<div class="price-wrap">`;
				if(vo.price==0){
					html+="<p class=\"price\">무료</p>";
				}else{
					html+="<p class=\"price\">"+vo.price.toLocaleString('ko-KR')+"원</p>"
				}
				html+=`</div>
</div>
</a>
</li>`

			});
		}
		if(listend===false){
			$('.content-ul').append(html);
			$('#count').text(data[0].count.toLocaleString('ko-KR'));
		}
	}
	function filtersubmit(){

	}
	data(1);
	let page=2;
	$(window).scroll(function () {
		if($(window).scrollTop() + $(window).height() === $(document).height()) {
			data(page);
			if(listend===false){
				page++;
			}
			console.log(page);
		}
	});
</script>
</body>
</html>