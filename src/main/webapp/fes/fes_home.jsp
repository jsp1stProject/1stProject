<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div class="container-fluid p-0 pb-4 wow fadeIn" data-wow-delay="0.1s">
		<div class="event_main_wrap justify-content-center" style=" background-image:url(../assets/img/fes_home1.jpg)" >
			<span style="color: white;">오늘은 어떤 축제를<br></span>
			<span  style="color: white; margin-bottom: 10px">즐겨볼까요?</span>
			<div class="event_main_schwrap">
				<form method="post" action="../fes/fes_list.do" name="keywordform">
					<div class="event_main_schinner">
						<input type="text" name="search" placeholder="축제명 또는 지역을 입력하세요">
						<input type="submit">
					</div>
				</form>
			</div>
			
		</div>
	</div>
    <!-- Carousel End -->
    <div class="container-xxl py-5">
    	<div class="container">
    		<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">입장료 없이 즐길 수 있는 축제</h3>
    		<div class="tab-content-wrap wow fadeInUp" data-wow-delay="0.1s">
    			<div class="tab-cont-item active" data-tab="1">
	    			<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
							<c:forEach items="${list}" var="vo">
							 <c:if test="${vo.price==0 }">
								<div class="li-item swiper-slide">
									<a href="../fes/fes_detail_before.do?content_id=${vo.content_id }">
										<div class="item-inner">
											<div class="item-img" style=" background-image:url(${vo.first_image});">
											</div>
											<div class="text-wrap">
												<p class="title">${vo.title}</p>
												<p class="price">무료</p>
												
											</div>
										</div>
									</a>
								</div>
							  </c:if>	
							</c:forEach>
		    			</div>
		    		</div>
	    		</div>
    		</div>
    	</div>
    </div>
    
    
    <div class="container-xxl py-6">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 500px;">
                <h1 class="display-6 mb-4">곧 종료되는 축제!!! 마감임박!! </h1>
            </div>
            <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
                <c:forEach items="${dlist}" var="dvo">
                <div class="testimonial-item bg-white rounded p-4">
                    <div class="d-flex align-items-center mb-4" onclick='location.href = "../fes/fes_detail_before.do?content_id=${dvo.content_id }"'>
                        <img class="flex-shrink-0 rounded-circle border p-1" src="${dvo.first_image}" alt="">
                        <div class="ms-4">
                            <h5 class="mb-1">${dvo.title }</h5>
                            <span>${dvo.addr1 }<span>
                        </div>
                    </div>
                    <p class="mb-0" style=" height: 110px " >${dvo.overview}</p>
                </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    
	<!-- fest list-->
	<div class="container-xxl py-4">
		<div class="container">
			<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">지금 볼 수 있는 지역별 축제</h3>
			<div class="main-fes-wrap d-flex wow fadeInUp" data-wow-delay="0.1s">
				<c:forEach items="${fesList }" var="vo" varStatus="i">
					<div class="main-fes-item" style="background-image:url(${vo.cvo.first_image});">
						<p class="main-fes-area fs-3">${vo.dbarea}</p>
						<a href="#" class="main-fes-title fs-2">${vo.cvo.title}</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
    <!-- concert list-->
	

	<div class="container-xxl py-4">
		<div class="container">
			<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">공지사항</h3>
			<div class="main-notice-wrap wow fadeInUp" data-wow-delay="0.1s">
				<ul class="main-notice-ul">
					<c:forEach begin="1" end="5">
						<li>
							<div class="notice-title">
								<p>봄맞이 국내여행 최대 3만원 쿠폰 대한민국 숙박세일 페스타</p>
								<p class="date">2025.03.10</p>
							</div>
							<div class="notice-content">
								<p>안녕하세요,
									인터파크항공입니다.
									보다 안정적인 서비스를 위하여 아래 기간 동안 서비스가 제한될 예정이오니, 이용에 참고 부탁 드리겠습니다.
									※ 정기점검 일시 : 2025년 3월 12일[수] 02:00 ~ 07:00
									(해당 작업은 작업상태에 따라 단축되거나 연장될 수 있습니다.)
									항상 고객님께 최선의 서비스를 제공하기 위해 노력하는 인터파크항공이 되겠습니다.
									감사합니다. </p>
								<button type="button" class="notice-more-btn w-100" onclick="location.href='#'">자세히 보기</button>
							</div>
						</li>
					</c:forEach>

				</ul>
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