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
				<div class="filter-container">
					<div class="d-flex justify-content-between px-2">
						<button class="cpsbtn">필터</button>
						<button type="button" class="btn btn-light resetbtn" onclick="reset()">초기화</button>
					</div>
					<form action="" name="filterform" method="post">
						<div class="filter-inner">
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
						</div>
					</form>
				</div>
			</div>
			<div class="col-lg-9 px-0">
				<div class="container-xxl py-lg-3 pt-5 pb-3 px-0">
					<div class="container">
						<div class="event_main_selinner">
							<div class="sch_wrap area" id="event_sel_btn">
								<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path clip-rule="evenodd" d="M12 3.5C8.41015 3.5 5.5 6.41015 5.5 10C5.5 12.0175 6.40035 14.1225 7.61299 16.026C8.81776 17.9172 10.2807 19.5319 11.2953 20.552C11.6963 20.9552 12.3096 20.9561 12.711 20.5552C13.7258 19.5417 15.1868 17.9369 16.3898 16.0491C17.6001 14.1497 18.5 12.04 18.5 10C18.5 6.41015 15.5899 3.5 12 3.5ZM4 10C4 5.58172 7.58172 2 12 2C16.4183 2 20 5.58172 20 10C20 12.4534 18.9312 14.8521 17.6548 16.8552C16.3711 18.8697 14.8277 20.5611 13.771 21.6165C12.7816 22.6046 11.217 22.6003 10.2318 21.6098C9.17624 20.5486 7.63235 18.8482 6.3479 16.832C5.07132 14.8281 4 12.4333 4 10Z"></path><path clip-rule="evenodd" d="M10.055 8.30857C10.5856 7.77623 11.247 7.5 11.9981 7.5C12.7484 7.5 13.4097 7.77494 13.9414 8.30499C14.4738 8.83562 14.75 9.49704 14.75 10.2481C14.75 10.9984 14.4751 11.6597 13.945 12.1914C13.4144 12.7238 12.753 13 12.0019 13C11.2516 13 10.5903 12.7251 10.0586 12.195C9.52623 11.6644 9.25 11.003 9.25 10.2519C9.25 9.50164 9.52494 8.84032 10.055 8.30857ZM11.9981 9C11.6481 9 11.3683 9.1158 11.1173 9.36753C10.8658 9.61984 10.75 9.90107 10.75 10.2519C10.75 10.6019 10.8658 10.8817 11.1175 11.1327C11.3698 11.3842 11.6511 11.5 12.0019 11.5C12.3519 11.5 12.6317 11.3842 12.8827 11.1325C13.1342 10.8802 13.25 10.5989 13.25 10.2481C13.25 9.89815 13.1342 9.61827 12.8825 9.36735C12.6302 9.11584 12.3489 9 11.9981 9Z"></path></svg>
								<p id="area">${param.areaStr}</p>
							</div>
							<ul class="event_main_sel_ul">
								<li><button type="button" id="a1">서울</button></li>
								<li><button type="button" id="a6">부산</button></li>
								<li><button type="button" id="a39">제주</button></li>
								<li><button type="button" id="a31">경기</button></li>
								<li><button type="button" id="a2">인천</button></li>
								<li><button type="button" id="a32">강원</button></li>
								<li><button type="button" id="a35">경북, 경남, 울산, 대구</button></li>
								<li><button type="button" id="a37">전북, 전남, 광주</button></li>
								<li><button type="button" id="a33">충북, 충남, 대전, 세종</button></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="container-xxl pb-3 px-0">
					<div class="container">
						<h4 class="search-title">총 <span id="count">0</span>건의 행사를 확인해보세요.</h4>
						<ul class="content-ul event"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form method="post" action="../event/event_area.do" name="areaform" class="hidden">
		<input type="checkbox" name="type" value="1" id="1">
		<input type="checkbox" name="type" value="2" id="2">
		<input type="checkbox" name="type" value="3" id="3">
		<input type="checkbox" name="type" value="4" id="4">
		<input type="checkbox" name="type" value="5" id="5">
		<input type="checkbox" name="type" value="6" id="6">
		<input type="checkbox" name="type" value="7" id="7">
		<input type="checkbox" name="type" value="8" id="8">
		<input type="checkbox" name="type" value="31" id="31">
		<input type="checkbox" name="type" value="32" id="32">
		<input type="checkbox" name="type" value="33" id="33">
		<input type="checkbox" name="type" value="34" id="34">
		<input type="checkbox" name="type" value="35" id="35">
		<input type="checkbox" name="type" value="36" id="36">
		<input type="checkbox" name="type" value="37" id="37">
		<input type="checkbox" name="type" value="38" id="38">
		<input type="checkbox" name="type" value="39" id="39">
		<input type="text" name="areaStr" value="" id="areaStr">
	</form>
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
		}else{
			con.addClass('active');
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
		var codeArr = [
			<c:forEach var="item" items="${paramValues.type}">
				<c:out value="${item}"/>,
			</c:forEach>
		];
		let data={
			"areacode": codeArr,
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
				url:'event_area_data.do',
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
<a href="../event/event_detail.do?id=`+vo.content_id+`" class="d-flex">
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

	//filter 검색 버튼
	function filtersubmit(){
		if(filteron){ //filter 적용 되어있으면
			filtersrh=true; //현재 출력 중인 리스트 filter 여부
		}else{
			filtersrh=false;
		}
		if($(".filter-container").hasClass("active")){
			$(".filter-container").removeClass("active");
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

	//area select
	$(document).on("click","#event_sel_btn",function(){
		$(".event_main_sel_ul").fadeToggle(100);
	});
	$(document).on("click",".event_main_sel_ul button",function(){
		let thisid=$(this).attr("id").substring(1);
		$("form[name=areaform] input").map(function(index,el){
			if($(el).attr("id")===thisid){
				$(el).prop("checked",true);
			}
			if(thisid==="35"){
				$("#4, #7, #36").prop("checked",true);
			}else if(thisid==="37"){
				$("#5, #38").prop("checked",true);
			}else if(thisid==="33"){
				$("#3, #8, #34").prop("checked",true);
			}
		});
		$("#areaStr").val($(this).text());
		$("form[name=areaform]").submit();
	});
</script>
</body>
</html>