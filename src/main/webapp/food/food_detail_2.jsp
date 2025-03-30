<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<html>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/assets/plugin/swiper/swiper-bundle.min.js"></script>
<style type="text/css">
div#carouselExampleControls {
	width: 50%;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
$(function(){
    $('.updates').click(function(){
        let no = $(this).attr("data-no");
        let isVisible = $('#up' + no).is(':visible');
        
        $('.ups').hide();
        $(".updates").text("수정");

        if (!isVisible) {
            $(this).text("취소");
            $('#up' + rno).show();
        } else {
            $(this).text("수정");
            $('#up' + rno).hide();
        }
    });
}); 

// 댓글 수정 폼을 표시하는 함수
function editComment(no, message) {
    $('#editForm_' + no).show();
    $('#editMessage_' + no).val(message);
}

// 댓글 저장 함수 (AJAX로 수정)
function saveComment(no) {
    var message = $('#editMessage_' + no).val();
    $.ajax({
        url: 'food_review_update_process.do',
        type: 'POST',
        data: {
            no: no,
            message: message
        },
        success: function(response) {
            // 수정된 댓글 반영
            $('#comment_' + no).html("<p>" + message + "</p><button onclick='editComment(" + no + ", \"" + message + "\")'>수정</button>");
            $('#editForm_' + no).hide();  // 수정 폼 숨기기
        },
        error: function() {
            alert('댓글 수정에 실패했습니다.');
        }
    });
}

</script>
<body>
	<div class="container mini px-0">
	<div class="container-xxl py-3 px-0">
					<div class="container">
							
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i> 맛집</li>
                            <li class="breadcrumb-item"><a href="#">${vo.type }</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${vo.name }</li>
                        </ol>
            </div>
			<h2 id="topTitle" class="text-center">${vo.name }</h2>
			<div class="address text-center" id="topAddr">
				<span>${vo.address }</span>
			</div>
		</div>
		<div id="carouselExampleControls" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<c:if test="${not empty vo.images}">
					<c:forTokens items="${vo.images}" delims="," var="img"
						varStatus="status">
						<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
							<img src="http://www.menupan.com${img}" class="d-block w-100"
								alt="${vo.name } 이미지">
						</div>
					</c:forTokens>
				</c:if>
				<c:if test="${empty vo.images}">
					<div class="carousel-item active">
						<img src="https://via.placeholder.com/800x400?text=No+Image"
							class="d-block w-100" alt="No Image">
					</div>
				</c:if>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

		<div class="detail_titleWrap">
			
				<div class="detail_btnWrap" style="float:right">
					<button type="button" class="bookmark-btn"></button>
					<button type="button" class="share-btn"></button>
				</div>
			<a href="../food/food_reserve.do?fno=${vo.fno }&name=${vo.name}"><button
					class="buy-btn btn-black mt-3">예약하기</button></a>
		</div>
		<%--        .scrollTab > div.item > button의 data-target과
            .scrollTab_cont의 id를 같은 값으로 설정--%>
		<div class="detail_tab scrollTab">
			<div class="tabWrap container">
				<div class="item">
					<button type="button" data-target="sub1">소개</button>
				</div>
				<div class="item">
					<button type="button" data-target="sub2">맛집정보</button>
				</div>
				<div class="item">
					<button type="button" data-target="sub3">리뷰</button>
				</div>
			</div>
		</div>
		<div class="detail_subWrap scrollTab_cont" id="sub1">
			<div>
				<h4>맛집소개</h4>
				<p>${vo.content }</p>
			</div>
		</div>
		<div class="detail_subWrap scrollTab_cont" id="sub2">
			<div>
				<h4>맛집 유형</h4>
				<p>${vo.type}</p>
				<h4>주소</h4>
				<p>${vo.address }</p>

				<h4>운영 시간</h4>
				<p>${vo.time}</p>


				<h4>가격대</h4>
				<p>${vo.price}</p>


				<h4>주차</h4>
				<p>${vo.parking}</p>


				<h4>테마</h4>
				<p>${vo.theme}</p>


				<h4>전화</h4>
				<p>${vo.phone}</p>
			</div>
		</div>
		<div class="detail_subWrap scrollTab_cont" id="sub3">
			<div>
				<h4>
					리뷰 <b class="text-blue">231</b>
				</h4>
				<div class="d-flex align-content-center flex-column flex-wrap">
					<div class="score-avg align-self-center py-3">
						<div class="bigstar">4.2</div>
					</div>
					<div class="pt-3">
						<select class="form-select filter-sm" aria-label="Default select">
							<option value="0" selected>최신순</option>
							<option value="1">평가 높은순</option>
						</select>
					</div>
					<ul class="review-ul">
						<c:forEach var="rvo" items="${rList }">
							<li>
								<div class="review-header">
									<div class="user-name d-flex align-items-center">

										<div class="user-pf" style="background-image:${userprofile}"></div>
										<div class="d-flex flex-column">
											<div class="user-score" data-score="${rvo.rate}">
												<div class="star"></div>
												<div class="star"></div>
												<div class="star"></div>
												<div class="star"></div>
												<div class="star"></div>
											</div>
											<p class="name">${rvo.user_id }<span class="created-time">${rvo.dbday }</span>
											</p>
										</div>

									</div>
								</div>
								
								
									
										<div class="comment" id="comment_${rvo.no}">
											
											<button onclick="editComment(${rvo.no}, '${rvo.message}')">수정</button>
												<c:if test="${sessionScope.user_id==rvo.user_id }">
											<!-- 댓글 수정 폼 -->
											<div id="editForm_${rvo.no}" style="display: none;">
												<textarea id="editMessage_${rvo.no}">${rvo.message}</textarea>
												<button onclick="saveComment(${rvo.no})">저장</button>
											</div>
											</c:if>
										</div>
								
									<a
										href="../food/food_review_delete.do?no=${rvo.no }&fno=${vo.fno}"
										class="active">삭제</a>

									<div class="comment-form ups" style="display: none"
										id="${rvo.no }">

										<form action="../food/food_review_update.do" method="post">

											<div class="form-group">
												<textarea name="message" id="message" cols="50" rows="3"
													placeholder="Message" style="float: left" required>${rvo.message }</textarea>

												<input type=hidden name="no" value="${rvo.no }">
												<button type="submit" class="btn btn-primary"
													style="width: 100px; height: 85px; float: left">댓글수정</button>
											</div>

										</form>
									</div>
								
							</li>
						</c:forEach>
				
					</ul>
					<button class="morebtn btn-white">리뷰 전체보기</button>
					<c:if test="${not empty sessionScope.user_id}">
						<div class="comment-form">

							<form action="../food/food_review_insert.do" method="post">
								<div class="form-group">

									<textarea name="message" id="message" cols="80" rows="4"
										placeholder="리뷰를 입력하세요" required></textarea>
									<input type="hidden" name="type" value="4"> <input
										type="hidden" name="fno" value="${vo.fno }">
									<button type="submit" class="btn btn-primary">댓글쓰기</button>
								</div>
							</form>

						</div>
				</div>
			</div>

			</c:if>
		</div>


	</div>
	<div class="detail_subWrap">
		<h4 class="pb-2 mt-3">최근 본 맛집</h4>
		<div class="swiper main-slide-list">
			<div class="swiper-wrapper">
				<c:forEach items="${foodHistory }" var="food">
					<div class="li-item swiper-slide">
						<a href="../food/food_detail.do?fno=${food.fno}">
							<div class="item-inner">
								<div class="item-img"
									style="background-image:url('http://www.menupan.com${food.poster}');">
								</div>
								<div class="text-wrap">
									<p class="date">${food.type}</p>
									<p class="title">${food.name}</p>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	</div>


	<script type="text/javascript">
        //Image Slide
        lightGallery(document.getElementById('my-gallery'), {
            thumbnail: true,
            selector: '.item'
        });

        //tab
        //scroll 시 sticky, active
        window.addEventListener('scroll',() => {
            let curScroll = window.scrollY+$("nav").outerHeight();
            let trigger = $(".scrollTab").offset().top;
            let trigger2 = $(".tabWrap").offset().top+$(".tabWrap").outerHeight(); //sticky 상태의 header offset bottom
            if(curScroll>trigger) {
                $(".tabWrap").addClass("sticky");
            }else{
                $(".tabWrap").removeClass("sticky");
            }
            $(".scrollTab_cont").map(function(index, elem){
                let dataId=$(elem).attr("id");
                if(trigger2>$(elem).offset().top&&trigger2<$(elem).offset().top+$(elem).outerHeight()){ //각 탭 컨텐츠 영역 진입 시 해당 탭에 active 추가
                    $(".scrollTab .item").removeClass("active");
                    $(".scrollTab button[data-target="+dataId+"]").parent(".item").addClass("active");
                }
            });
        });

        //tab
        $(document).on("click",".scrollTab button",function(e){ //탭 클릭 시 해당 영역으로 이동
            let target=$(e.target).attr("data-target");
            let targetTop=$("#"+target).offset().top; //탭 컨텐츠 offset top
            let headerHeight = $("nav").outerHeight() + $(".tabWrap").outerHeight(); //sticky 탭 포함 헤더 높이
            $('html').scrollTop(targetTop-headerHeight+3);
        });

        //리뷰 더보기 버튼
        $(document).on("click",".cont-morebtn",function(){
           $(this).closest("li").addClass("show");
           $(this).remove();
        });

        //리뷰 길이 세 줄 초과일 때만 더보기 버튼
        let contents = document.querySelectorAll(".review-cont");
        contents.forEach(function(el,index){
            let morebtn=document.createElement("button");
            morebtn.setAttribute("type","button");
            morebtn.classList.add("cont-morebtn");
            if(el.scrollHeight>el.clientHeight){
                el.parentNode.appendChild(morebtn);
            }
        });

        //슬라이드
        const swiper = new Swiper('.main-slide-list', {
            loop: false,
            navigation: false,

            breakpoints: {
                0:{
                    slidesPerView: 3,  //브라우저가 0보다 클 때
                    spaceBetween: 10,
                },
                768: {
                    slidesPerView: 4,  //브라우저가 768보다 클 때
                    spaceBetween: 10,
                },
                991: {
                    slidesPerView: 5,  //브라우저가 991보다 클 때
                    spaceBetween: 10,
                },
                1200: {
                    slidesPerView: 5,  //브라우저가 1200보다 클 때
                    spaceBetween: 10,
                },
            },
        });
    </script>
</body>
</html>
