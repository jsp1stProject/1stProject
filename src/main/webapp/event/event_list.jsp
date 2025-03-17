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
						<button type="button" class="btn btn-light resetbtn" onclick="reset()">초기화</button>
					</div>
					<form action="" name="filterform" method="post">
					<div class="filter-wrap" id="filter">
						<div class="filter-item col-lg-12 col-md-4 col-sm-12"> <!-- range 타입 -->
							<h6>가격대</h6>
							<div id="range-slider"></div>
							<div class="d-flex justify-content-center range-value-wrap">
								<input type="text" class="start" disabled value="<fmt:formatNumber value="${minprice }" pattern="#,###" />원"><span class="ignr"> ~ </span><input type="text" class="end" disabled value="<fmt:formatNumber value="${maxprice }" pattern="#,###" />원">
							</div>
						</div>
						<div class="filter-item"> <!--checkbox 타입-->
							<h6>행사 유형</h6>
							<div class="checkbtn-wrap">
								<c:forEach items="${catemap}" var="cate" varStatus="i">
									<input type="checkbox" name="type" id="${cate.key}">
									<label for="${cate.key}">${cate.value}</label>
								</c:forEach>
							</div>
						</div>
						<div class="filter-item"> <!--radio 타입-->
							<h6>행사 기간</h6>
							<div class="radio-wrap row">
								<div class="col-3 col-lg-6">
									<input type="radio" name="enddate" value="false" id="enddate1" checked>
									<label for="enddate1">전체</label>
								</div>
								<div class="col-3 col-lg-6">
									<input type="radio" name="enddate" value="true" id="enddate2">
									<label for="enddate2">진행 중</label>
								</div>
							</div>
						</div>
						<div class="filter-item">
							<button type="button" class="filterschbtn" onclick="filtersubmit();"><span>0</span>개 행사 보기</button>
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
				<div class="container-xxl pb-3 px-0">
					<div class="container">
						<h4 class="search-title">총 <span id="count">0</span> 건의 행사를 확인해보세요.</h4>
						<ul class="content-ul event"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	let listend=false;
	let filteron=false;
	let filtersrh=false;

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
	const rs= rangeSlider(document.querySelector('#range-slider'), {
		min: ${minprice},
		max: ${maxprice},
		step: 1000, //step size
		value: [${minprice}, ${maxprice}], //initial values
		onInput: function(valueSet) {
			rangeset(valueSet[0],valueSet[1]);
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
	async function data(page,isScroll,isFilter,form,isPreview){
		let data={
			"key": $("#key").val(),
			"curpage": page,
			"filter":"false"
		}
		if(isFilter){ //필터 적용일 때만
			data.filter="true";
			if(form.start.value!=${minprice}||form.end.value!=${maxprice}){
				data.filtermin=form.start.value;
				data.filtermax=form.end.value;
			}
			let cate=[];
			let catelist='';
			$("#filter input[name=type]:checked").map(function(index,el){
				cate.push($(el).attr("id"));
			});
			if(cate.length>0){
				catelist+=cate.join(",");
				data.cate=catelist;
			}
			if($("#filter input[name=enddate]:checked").val()==='true'){
				data.enddate="true";
			}
		}
		try {
			let response=await axios({
				method:'post',
				url:'event_list_data.do',
				hearders:{
					"Content-Type":"application/json"
				},
				data:JSON.stringify(data)
			});
			$('.filterschbtn span').text(response.data[0].count==0?'0':response.data[0].count.toLocaleString('ko-KR'));
			if(!isPreview){
				listadd(response.data,isScroll);
			}
		} catch (e) {
			console.log(e);
			throw new Error(e);
		}
	}
	//내용 삽입
	function listadd(data,isScroll){
		if(!isScroll){
			$('.content-ul').children().remove();
			console.log("is scroll "+isScroll);
		}
		let html='';
		if(listend===false){ //listend면 아무 것도 하지 않음
			if(data[0].count===0){
				html+='<li class="noresult">일치하는 행사를 찾을 수 없습니다.</li>';
			}else{
				data.map(function(vo){
					html+=`<li>
<a href="#" class="d-flex">
<div class="thumb-wrap" `+(vo.first_image==="N/A"?"":" style='background-image:url("+vo.first_image+")'")+`>
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
			$('.content-ul').append(html);
			$('#count').text(data[0].count==0?'0':data[0].count.toLocaleString('ko-KR'));
			$('.filterschbtn span').text(data[0].count==0?'0':data[0].count.toLocaleString('ko-KR'));
		}
		if(data.length!=0 && data[0].listend===true){ //남은 페이지가 없는 경우 listend true
			listend=true;
		}
	}
	//filter 값 변경 시 filter 적용 되었는지 체크
	$(document).on("click","#filter input, #range-slider",function(){
		filteron=true;
		if($("#range-slider input[name=start]").val()==${minprice}&&
				$("#range-slider input[name=end]").val()==${maxprice}&&
				!$("#filter input[type=checkbox]").is(':checked')&&
				$("#filter input[name=enddate]:checked").val()==='false'){
			filteron=false;
		}
		if(filteron){
			$(".cpsbtn").addClass("active");
		}else{
			$(".cpsbtn").removeClass("active");
		}
		data(1,false,true,document.filterform,true); //page,scroll,filter,form,preview
	});

	//filter검색버튼
	function filtersubmit(){
		if(filteron){ //filter 적용 되어있으면
			filtersrh=true; //현재 출력 중인 리스트 filter 여부
		}else{
			filtersrh=false;
		}
		$("html").scrollTop(0);
		page=2;
		listend=false; //page, listend 초기화
		data(1,false,filtersrh,document.filterform);

	}

	//filter 리셋 버튼
	function reset(){
		document.filterform.reset();
		rs.value([${minprice},${maxprice}]);
		filteron=false;
		data(1,false,true,document.filterform,true);
	}
	data(1,false);
	let page=2;

	//스크롤할때
	let defaultST = 0;

	window.addEventListener('scroll',() => {
		let nextScrollTop = window.scrollY;

		if(defaultST < nextScrollTop) {
			if($(window).scrollTop() + $(window).height() === $(document).height()) {
				if(listend===false){
					data(page,true,filtersrh,document.filterform);
					page++;
				}
				console.log(page);
			}
		}
		defaultST = nextScrollTop;
	});
</script>
</body>
</html>