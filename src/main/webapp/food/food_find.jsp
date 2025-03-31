<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.page-item{
  cursor: pointer;
}
.content-wrap {
    min-height: calc(100vh - 100px); /* 화면 높이에서 footer 높이를 뺀 값 */
}
</style>
<script type="text/javascript">
$(function(){
	
	$('#ss').val('서울')
	commons(1)
	
	$('#findBtn').click(function(){
		commons(1)
	})
	$('#ss').keydown(function(e){
		if(e.keyCode==13)
		{
			commons(1)
		}
	})
})
function commons(page)
{
	let ss=$('#ss').val();
	let totalCount = $('#totalCount').val(); 
	let fdList = [];
	 let fd = [];
        $('input[name="fd"]:checked').each(function() {
        	fdList.push($(this).val()); // 체크된 체크박스의 value 값을 가져옴
        });
        if (fdList.length === 0) {
            fdList = ["name", "theme", "address"]; // 모든 항목 검색
        }
	$.ajax({
		
		type:'post',
		url:'../food/food_find_ajax.do', 
		data:{"fd":fdList.join(','),"ss":ss,"page":page}, 
        success: function (result) {        	
        	console.log("📢 AJAX 요청 시작!");
            let json=JSON.parse(result)
			jsonView(json)
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 실패!");
            console.error("상태:", status);
            console.error("오류 메시지:", error);
        }
		/* success:function(result){
			console.log("총 페이지 수:", totalpage);
			//$('#view').text(result)
			
		} */
})
}
function prev(page)
{
	commons(page)
}
function next(page)
{
	commons(page)
}
function pageChange(page)
{
	commons(page)
}
function jsonView(json)
{
	// 이미지 
	let html=''
		
	json.map(function(food){
		
				html+='<ul class="content-ul event"  >'
					html+='<li>'
					html+='<a href="../food/food_detail_before.do?fno='+food.fno+'" class="d-flex">'
					html+='<div class="thumb-wrap" style="background-image:url(https://www.menupan.com'+food.poster+')">'
					html+='<button type="button" class="bookmark-btn" name="bm-btn" data-id="#"></button>'
						html+='</div>'
							html+='<div class="d-flex flex-column flex-md-row right">'
								html+='<div class="title-wrap">'
									html+='<p class="cat">'+food.type+'</p>'
									html+='<p class="content-name">'+food.name+'</p>'
									html+='<p class="location">'+food.address+'</p>'
									html+='<p class="score">'+food.score+'</p>'
									html+='</div>'
										html+='<div class="price-wrap">'
								if(food.price!==null)
								{
									html+='<p class="price">'+food.price+'</p>'
								}
								else
								{
									html+='<p class="price">현장 문의</p>'
								}
								html+='</div></div></a></li></ul></div></div>'
			})
		html+='<div class="container-xxl py-3 px-0">'
			html+='<div class="container d-flex">'
			html+='<ul class="pagination">'
				if(json[0].startPage>1)
			      {
			       html+='<a class="bfarr" onclick="prev('+(json[0].startPage-1)+')"><div class="arr left" style="left:9px"></div><div class="arr left" style="left:16px"></div></a>'
			       html+='<a class="bfarr" onclick="prev('+(json[0].curpage-1)+')"><div class="arr left"></div></a>'
			      }
			            
			      for(let i=json[0].startPage;i<=json[0].endPage;i++)
			      {
			    	  if(json[0].curpage===i)
			    	  {
			    		  html+='<a class="active" onclick="pageChange('+i+')">'+i+'</a>'
			    	  }
			    	  else
			    	  {
			    		  html+='<a class="" onclick="pageChange('+i+')">'+i+'</a>'
			    	  }
			    	  
			      }
			            
			            if(json[0].endPage<json[0].totalpage)
			            {
							html+='<a class="afarr" onclick="next('+(json[0].curpage+1)+')"><div class="arr right"></div></a>'
			            	html+='<a class="afarr" onclick="next('+(json[0].totalpage)+')"><div class="arr right" style="left:9px"></div><div class="arr right" style="left:16px;"></div></a>'
			            }
			 html+='</ul>'

				 
	
$('#view').html(html)
	}
</script>
</head>
<body> 

<div class="container" id="contant-wrap">
	<div class="row justify-content-center">
		<div class="col-lg-3 py-3 px-0" style="position:relative">
			<div class="filter-container container">
				<div class="d-flex justify-content-between">
					<button class="cpsbtn">필터</button>
					<button type="button" class="btn btn-light resetbtn">초기화</button>
				</div>
				<div class="filter-inner pt-3">
					<div class="filter-wrap" id="filter">
						<div class="filter-item">
							<h6>검색 유형</h6>
							<div class="checkbtn-wrap">
								 <input type="checkbox" id="fd1" name="fd" value="name">
								 <label for="fd1" class="label">맛집명</label>

								 <input type="checkbox" id="fd2" name="fd" value="theme">
								 <label for="fd2" class="label">테마</label>

								 <input type="checkbox" id="fd3" name="fd" value="address" checked>
								 <label for="fd3" class="label">주소</label>

								 <input type="checkbox" id="fd4" name="fd" value="type">
								 <label for="fd4" class="label">종류</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-9 px-0">
			<div class="container-xxl py-lg-3 py-4 px-0">
				<div class="container">
					<div class="sch_wrap page">
						<input type="text" name="key" placeholder="검색어를 입력하세요."  id="ss">
						<input type="submit" id="findBtn" class="btn btn-primary btn-circle">
							<i class="search-icon"></i>
						</input>
					</div>
				</div>
<%--				<h4 class="search-title mb-3"><span id="ss"></span>에 대한 총 <span id="totalCount"></span> 건의 검색 결과</h4>--%>
				<div class="container" id="view">
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

	</script>
</body>
</html>