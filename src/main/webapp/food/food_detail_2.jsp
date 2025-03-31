<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<html>
<link rel="stylesheet" href="../food/map.css">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=56b06fde10080b6a8a785311ba6b68d3&libraries=services"></script>
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
		
		 <%-- 지도 위치 --%>
		  <h3>주변 맛집</h3>
      <div class="map_wrap">
     
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <form onsubmit="searchPlaces(); return false;">
			                    키워드 : <input type="text" value="${addr } 맛집" id="keyword" size="15" readonly> 
			                 
			                </form>
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
			</div>
			</div>
			
			<script>
			// 마커를 담을 배열입니다
			var markers = [];
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();  
			
			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			// 키워드로 장소를 검색합니다
			searchPlaces();
			
			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {
			
			    var keyword = document.getElementById('keyword').value;
			
			    if (!keyword.replace(/^\s+|\s+$/g, '')) {
			        alert('키워드를 입력해주세요!');
			        return false;
			    }
			
			    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			    ps.keywordSearch( keyword, placesSearchCB); 
			}
			
			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
			
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출합니다
			        displayPlaces(data);
			
			        // 페이지 번호를 표출합니다
			        displayPagination(pagination);
			
			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
			
			        alert('검색 결과가 존재하지 않습니다.');
			        return;
			
			    } else if (status === kakao.maps.services.Status.ERROR) {
			
			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;
			
			    }
			}
			
			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {
			
			    var listEl = document.getElementById('placesList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			    
			    // 검색 결과 목록에 추가된 항목들을 제거합니다
			    removeAllChildNods(listEl);
			
			    // 지도에 표시되고 있는 마커를 제거합니다
			    removeMarker();
			    
			    for ( var i=0; i<places.length; i++ ) {
			
			        // 마커를 생성하고 지도에 표시합니다
			        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			            marker = addMarker(placePosition, i), 
			            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
			
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        bounds.extend(placePosition);
			
			        // 마커와 검색결과 항목에 mouseover 했을때
			        // 해당 장소에 인포윈도우에 장소명을 표시합니다
			        // mouseout 했을 때는 인포윈도우를 닫습니다
			        (function(marker, title) {
			            kakao.maps.event.addListener(marker, 'mouseover', function() {
			                displayInfowindow(marker, title);
			            });
			
			            kakao.maps.event.addListener(marker, 'mouseout', function() {
			                infowindow.close();
			            });
			
			            itemEl.onmouseover =  function () {
			                displayInfowindow(marker, title);
			            };
			
			            itemEl.onmouseout =  function () {
			                infowindow.close();
			            };
			        })(marker, places[i].place_name);
			
			        fragment.appendChild(itemEl);
			    }
			
			    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			    listEl.appendChild(fragment);
			    menuEl.scrollTop = 0;
			
			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    map.setBounds(bounds);
			}
			
			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {
			
			    var el = document.createElement('li'),
			    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
			                '<div class="info">' +
			                '   <h5>' + places.place_name + '</h5>';
			
			    if (places.road_address_name) {
			        itemStr += '    <span>' + places.road_address_name + '</span>' +
			                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
			    } else {
			        itemStr += '    <span>' +  places.address_name  + '</span>'; 
			    }
			                 
			      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
			                '</div>';           
			
			    el.innerHTML = itemStr;
			    el.className = 'item';
			
			    return el;
			}
			
			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			        imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        },
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage 
			        });
			
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
			
			    return marker;
			}
			
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
			
			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
			    var paginationEl = document.getElementById('pagination'),
			        fragment = document.createDocumentFragment(),
			        i; 
			
			    // 기존에 추가된 페이지번호를 삭제합니다
			    while (paginationEl.hasChildNodes()) {
			        paginationEl.removeChild (paginationEl.lastChild);
			    }
			
			    for (i=1; i<=pagination.last; i++) {
			        var el = document.createElement('a');
			        el.href = "#";
			        el.innerHTML = i;
			
			        if (i===pagination.current) {
			            el.className = 'on';
			        } else {
			            el.onclick = (function(i) {
			                return function() {
			                    pagination.gotoPage(i);
			                }
			            })(i);
			        }
			
			        fragment.appendChild(el);
			    }
			    paginationEl.appendChild(fragment);
			}
			
			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
			    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
			
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			}
			
			 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			</script>
		<div class="detail_subWrap scrollTab_cont" id="sub3">
			<div>
				<h4>
					댓글 <b class="text-blue">231</b>
				</h4>
				<div class="d-flex align-content-center flex-column flex-wrap">
					<div class="score-avg align-self-center py-3">
						<div class="bigstar">4.2</div>
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
