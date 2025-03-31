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
                <p class="text-primary text-uppercase mb-2">// 마감 임박</p>
                <h1 class="display-6 mb-4">곧 종료됩니다!</h1>
            </div>
            <div class="row g-4">
                <c:forEach items="${dlist}" var="dvo">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="team-item text-center rounded overflow-hidden">
                        <img class="img-fluid"  src="${dvo.first_image}" alt="">
                        <div class="team-text">
                            <div class="team-title">
                                <h5>${dvo.title }</h5>
                                <span>${dvo.event_enddate }까지</span>
                            </div>
                            <div class="team-social">
                                <%-- <p class="mb-0" style=" height: 50px;" >${dvo.overview}</p> --%>
                                <a class="btn btn-light " href="../fes/fes_detail_before.do?content_id=${dvo.content_id }"> <p class="mb-0" >${dvo.addr1}</p></a>         
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                
            </div>
        </div>
    </div>	

	<div class="container-xxl py-4">
		<div class="container">
			<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">공지사항</h3>
			<div class="main-notice-wrap wow fadeInUp" data-wow-delay="0.1s">
				<ul class="main-notice-ul">
					<c:forEach items="${nlist}" var="nvo" >
						<li>
							<div class="notice-title">
								<p>${nvo.subject }</p>
								<p class="date">${nvo.dbday }</p>
							</div>
							<div class="notice-content">
								<p>${nvo.content }</p>
								<button type="button" class="notice-more-btn w-100" onclick="location.href='../notice/notice_detail.do?no=${nvo.no}'">자세히 보기</button>
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