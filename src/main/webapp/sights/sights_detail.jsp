<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f15eb727df3c1fb9de2ce170ebb6f7a0"></script>
<script src="/assets/plugin/swiper/swiper-bundle.min.js"></script>
<body>
    <div class="container mini px-0">
        <div class="thumb_list${fn:length(imglist)<2?' nosub':''}" id="my-gallery">
            <a href="${vo.first_image }" class="item">
                <img alt="" src="${vo.first_image }">
            </a>
            <c:if test="${not empty imglist}">
                <div class="sublist">
                    <c:forEach var="dvo" items="${imglist }" begin="0" varStatus="i">
                        <a href="${dvo.divo.origin_img }"  class="item">
                            <img alt="image${i.index}" src="${dvo.divo.thumb_img }">
                            <c:if test="${i.index eq 1 && fn:length(imglist)>2 }">
                                <p>+${fn:length(imglist)-2 }</p>
                            </c:if>
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <div class="detail_titleWrap">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <p class="cate">${vo.cat3}</p>
                    <p class="title">${vo.title}</p>
                </div>
                <div class="detail_btnWrap">
                    <button type="button" class="bookmark-btn"></button>
                    <button type="button" class="share-btn"></button>
                </div>
            </div>
            <p class="location">${vo.addr1}</p>

            
        </div>
<%--        .scrollTab > div.item > button의 data-target과
            .scrollTab_cont의 id를 같은 값으로 설정--%>
        <div class="detail_tab scrollTab">
            <div class="tabWrap container">
                <div class="item">
                    <button type="button" data-target="sub1">소개</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub2">관광지정보</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub3">리뷰</button>
                </div>
            </div>
        </div>
        <!-- vo.info -->
        <div class="detail_subWrap scrollTab_cont" id="sub2">
            <div>
            	<img alt="" src="${vo.first_image }">
                <h4>관광지 이름</h4>
                <p>${vo.title}</p>
                
                <h4>관광지 분류</h4>
                <p>${vo.cat3}</p>
                
                <h4>장소</h4>
                <p>${vo.addr1} ${not empty vo.addr2&&vo.addr2 ne 'N/A'?vo.addr2:''}</p>
				<h4>운영 시간</h4>
                    <p>24시간</p>
                <c:if test="">
                    
                </c:if>
  
                <h4>관광지 위치 & 오시는 길</h4>
                <div id="map" style="width:100%; height:400px;"><a href="https://map.kakao.com/link/to/${vo.title},${vo.mapy},${vo.mapx}" target="_blank" class="findWay">길 찾기</a></div>
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
                        <c:forEach begin="1" end="3" var="i" items="${rList }">
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
                                  ${i.message }
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <button class="morebtn btn-white">리뷰 전체보기</button>
                    
                    <tr>
                    <div class="user_text_review">
                       <c:if test="${sessionScope.user_id!=null }">
                         <div class="leave-comment-area section_padding_50 clearfix">
                                <div class="comment-form">
                                  
                                    <form action="sights_review_insert.do" method="post">
                                        
                                        <div class="form-group mt-3" >
                                            <textarea name="msg" id="msg" cols="70" rows="4" placeholder="리뷰내용" style="float: left" required></textarea>
                                            <input type=hidden name="type" value="5">
                                            <input type=hidden name="content_id" value="${vo.content_id }">
                                            <button type="submit" class="btn btn-primary" style="width:60px;height: 100px; float: left">리뷰쓰기</button>
                                        </div>
                                        
                                    </form>
                                </div>
                            </div>
                       </c:if>
                    </div>
                    </tr>
                </div>
            </div>
        </div>
        <div class="detail_subWrap">
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
                <h4 class="pb-2 mt-3">최근 확인한 관광지</h4>
                <div class="swiper main-slide-list">
                    <div class="swiper-wrapper">
                        <c:forEach items="${clist }" var="vo">
                            <div class="li-item swiper-slide">
                                <a href="../sights/sights_detail.do?content_id=${vo.cvo.content_id}">
                                    <div class="item-inner">
                                        <div class="item-img" style="background-image:url(${vo.cvo.first_image});">
                                        </div>
                                        <div class="text-wrap">
                                            <p class="date">${vo.cvo.cat3}</p>
                                            <p class="title">${vo.cvo.title}</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <a href="javascript:history.back()" class="btn btn-sm btn-primary">목록으로 돌아가기</a>
            </div>
        </div>
    </div>
    <!-- div buy class -->
    
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

        //kakao map
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(${vo.mapy},${vo.mapx}), //지도의 중심좌표.
            // level: 3 //지도의 레벨(확대, 축소 정도)
        };
        var markerPosition  = new kakao.maps.LatLng(${vo.mapy},${vo.mapx});
        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        marker.setMap(map);

        var mapTypeControl = new kakao.maps.MapTypeControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

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
