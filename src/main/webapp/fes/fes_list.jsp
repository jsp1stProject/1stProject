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
</head>

<script type="text/javascript">




let ac=[];
let cat3=[];
let sd="${search}";
let valueSet=[0,100000];

window.onload = function () {
	data_ajax(cat3,ac,sd,valueSet);
	console.log("페이지실행")
}

function cleanData()
{
	ac=[];
	cat3=[];
	valueSet=[0,100000];
	sd="";
	const cleancheckboxes1 = document.getElementsByName('cat3');
	const cleancheckboxes2 = document.getElementsByName('ac');
	cleancheckboxes1.forEach((checkbox) => {

	    checkbox.checked = false;

	  })
	  cleancheckboxes2.forEach((checkbox) => {

	    checkbox.checked = false;

	  })
	 rangeset(0,100000);
	
	rangeSlider(document.querySelector('#range-slider'), {
		min: 0,
		max: 100000,
		step: 1000, //step size
		value: [0,100000], //initial values
		//onInput 태그 안의 값들이 변경 될 때마다 이벤트가 발tod
		onInput: function(valueSet) {
			console.log(valueSet);
			rangeset(valueSet[0],valueSet[1]);
			price_change(valueSet);
		},
		
		
	});
	
	
	
	data_ajax(cat3,ac,sd,valueSet);
}

function price_change(valueSet)
{
	console.log("valueSet배열로"+valueSet)
	data_ajax(cat3,ac,sd,valueSet);
}


$(function(){

	$('#ss').click(function(){
		sd=$('#search').val()
		console.log(sd)
		data_ajax(cat3,ac,sd,valueSet);
	})
	$('#search').keydown(function(e){
		if(e.keyCode==13)//엔터
		{
			sd=$('#search').val()
			console.log(sd)
			data_ajax(cat3,ac,sd,valueSet);
		}
	})
})

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
	data_ajax(cat3,ac,sd,valueSet);
	
}

function acClick()
{

	ac=[];
	$("input[name='ac']:checked").each(function(i) { //인풋태그 네임명
			console.log("ac");	
			ac.push($(this).val()); //체크된 값을 넣기
		    console.log(ac)
		    
	   	 
	 });
	data_ajax(cat3,ac,sd,valueSet);
} 






/*t
Ajax에서 Controller에 배열(array)를 보내는 방법 
1. Ajax에 traditional: true, 기본값이 false로 되어있다
traditional 옵션이란 직역해서 "전통적인 스타일의 파라미터 직렬화를 사용하냐 마느냐를 결정"하는 것이다.



 */ 
function data_ajax(cat3,ac,sd,valueSet)
{
	console.log("ajaxcat:"+cat3);
	console.log("ajaxac:"+ac);
	
	
	 $.ajax({
         type: "post",
         url: "../fes/fes_list_ajax.do",
         traditional:true,
         data:{"cat3":cat3,"ac":ac,"search":sd,"valueSet":valueSet},
         success: function(result){
        	 let json=JSON.parse(result)  
        	 if(json.length==0)	 
        	 {
        		 console.log(json);
        		 alert("검색된 데이터가 없습니다")
        	 }
        	 else
        	 {
        		 console.log(json);
            	 jsonView(json)
        	 }	 
        	 
        	 
         }
      }); // ajax 종료

}


function jsonView(json)
{
	console.log("jsonView진입")
	let html='';
	html+='<h4 class="search-title mb-3">'
			if(json[0].search!=null)
			{	
				html+='<span>'+json[0].search+'</span>'
			}
			else
			{
				html+='<span>'+${search}+'</span>'
			}
			html+='에 대한 총 <span>'+json.length+'</span> 건의 검색 결과</h4>'
			+'<ul class="content-ul event"  >'
	
	json.map(function(fes){
		html+='<li>'
			+'<a href="../fes/fes_detail_before.do?content_id='+fes.content_id+'" class="d-flex">'
			if(fes.first_image=='N/A')
			{
				html+='<div class="thumb-wrap">'	
			}
			else
			{
				html+='<div class="thumb-wrap" style="background-image:url('+fes.first_image+')">'
			}
			html+='<button type="button" class="bookmark-btn" name="bm-btn" ></button>'
			+'</div>'
			+'<div class="d-flex flex-column flex-md-row right">'
			+'<div class="title-wrap">'
			+'<p class="cat"><span class="fes"></span></p>'
			+'<p class="content-name">'+fes.title+'</p>'
			+'<p class="location">'+fes.addr1+'</p>'
			+'<p class="score">4.3(23)</p>'
			+'</div>'
			+'<div class="price-wrap">'
			if(fes.price==0)
			{
				html+='<p class="price">무료</p>'
			}
			else
			{
				html+='<p class="price">'+fes.price+'</p>'
			}
			
			html+='</div>'
				+'</div>'
				+'</a>'
				+'</li>'
	

	})
	html+='</ul>'
	$('#view').html(html)
}

</script>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-3 py-3 px-0" style="position:relative">
				<div class="filter-container active">
					<div class="d-flex justify-content-between px-2">
						<button class="cpsbtn">필터</button>
						<button type="button" class="btn btn-light resetbtn" onclick="cleanData()">초기화</button>
					</div>
					<div class="filter-wrap" id="filter" style="height: 450px">
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
								<input type="checkbox" name="cat3" id="t2" value="A02070200" onclick="boxClick()">
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
								충북   33		충남   34
								경북   35		경남   36
								전북   37		전남   38
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
								<input type="checkbox" name="ac" id="t7" value=5 onclick="acClick()">
								<label for="t7">광주</label>
								<input type="checkbox" name="ac" id="t8" value=6 onclick="acClick()">
								<label for="t8">부산</label>
								<input type="checkbox" name="ac" id="t9" value=7 onclick="acClick()">
								<label for="t9">울산</label>
								<input type="checkbox" name="ac" id="t10" value=8 onclick="acClick()">
								<label for="t10">세종</label>
								<input type="checkbox" name="ac" id="t11" value=31 onclick="acClick()">
								<label for="t11">경기</label>
								<input type="checkbox" name="ac" id="t12" value=32 onclick="acClick()">
								<label for="t12">강원</label>
								<input type="checkbox" name="ac" id="t13" value=33 onclick="acClick()">
								<label for="t13">충북</label>
								<input type="checkbox" name="ac" id="t14" value=34 onclick="acClick()">
								<label for="t14">충남</label>
								<input type="checkbox" name="ac" id="t15" value=35 onclick="acClick()">
								<label for="t15">경북</label>
								<input type="checkbox" name="ac" id="t16" value=36 onclick="acClick()">
								<label for="t16">경남</label>
								<input type="checkbox" name="ac" id="t17" value=37 onclick="acClick()">
								<label for="t17">전북</label>
								<input type="checkbox" name="ac" id="t18" value=38 onclick="acClick()">
								<label for="t18">전남</label>
								<input type="checkbox" name="ac" id="t19" value=39 onclick="acClick()">
								<label for="t19">제주</label>
							</div>
							</form>
						</div>
					</div>
				</div>

			</div>
			<div class="col-lg-9 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
							<div class="sch_wrap page">
								<input type="text" id="search" name="key">
								<input type="submit"  value="검색" id="ss" >
							</div>
					</div>
				</div> 
				<div class="container-xxl py-3 px-0">
					<div class="container" id="view">
						
							
							
							
							
						
					</div>
				</div>
				<%-- <div class="container-xxl py-3 px-0">
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
				</div> --%>
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
				price_change(valueSet);
			},
			
			
		});
		
		
		
		function rangeset(min, max){
			$('input.start').val(min.toLocaleString('ko-KR')+'원');
			$('input.end').val(max.toLocaleString('ko-KR')+'원');

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