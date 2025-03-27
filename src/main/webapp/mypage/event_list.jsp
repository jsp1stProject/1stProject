<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<body>
	<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
	<style type="text/css">
		.content-ul .thumb-wrap {
			width: 120px;
			height: 120px;
		}
		.content-ul .title-wrap p.enddate {
			font-size: 14px;
			color: #737373;
		}
		p.price {
			font-size: 18px;
			font-weight: 600;
		}
		button.btn-white:disabled {
			opacity: .3;
		}
	</style>
	<div class="container pt-5 pt-lg-3">
		<div class="row justify-content-center">
			<jsp:include page="mynav.jsp"></jsp:include>
			<div class="col-lg-9 col-12">
				<h3 class="pt-3 pt-lg-0 pb-3">내 티켓</h3>
				<div>
					<form action="../event/event_list.do" method="post" name="page-search">
						<div class="sch_wrap page">
							<input type="text" name="key" id="key" placeholder="검색어를 입력하세요." value="${param.key}">
							<input type="submit" value="검색">
							<input type="hidden" name="mode" value="search">
						</div>
					</form>
					<h4 class="search-title my-3"><span>3</span>장의 티켓이 아직 <span>관람 전</span>이에요!</h4>
					<ul class="content-ul event">
						<c:forEach items="${list }" var="vo">
							<li>
								<a href="#" class="d-flex">
									<div class="thumb-wrap" style="background-image:url(${vo.cvo.first_image})">
										<button type="button" class="bookmark-btn on"></button>
									</div>
									<div class="d-flex flex-column flex-md-row right">
										<div class="title-wrap">
											<p class="cat">
											<c:choose>
												<c:when test="${vo.used eq 'n' }"><span class="hotel">사용 가능</span></c:when>
												<c:otherwise><span class="event1">관람 완료</span></c:otherwise>
											</c:choose>
											</p>
											<p class="content-name">${vo.cvo.title}</p>
											<p class="enddate">${vo.account}매│${vo.evo.dbend}까지</p>
											<p class="price">
												<c:choose>
													<c:when test="${vo.total_price eq 0 }"><p class="price">무료</p></c:when>
													<c:otherwise><p class="price"><fmt:formatNumber value="${vo.total_price }" pattern="#,###" />원</p></c:otherwise>
												</c:choose>
											</p>
										</div>
									</div>
								</a>
								<c:choose>
									<c:when test="${vo.used eq 'n' }"><a href="#" class="mt-3" style="display:block;"><button class="btn-white" disabled>리뷰 작성하기</button></a></c:when>
									<c:when test="${vo.used eq 'y' }"><a href="#" class="mt-3" style="display:block;"><button class="btn-white">리뷰 작성하기</button></a></c:when>
									<c:when test="${vo.used eq 'r' }"><a href="#" class="mt-3" style="display:block;"><button class="btn-black">리뷰 확인하기</button></a></c:when>
								</c:choose>

							</li>
						</c:forEach>
					</ul>
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
		<c:if test="${mode eq 'area'}">
			var codeArr = [
				<c:forEach var="item" items="${paramValues.type}">
					<c:out value="${item}"/>,
				</c:forEach>
			];
		</c:if>
		let data={
			<c:choose>
				<c:when test="${mode eq 'search'}">"key": $("#key").val(),</c:when>
				<c:when test="${mode eq 'area'}">"areacode": codeArr,</c:when>
			</c:choose>
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
				headers:{
					"Content-Type":"application/json"
				},
				params:{
					"mode":"${mode}"
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

	//filter검색버튼
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
		$(".cpsbtn").removeClass("active");
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

	<c:if test="${mode eq 'area'}">
	//area select
	$(document).on("click","#event_sel_btn",function(){
		$(".event_main_sel_ul").fadeToggle(100);
	});
	$(document).on("click",".event_main_sel_ul button",function(){
		let thisid=$(this).attr("id").substring(1);
		$("form[name=areaform] input").prop("checked",false);
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
	</c:if>
</script>
</body>
</html>