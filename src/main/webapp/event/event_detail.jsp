<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f15eb727df3c1fb9de2ce170ebb6f7a0"></script>
<body>
    <div class="container mini px-0">
        <div class="thumb_list${fn:length(imglist)<2?' nosub':''}" id="my-gallery">
            <a href="${vo.cvo.first_image }" class="item">
                <img alt="" src="${vo.cvo.first_image }">
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
                    <p class="cate">${vo.dbcate}</p>
                    <p class="title">${vo.cvo.title}</p>
                </div>
                <div class="detail_btnWrap">
                    <button type="button" class="bookmark-btn"></button>
                    <button type="button" class="share-btn"></button>
                </div>
            </div>
            <p class="location">${vo.cvo.addr1}</p>
            <p class="eventdate"><b>${vo.dbstart}</b>부터 <b>${vo.dbend}</b>까지</p>
            <button class="buy-btn btn-black mt-3" id="buybtn">입장권 구매하기</button>
        </div>
<%--        .scrollTab > div.item > button의 data-target과
            .scrollTab_cont의 id를 같은 값으로 설정--%>
        <div class="detail_tab scrollTab">
            <div class="tabWrap container">
                <div class="item">
                    <button type="button" data-target="sub1">소개</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub2">행사정보</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub3">리뷰</button>
                </div>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub1">
            <div>
                <c:forEach items="${infolist}" var="info">
                    <h4>${info.dvo.infoname}</h4>
                    <p>${info.dvo.infotext}</p>
                </c:forEach>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub2">
            <div>
                <h4>행사 이름</h4>
                <p>${vo.cvo.title}</p>
                <h4>장소</h4>
                <p>${vo.cvo.addr1} ${not empty vo.cvo.addr2&&vo.cvo.addr2 ne 'N/A'?vo.cvo.addr2:''}</p>
                <h4>기간</h4>
                <p>${vo.dbstart}부터 ${vo.dbend}까지</p>
                <c:if test="${not empty vo.playtime&&vo.playtime ne 'N/A'}">
                    <h4>운영 시간</h4>
                    <p>${vo.playtime}</p>
                </c:if>
                <c:if test="${not empty vo.charge&&vo.charge ne 'N/A'}">
                    <h4>요금</h4>
                    <p>${vo.charge}</p>
                </c:if>
                <c:if test="${not empty vo.spendtime&&vo.spendtime ne 'N/A'}">
                    <h4>관람 소요 시간</h4>
                    <p>${vo.spendtime}</p>
                </c:if>
                <c:if test="${not empty vo.agelimit&&vo.agelimit ne 'N/A'}">
                    <h4>관람 가능 연령</h4>
                    <p>${vo.agelimit}</p>
                </c:if>
                <c:if test="${not empty vo.sponsor1&&vo.sponsor1 ne 'N/A'}">
                    <h4>주최자</h4>
                    <p>${vo.sponsor1}</p>
                </c:if>
                <c:if test="${not empty vo.sponsor2&&vo.sponsor2 ne 'N/A'}">
                    <h4>주관사</h4>
                    <p>${vo.sponsor2}</p>
                </c:if>
                <h4>오시는 길</h4>
                <div id="map" style="width:100%; height:400px;"><a href="https://map.kakao.com/link/to/${vo.cvo.title},${vo.cvo.mapy},${vo.cvo.mapx}" target="_blank" class="findWay">길 찾기</a></div>

            </div>
            <div>

            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub3">
            리뷰영역
        </div>
    </div>
    <div class="buy-wrap">
        <ul class="buy-ul">
            <li class="d-flex justify-content-between align-items-center">
                <div>
                    <p class="product">입장권</p>
                    <p class="price">${vo.price eq 0?'무료':vo.price}</p>
                </div>
                <div class="countwrap">
                    <button type="button" class="count-down">-</button><input type="text" name="product_count" value="1" disabled><button type="button" class="count-up">+</button>
                </div>
            </li>
            <li class="submitwrap">
                <button type="button" class="buynow">바로구매</button>
                <button type="button" class="cart">장바구니</button>
            </li>
        </ul>
    </div>
    <script type="text/javascript">
        //Image Slide
        lightGallery(document.getElementById('my-gallery'), {
            thumbnail: true,
            selector: '.item'
        });
        $(document).on("click","#buybtn",function(){
            $(".buy-wrap").addClass("active");
            $(".buy-wrap").removeClass("off");
        });
        $(document).on("click",".buy-wrap",function(e){
            if(e.target!==this) return
            $(".buy-wrap").removeClass("active");
            $(".buy-wrap").addClass("off");
        });
        $(document).on("click",".countwrap button",function(e){
           if($(e.target).hasClass("count-down")){
               let count=Number($("input[name=product_count]").val());
               if(count>0){
                   $("input[name=product_count]").val(count-1);
               }
           }else if($(e.target).hasClass("count-up")){
               let count=Number($("input[name=product_count]").val());
               if(count<10){
                   $("input[name=product_count]").val(count+1);
               }
           }
        });

        //kakao map
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(${vo.cvo.mapy},${vo.cvo.mapx}), //지도의 중심좌표.
            // level: 3 //지도의 레벨(확대, 축소 정도)
        };
        var markerPosition  = new kakao.maps.LatLng(${vo.cvo.mapy},${vo.cvo.mapx});
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
        $(document).on("click",".scrollTab button",function(e){ //탭 클릭 시 해당 영역으로 이동
            let target=$(e.target).attr("data-target");
            let targetTop=$("#"+target).offset().top; //탭 컨텐츠 offset top
            let headerHeight = $("nav").outerHeight() + $(".tabWrap").outerHeight(); //sticky 탭 포함 헤더 높이
            $('html').scrollTop(targetTop-headerHeight+3);
        });
    </script>
</body>
</html>
