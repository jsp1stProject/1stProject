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
		<div class="event_main_wrap" style="background-image:url(/assets/img/event_main.png)">
			<div class="event_main_schwrap">
				<div class="event_main_schinner">
					<form method="post" action="../event/event_list.do" name="keywordform">
						<input type="text" name="key" placeholder="가고싶은 행사가 있나요?">
						<input type="submit">
					</form>
				</div>
			</div>
			<div class="event_main_schwrap">
				<div class="event_main_selinner">
					<div class="event_main_sel" id="event_sel_btn">
						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path clip-rule="evenodd" d="M12 3.5C8.41015 3.5 5.5 6.41015 5.5 10C5.5 12.0175 6.40035 14.1225 7.61299 16.026C8.81776 17.9172 10.2807 19.5319 11.2953 20.552C11.6963 20.9552 12.3096 20.9561 12.711 20.5552C13.7258 19.5417 15.1868 17.9369 16.3898 16.0491C17.6001 14.1497 18.5 12.04 18.5 10C18.5 6.41015 15.5899 3.5 12 3.5ZM4 10C4 5.58172 7.58172 2 12 2C16.4183 2 20 5.58172 20 10C20 12.4534 18.9312 14.8521 17.6548 16.8552C16.3711 18.8697 14.8277 20.5611 13.771 21.6165C12.7816 22.6046 11.217 22.6003 10.2318 21.6098C9.17624 20.5486 7.63235 18.8482 6.3479 16.832C5.07132 14.8281 4 12.4333 4 10Z"></path><path clip-rule="evenodd" d="M10.055 8.30857C10.5856 7.77623 11.247 7.5 11.9981 7.5C12.7484 7.5 13.4097 7.77494 13.9414 8.30499C14.4738 8.83562 14.75 9.49704 14.75 10.2481C14.75 10.9984 14.4751 11.6597 13.945 12.1914C13.4144 12.7238 12.753 13 12.0019 13C11.2516 13 10.5903 12.7251 10.0586 12.195C9.52623 11.6644 9.25 11.003 9.25 10.2519C9.25 9.50164 9.52494 8.84032 10.055 8.30857ZM11.9981 9C11.6481 9 11.3683 9.1158 11.1173 9.36753C10.8658 9.61984 10.75 9.90107 10.75 10.2519C10.75 10.6019 10.8658 10.8817 11.1175 11.1327C11.3698 11.3842 11.6511 11.5 12.0019 11.5C12.3519 11.5 12.6317 11.3842 12.8827 11.1325C13.1342 10.8802 13.25 10.5989 13.25 10.2481C13.25 9.89815 13.1342 9.61827 12.8825 9.36735C12.6302 9.11584 12.3489 9 11.9981 9Z"></path></svg>
						<p>지역으로 찾아보기</p>
					</div>
					<ul class="event_main_sel_ul">
						<li><button type="button" id="a1">서울</button></li>
						<li><button type="button" id="a6">부산</button></li>
						<li><button type="button" id="a39">제주</button></li>
						<li><button type="button" id="a31">경기</button></li>
						<li><button type="button" id="a2">인천</button></li>
						<li><button type="button" id="a32">강원</button></li>
						<li><button type="button" id="a35">경상(울산, 대구)</button></li>
						<li><button type="button" id="a37">전라(광주)</button></li>
						<li><button type="button" id="a33">충청(대전, 세종)</button></li>
					</ul>
					<form method="post" action="../event/event_area.jsp" name="areaform">
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
					</form>
				</div>
			</div>
		</div>
	</div>
    <!-- Carousel End -->
	<!-- hotel list-->
    <div class="container-xxl py-4">
    	<div class="container">
    		<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">지역별 행사</h3>
    		<div class="tab-nav-wrap wow fadeInUp" data-wow-delay="0.1s">
    			<div class="tab-nav-item active" data-tab="1">서울</div>
    			<div class="tab-nav-item" data-tab="2">부산</div>
    			<div class="tab-nav-item" data-tab="3">제주</div>
    		</div>
    		<div class="tab-content-wrap wow fadeInUp" data-wow-delay="0.1s">
    			<div class="tab-cont-item active" data-tab="1">
	    			<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
							<c:forEach items="${arealist1}" var="vo">
								<div class="li-item swiper-slide">
									<a href="#">
										<div class="item-inner">
											<div class="item-img" style="background-image:url(${vo.cvo.first_image});">
											</div>
											<div class="text-wrap">
												<p class="title">${vo.cvo.title}</p>
												<c:choose>
													<c:when test="${vo.price==0}">
														<p class="price">무료</p>
													</c:when>
													<c:otherwise>
														<p class="price"><fmt:formatNumber value="${vo.price }" pattern="#,###" />원</p>
													</c:otherwise>
												</c:choose>
												<p class="score">
													<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
													<span>4.2</span>
												</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
		    			</div>
		    		</div>
	    		</div>
    			<div class="tab-cont-item" data-tab="2">
    				<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
							<c:forEach items="${arealist2}" var="vo">
								<div class="li-item swiper-slide">
									<a href="#">
										<div class="item-inner">
											<div class="item-img" style="background-image:url(${vo.cvo.first_image});">
											</div>
											<div class="text-wrap">
												<p class="title">${vo.cvo.title}</p>
												<c:choose>
													<c:when test="${vo.price==0}">
														<p class="price">무료</p>
													</c:when>
													<c:otherwise>
														<p class="price"><fmt:formatNumber value="${vo.price }" pattern="#,###" />원</p>
													</c:otherwise>
												</c:choose>
												<p class="score">
													<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
													<span>4.2</span>
												</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
		    			</div>
		    		</div>
    			</div>
    			<div class="tab-cont-item" data-tab="3">
    				<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
							<c:forEach items="${arealist3}" var="vo">
								<div class="li-item swiper-slide">
									<a href="#">
										<div class="item-inner">
											<div class="item-img" style="background-image:url(${vo.cvo.first_image});">
											</div>
											<div class="text-wrap">
												<p class="title">${vo.cvo.title}</p>
												<c:choose>
													<c:when test="${vo.price==0}">
														<p class="price">무료</p>
													</c:when>
													<c:otherwise>
														<p class="price"><fmt:formatNumber value="${vo.price }" pattern="#,###" />원</p>
													</c:otherwise>
												</c:choose>
												<p class="score">
													<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
													<span>4.2</span>
												</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
		    			</div>
		    		</div>
    			</div>
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
			<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">지금 예매 가능한 행사/공연</h3>
			<div class="tab-content-wrap wow fadeInUp" data-wow-delay="0.1s">
				<div class="tab-cont-item active" data-tab="1">
					<div class="swiper main-slide-list">
						<div class="swiper-wrapper">
							<c:forEach items="${musicalList }" var="vo">
								<div class="li-item swiper-slide">
									<a href="#">
										<div class="item-inner">
											<div class="item-img" style="background-image:url(${vo.cvo.first_image});">
											</div>
											<div class="text-wrap">
												<p class="date">[${vo.dbcate}]</p>
												<p class="title">${vo.cvo.title}</p>
												<p class="date">${vo.dbstart} ~ ${vo.dbend}</p>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
<script type="text/javascript">
	$(document).on("click","#event_sel_btn",function(){
		$(".event_main_sel_ul").fadeToggle(100);
	});
	$(document).on("click",".event_main_sel_ul button",function(){
		if($(this).attr("id")==="a1"){
			$("form[name=areaform] input#1").prop("checked",true);
		}else if($(this).attr("id")==="a2"){
			alert("부산");
		}
		let thisid=$(this).attr("id").substring(1);
		$("form[name=areaform] input").map(function(index,el){
			if($(el).attr("id")===thisid){
				$(el).prop("checked",true);
			}
		})

	});

</script>
</body>
</html>