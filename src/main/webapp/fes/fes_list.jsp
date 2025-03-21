<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"  %>
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
<script type="text/javascript">




let ac=[];
let cat3=[];
let max_price;
let min_price;
let sd="${search}";

function boxClick()
{
	console.log("버튼클릭");
	console.log(sd)
	cat3=[];
	$("input[name='cat3']:checked").each(function(i) { //인풋태그 네임명
			console.log("cat3");	
			cat3.push($(this).val()); //체크된 값을 넣기
		    console.log(cat3)
		    
	   	 
	 });
	data_ajax(cat3,ac,sd);
	
}

function acClick()
{

	ac=[];
	$("input[name='ac']:checked").each(function(i) { //인풋태그 네임명
			console.log("ac");	
			ac.push($(this).val()); //체크된 값을 넣기
		    console.log(ac)
		    
	   	 
	 });
	data_ajax(cat3,ac,sd);
} 

/*

Ajax에서 Controller에 배열(array)를 보내는 방법 
1. Ajax에 traditional: true, 기본값이 false로 되어있다
traditional 옵션이란 직역해서 "전통적인 스타일의 파라미터 직렬화를 사용하냐 마느냐를 결정"하는 것이다.



 */ 
function data_ajax(cat3,ac,sd)
{
	console.log("ajaxcat3:"+cat3);
	console.log("ajaxac:"+ac);
	console.log("ajaxsd:"+sd);
	
	 $.ajax({
         type: "post",
         url: "../fes/fes_list_ajax.do",
         traditional: true,
         data: {'cat3': cat3, 'ac': ac,"search":'${search}'},
         
         success: function(result){
        	 //alert(result) //데이터는 가져오는 것 확인
        	 
        	 /* let json=JSON.parse(result); */
         }
      }); // ajax 종료

}

</script>
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
								<input type="text" class="start" disabled value="0"><span class="ignr"> ~ </span><input type="text" class="end" disabled value="100000">
							</div>
						</div>
						
						<div class="filter-item"> <!--checkbox 타입-->
						<form method=post action="../fes/fes_list.do">
						
							<h6>축제 유형</h6>
							<div class="checkbtn-wrap" id="cat3" >
								<input type="checkbox" name="cat3" id="t1" value="A02070100" onclick="boxClick()">
								<label for="t1">문화관광축제</label>
								<input type="checkbox" name="cat3" id="t2" value="A02070200" onclick="boxClick()" >
								<label for="t2">일반축제</label>
							</div>
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
							<div class="checkbtn-wrap" id="ac">
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
							<h6>가격</h6>
							<div class="checkbtn-wrap">
								<input type="checkbox" name="type" id="t11">
								<label for="t1">무료</label>
								<input type="checkbox" name="type" id="t12">
								<label for="t2">유료</label>
							</div> -->
							</form>
						</div>
					</div>
				</div>

			</div>
			<div class="col-lg-9 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<form action="" method="post" name="page-search">
							<div class="sch_wrap page">
								<input type="text" name="searchWord" placeholder=${search }>
								<input type="submit" value="검색">
							</div>
						</form>
					</div>
				</div> 
				<div class="container-xxl py-3 px-0">
					<div class="container">
						<h4 class="search-title mb-3"><span>${search }</span>에 대한 총 <span>${totalcount}</span> 건의 검색 결과</h4>
						<ul class="content-ul event">
							<%-- <c:forEach begin="0" end="3"> --%>
							<c:forEach var="vo" items="${list }">
								<li><!--호텔 li-->
									<a href="../fes/fes_detail.do" class="d-flex">
										<div class="thumb-wrap" style="background-image:url(${vo.first_image})">
											<button type="button" class="bookmark-btn" name="bm-btn" data-id="${conid}"></button>
										</div>
										<div class="d-flex flex-column flex-md-row right">
											<div class="title-wrap">
												<p class="cat"><span class="hotel"></span><!--cat3으로 구분--></p>
												<p class="content-name">${vo.title}</p>
												<p class="location">${vo.addr1}</p>
												<p class="score">4.3(23)</p>
											</div>
											<div class="price-wrap">
												<c:if test="${vo.price==0}">
												<p class="price">무료</p>
												</c:if>
												<c:if test="${vo.price!=0}">	
												<p class="price">${vo.price }</p>
												</c:if>
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
		
		let listend=false;
		
		$('.bookmark-btn').on('click',function(e){
			e.preventDefault();
			$(this).toggleClass('on');
		});
		//가격필터
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
			//onInput 태그 안의 값들이 변경 될 때마다 이벤트가 발tod
			onInput: function(valueSet) {
				console.log(valueSet);
				rangeset(valueSet[0],valueSet[1]);
				$.ajax({
			         type: "post",
			         url: "../fes/fes_list_ajax.do",
			         //traditional: true,
			         data: {'min_price': valueSet[0], 'max_price': valueSet[1]},
			         
			         success: function(result){
		
			         }
			      }); // ajax 종료
			},
			
			
		});
		
		function rangeset(min, max){
			$('input.start').val(min.toLocaleString('ko-KR')+'원');
			$('input.end').val(max.toLocaleString('ko-KR')+'원');
			
			
				
		}
		function data_ajax(cat3, ac)
		{
			console.log("ajax"+cat3)
			console.log("ajax"+ac)
			 $.ajax({
		         type: "post",
		         url: "../fes/fes_list_ajax.do",
		         traditional: true,
		         data: {'cat3': cat3, 'ac': ac},
		         
		         success: function(result){
		        	 //alert(result) //데이터는 가져오는 것 확인
		        	 
		        	 /* let json=JSON.parse(result); */
		         }
		      }); // ajax 종료

		}
		rangeset(0,100000);
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


	</script>
</body>
</html>