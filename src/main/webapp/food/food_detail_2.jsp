<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=56b06fde10080b6a8a785311ba6b68d3"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/assets/plugin/swiper/swiper-bundle.min.js"></script>
<body>
    <div class="container mini px-0">
        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <c:if test="${not empty vo.images}">
      <c:forTokens items="${vo.images}" delims="," var="img" varStatus="status">
        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
          <img src="http://www.menupan.com${img}" class="d-block w-100" alt="${vo.name } 이미지">
        </div>
      </c:forTokens>
    </c:if>
    <c:if test="${empty vo.images}">
      <div class="carousel-item active">
        <img src="https://via.placeholder.com/800x400?text=No+Image" class="d-block w-100" alt="No Image">
      </div>
    </c:if>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

        <div class="detail_titleWrap">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <p class="type">${vo.type}</p>
                    <p class="name">${vo.name}</p>
                </div>
                <div class="detail_btnWrap">
                    <button type="button" class="bookmark-btn"></button>
                    <button type="button" class="share-btn"></button>
                </div>
            </div>
            <p class="location">${vo.address}</p>
            <a href="../food/food_reserve.do?fno=${vo.fno }"><button class="buy-btn btn-black mt-3" id="openModal"> 예약하기</button></a>
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
   
                <h4>오시는 길</h4>
                <div id="map" style="width:100%; height:400px;"><a href="https://map.kakao.com/link/to/${vo.address }" target="_blank" class="findWay">길 찾기</a></div>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub3">
            <div>
                <h4>리뷰 <b class="text-blue">231</b></h4>
                <div class="d-flex align-content-center flex-column flex-wrap">
                    <div class="score-avg align-self-center py-3">
                        <div class="bigstar">
                            4.2
                        </div>
                    </div>
                    <div class="pt-3">
                        <select class="form-select filter-sm" aria-label="Default select">
                            <option value="0" selected>최신순</option>
                            <option value="1">평가 높은순</option>
                        </select>
                    </div>
                    <ul class="review-ul">
                        <c:forEach begin="1" end="3" var="i">
                            <li>
                                <div class="review-header">
                                    <div class="user-name d-flex align-items-center">
                                        <div class="user-pf" style="background-image:${userprofile}"></div>
                                        <div class="d-flex flex-column">
                                            <div class="user-score" data-score="${i}">
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                            </div>
                                            <p class="name">홍길동<span class="created-time">2025년 3월 12일</span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-cont">
                                    세 줄 이상일 때만 말줄임표 + 더보기 버튼 내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <button class="morebtn btn-white">리뷰 전체보기</button>
                </div>
            </div>
        </div>
        <div class="detail_subWrap">
        <div>
        <h4 class="pb-2 mt-3">최근 본 맛집</h4>
                <div class="swiper main-slide-list">
                    <div class="swiper-wrapper">
                    <c:if test="${not empty foodHistory}">
    <div class="food-history">  <!-- 가로 정렬을 위한 부모 div -->
        <c:forEach var="food" items="${foodHistory}">
            <div class="food-item">
                <a href="../food/food_detail.do?fno=${food.fno}">
                    <img src="http://www.menupan.com${food.poster}" alt="${food.name}">
                    <p>${food.name}</p>
                </a>
            </div>
        </c:forEach>
    </div>
</c:if>
                        <%-- <c:forEach var="c" items="${cookie}">
    <c:if test="${fn:startsWith(c.key, 'food_')}">
        <p>최근 본 음식: ${c.value.value}</p>
    </c:if>
</c:forEach> --%>
                        
                    </div>
                </div>
            </div>
        </div>
        <%-- <div class="detail_subWrap">
            <div>
                <h4 class="pb-2">이 근처 숙소 찾기</h4>
                <div class="swiper main-slide-list">
                    <div class="swiper-wrapper">
                        <c:forEach items="${nearlist }" var="vo">
                            <div class="li-item swiper-slide">
                                <a href="../hotel/hotel_detail.do?content_id=${vo.cvo.content_id}">
                                    <div class="item-inner">
                                        <div class="item-img" style="background-image:url(${vo.cvo.first_image});">
                                        </div>
                                        <div class="text-wrap">
                                            <p class="date">${vo.cvo.cat3}</p>
                                            <p class="title">${vo.cvo.title}</p>
                                            <p class="price">${vo.hrvo.offseason_minfee1}원</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
             --%>
    </div>
   <%--  <div class="buy-wrap">
        <ul class="buy-ul">
            <li class="d-flex justify-content-between align-items-center"> li = 구매 아이템
                <div>
                    <p class="product">입장권</p>
                    <p class="prod-price">
                        <c:choose>
                            <c:when test="${vo.price eq 0}">
                                무료
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${vo.price }" pattern="#,###" />원
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="countwrap">
                    <button type="button" class="count-down">-</button><input type="text" name="product_count" value="0" disabled><button type="button" class="count-up">+</button>
                </div>
            </li>
            <li class="d-flex justify-content-end">
                <div>
                    <p class="product">합계</p>
                    <p class="totalPrice">0원</p>
                </div>
            </li>
            <li class="submitwrap">
                <button type="button" class="buynow">바로구매</button>
                <button type="button" class="cart">장바구니</button>
            </li>
        </ul>
    </div> --%>
    <script type="text/javascript">
        //Image Slide
        lightGallery(document.getElementById('my-gallery'), {
            thumbnail: true,
            selector: '.item'
        });

        //구매 팝업
        $(document).on("click","#buybtn",function(){
            $(".buy-wrap").addClass("active");
            $(".buy-wrap").removeClass("off");
        });
        $(document).on("click",".buy-wrap",function(e){
            if(e.target!==this) return
            $(".buy-wrap").removeClass("active");
            $(".buy-wrap").addClass("off");
        });
        let total=0;
        $(document).on("click",".countwrap button",function(e){
            var el=$(e.target).closest("li").find(".prod-price");
            var str = el.text().trim();
            console.log(str);
            if(str=="무료") str="0";
            var regex = /[^0-9]/g;
            var result = str.replace(regex, "");
            let count=Number($(e.target).siblings("input[name=product_count]").val());
            if($(e.target).hasClass("count-down")){
               if(count>0){
                   $(e.target).siblings("input[name=product_count]").val(count-1);
                   total-=parseInt(result);
               }
            }else if($(e.target).hasClass("count-up")){
               if(count<10){
                   $(e.target).siblings("input[name=product_count]").val(count+1);
                   total+=parseInt(result);
               }
            }
            $(".totalPrice").text(total.toLocaleString('ko-KR')+'원');

        });
        
		// 카카오맵
        document.addEventListener("DOMContentLoaded", function() {
            var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
            var mapOption = {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // 기본 좌표 (서울시청)
                level: 3 // 지도 확대 레벨
            };

            // 지도를 생성합니다    
            var map = new kakao.maps.Map(mapContainer, mapOption); 

            // 주소-좌표 변환 객체 생성
            var geocoder = new kakao.maps.services.Geocoder();

            // 주소 값이 존재하는지 확인
            var address = '${vo.address}';
            if (!address || address.trim() === "") {
                console.warn("주소 정보가 없습니다.");
                return;
            }

            // 주소로 좌표를 검색
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 결과 위치를 마커로 표시
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 인포윈도우에 `vo.name` 적용
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">${vo.name}</div>'
                    });
                    infowindow.open(map, marker);

                    // 지도 중심 이동
                    map.setCenter(coords);
                } else {
                    console.error("주소 검색 실패:", status);
                }
            });
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
