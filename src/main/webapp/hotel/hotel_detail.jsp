<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<style type="text/css">
.text-container {
    display: block;
    max-height: 9em; 
    overflow: hidden;
    word-wrap: break-word; 
    word-break: break-word; 
    position: relative;
    transition: max-height 0.3s ease;
}

.text-container::after {
    content: "...";
    position: absolute;
    bottom: 0;
    right: 0;
    background: white;
    padding-left: 5px;
    display: none; 
}

.text-container.expanded::after {
    content: ""; 
}

.text-container:not(.expanded):not(.short-text)::after {
    display: block;
}

.short-text {
    max-height: none !important;
    overflow: visible !important;
}
.more-btn {
    cursor: pointer;
    color: #888;
    text-decoration: none;
    font-weight: 600;
    margin-left: 5px;
}
.rsv-card,
.rsv-card * {
  box-sizing: border-box;
}
.rsv-card {
    background: #F5F7FA;
    border-radius: var(--corner-large, 16px);
    padding: 10px;
    display: flex;
    flex-direction: row;
    gap: 18px;
    align-items: flex-start;
    justify-content: flex-start;
    height: 450px;
    position: relative;
    margin-bottom: 10px;
}
.rectangle-2 {
  border-radius: var(--corner-large, 16px);
  flex-shrink: 0;
  width: 216px;
  height: 161px;
  position: relative;
  object-fit: cover;
}
.frame-1321316147 {
  padding: 206px 11px 206px 11px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  align-items: flex-start;
  justify-content: flex-start;
  flex-shrink: 0;
  width: 410px;
  height: 421px;
  position: relative;
}
.frame-1321316146 {
  display: flex;
  flex-direction: column;
  gap: 17px;
  align-items: flex-start;
  justify-content: flex-start;
  flex-shrink: 0;
  width: 410px;
  position: absolute;
  left: 0px;
  top: 0px;
}
.div {
  color: #000000;
  text-align: left;
  font-size: 24px;
  font-weight: 700;
  position: relative;
  align-self: stretch;
}
.frame-1321316144 {
  background: #FFFFFF;
  border-radius: var(--corner-large, 16px);
  padding: 10px;
  display: flex;
  flex-direction: column;
  gap: 76px;
  align-items: flex-start;
  justify-content: flex-start;
  align-self: stretch;
  flex-shrink: 0;
  position: relative;
}
.frame-1321316142 {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  justify-content: space-between;
  align-self: stretch;
  flex-shrink: 0;
  position: relative;
}
.rsv-time-day {
  display: flex;
  flex-direction: column;
  gap: 12px;
  align-items: flex-start;
  justify-content: flex-start;
  flex-shrink: 0;
  position: relative;
}
.div2 {
  color: #000000;
  text-align: left;
  font-size: 20px;
  font-weight: 700;
  position: relative;
  align-self: stretch;
}
._4 {
    color: #000000;
    text-align: left;
    font-size: 10px;
    font-weight: 700;
    position: relative;
    opacity: 0.5;
}
.rsv-day {
    display: flex;
    flex-direction: column;
    gap: 45px;
    align-items: flex-start;
    justify-content: flex-start;
    flex-shrink: 0;
    width: 100px;
    position: relative;
}
._50-000 {
  color: #000000;
  text-align: right;
  font-size: 20px;
  font-weight: 700;
  position: relative;
}
.reservation-button {
    background: #1D8BFF;
    border-radius: var(--corner-large, 16px);
    border: 1px solid rgba(0, 0, 0, 0.2);
    padding: 10px 31px 10px 31px;
    display: flex;
    flex-direction: row;
    gap: 10px;
    align-items: center;
    justify-content: center;
    align-self: stretch;
    flex-shrink: 0;
    height: 40px;
    position: relative;
    max-width: fit-content;
}
.div3 {
  color: #f7f7f7;
  text-align: left;
  font-size: 15px;
  font-weight: 700;
  position: relative;
}
.frame-1321316143 {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  justify-content: space-between;
  align-self: stretch;
  flex-shrink: 0;
  position: relative;
}
.rsv-time-stay {
  display: flex;
  flex-direction: column;
  gap: 12px;
  align-items: flex-start;
  justify-content: flex-start;
  flex-shrink: 0;
  width: 105px;
  position: relative;
}
.div4 {
  color: #000000;
  text-align: left;
  font-size: 20px;
  font-weight: 700;
  position: relative;
}
._18-00-12-00 {
    color: #000000;
    text-align: left;
    font-size: 10px;
    font-weight: 700;
    position: relative;
    opacity: 0.5;
}
.rsv-stay {
    display: flex;
    flex-direction: column;
    gap: 45px;
    align-items: flex-start;
    justify-content: flex-start;
    flex-shrink: 0;
    width: 100px;
    position: relative;
}
.frame-1321316145 {
  background: #fbfbfb;
  border-radius: var(--corner-large, 16px);
  padding: 8px 16px 8px 16px;
  display: flex;
  flex-direction: row;
  gap: 10px;
  align-items: center;
  justify-content: flex-start;
  align-self: stretch;
  flex-shrink: 0;
  height: 34px;
  position: relative;
}
._2-tv {
  color: #000000;
  text-align: left;
  font-size: 14px;
  font-weight: 700;
  position: relative;
}
.vector-1 {
  flex-shrink: 0;
  width: 387.5px;
  height: 0px;
  position: relative;
  overflow: visible;
}
button:disabled {
    background-color: #d3d3d3; 
    color: #a9a9a9; 
}
.form-floating .form-control {
	overflow-y: auto;
	resize: none; 
}
.input-group > .form-control, .input-group > .form-select {
    position: relative;
    flex: 1 1 auto;
    width: 1%;
    min-width: 610px;
}
#update {
	margin-left: 10px;
}
</style>
<script type="text/javascript">
$(function() {
    $(".more-btn").each(function() {
        let $text = $(this).prev(".text-container");
        
        
        if ($text[0].scrollHeight <= $text[0].clientHeight) {
            $(this).hide();  
            $text.addClass("short-text"); 
        } else {
            $text.removeClass("short-text"); 
        }
    });

    $(".more-btn").click(function() {
        let $text = $(this).prev(".text-container");

        if ($text.hasClass("expanded")) {
            $text.removeClass("expanded").css("max-height", "9em");
            $(this).text("더보기");
        } else {
            $text.addClass("expanded").css("max-height", "none");
            $(this).text("닫기");
        }
    });
});

</script>
</head>
<body>
    <div class="container mini px-0">
        <div class="thumb_list${fn:length(imglist) < 2 ?' nosub' : ''}" id="my-gallery">
        <c:choose>
        	<c:when test="${not empty vo.cvo.first_image and vo.cvo.first_image ne 'N/A'}">
            <a href="${vo.cvo.first_image }" class="item">
                <img alt="" src="${vo.cvo.first_image }">
            </a>
            </c:when>
            <c:otherwise>
            <a href="../assets/img/no_image.jpg" class="item">
            	<img src="../assets/img/no_image.jpg">
            </a>
            </c:otherwise>
        </c:choose>
            <c:if test="${not empty imglist}">
                <div class="sublist">
                    <c:forEach var="dvo" items="${imglist }" begin="0" varStatus="i">
                        <a href="${dvo.hdivo.origin_img }"  class="item">
                            <img alt="image${i.index}" src="${dvo.hdivo.thumb_img }">
                            <c:if test="${i.index eq 1 && fn:length(imglist) > 2 }">
                                <p>+${fn:length(imglist) - 2 }</p>
                            </c:if>
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <div class="detail_titleWrap">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <p class="cate">${vo.cvo.cat3}</p>
                    <p class="title">${vo.cvo.title}</p>
                </div>
                <div class="detail_btnWrap">
                    <button type="button" class="bookmark-btn"></button>
                    <button type="button" class="share-btn"></button>
                </div>
            </div>
            <p class="location">${vo.cvo.addr1}</p>
             
            
        </div>
<%--        .scrollTab > div.item > button의 data-target과
            .scrollTab_cont의 id를 같은 값으로 설정--%>
        <div class="detail_tab scrollTab">
            <div class="tabWrap container">
                <div class="item">
                    <button type="button" data-target="sub1">소개</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub2">객실</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub3">지도</button>
                </div>
                <div class="item">
                    <button type="button" data-target="sub4">리뷰</button>
                </div>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub1">
            <div>
            	<h4>숙소 이름</h4>
	            <p>${vo.cvo.title}</p>
	            <h4>주소</h4>
	            <p>${vo.cvo.addr1} ${not empty vo.cvo.addr2&&vo.cvo.addr2 ne 'N/A' ? vo.cvo.addr2 : ''}</p>
	            <h4>숙소 소개</h4>
	            <p class="text-container">${vo.cvo.overview}</p><span class="more-btn">더보기</span>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub2">
        	<c:forEach var="hrvo" items="${list }">
        	<div class="rsv-card">
			  <img class="rectangle-2" src="${hrvo.img1 }" />
			  <div class="frame-1321316147">
			    <div class="frame-1321316146">
			      <div class="div">${hrvo.roomtitle}</div>
			      <div class="frame-1321316144">
			        <div class="frame-1321316142">
			          <div class="rsv-time-day">
			            <div class="div2">대실</div>
			            <div class="_4">4시간 이용</div>
			          </div>
			          <div class="rsv-day">
			            <div class="_50-000">
			            	<c:choose>
			            		<c:when test="${hrvo.offseason_minfee1 == 0 or hrvo.offseason_minfee1 == '0'}">
			            			해당 업소 문의
			            		</c:when>
			            		<c:otherwise>
			            			<fmt:formatNumber value="${hrvo.offseason_minfee1}" pattern="#,###" /> 원
			            		</c:otherwise>
			            	</c:choose>
			            </div>
			            <form method="post" action="../reservation/reservation.do">
			            	<input type="hidden" name="room_id" value="${hrvo.room_id }">
			            	<input type="hidden" name="content_id" value="${vo.cvo.content_id }">
			            	<button class="reservation-button" id="day-button${hrvo.room_id }" type="submit"
                                        <c:if test="${hrvo.offseason_minfee1 == 0 or hrvo.offseason_minfee1 == '0'}">
                                            disabled
                                        </c:if>>
			              	<div class="div3">대실</div>
			            	</button>
			            </form>
			          </div>
			        </div>
			        <div class="frame-1321316143">
			          <div class="rsv-time-stay">
			            <div class="div4">숙박</div>
			            <div class="_18-00-12-00">
			              입실시간 ${vo.check_in_time }
			              <br />
			              퇴실시간 ${vo.check_out_time }
			            </div>
			          </div>
			          <div class="rsv-stay">
			            <div class="_50-000">
			            	<c:choose>
			            		<c:when test="${hrvo.peakseason_minfee1 == 0 or hrvo.peakseason_minfee1 == '0'}">
			            			해당 업소 문의
			            		</c:when>
			            		<c:otherwise>
			            			<fmt:formatNumber value="${hrvo.peakseason_minfee1}" pattern="#,###" /> 원
			            		</c:otherwise>
			            	</c:choose>
			            </div>
			            <form method="post" action="../reservation/reservation_stay.do">
			            	<input type="hidden" name="room_id" value="${hrvo.room_id }">
			            	<input type="hidden" name="content_id" value="${vo.cvo.content_id }">
			            <button class="reservation-button" id="stay-button${hrvo.room_id }" type="submit"
                                        <c:if test="${hrvo.peakseason_minfee1 == 0 or hrvo.peakseason_minfee1 == '0'}">
                                            disabled
                                        </c:if>>
			              <div class="div3">숙박</div>
			            </button>
			            </form>
			          </div>
			        </div>
			      </div>
			      <div class="frame-1321316145">
			        <div class="_2-tv">객실정보 최대 2인, 에어컨, TV, 헤어드라이어</div>
			      </div>
			    </div>
			    <img class="vector-1" src="vector-10.svg" />
			  </div>
			</div>
			</c:forEach>
		</div>
        <div class="detail_subWrap scrollTab_cont" id="sub3">
            <div>
                <h4>오시는 길</h4>
                <div id="map" style="width:100%; height:400px;"><a href="https://map.kakao.com/link/to/${vo.cvo.title},${vo.cvo.mapy},${vo.cvo.mapx}" target="_blank" class="findWay">길 찾기</a></div>
            </div>
            <div>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub4">
        		<c:if test="${sessionScope.user_id ne null}">
        		<form method="post" action="../hotel/hotel_review_insert.do">
	        		<input type="hidden" name="rtype" value="1">
	        		<input type="hidden" name="content_id" value="${vo.cvo.content_id }">
					<div class="form-floating mb-3">
						<!-- 
				  		<textarea class="form-control" name="message" id="floatingTextarea2" style="height: 100px"></textarea>
				  		<label for="floatingTextarea2">리뷰 작성란</label>
				  		-->
				  		<div class="input-group mb-3">
						  <textarea class="form-control" name="message" placeholder="리뷰 작성란" aria-label="Recipient's username" aria-describedby="button-addon2" style="height: 100px"></textarea>
						  <button class="btn btn-outline-secondary" type="submit" id="button-addon21">작성</button>
						</div>
				</div>
				</form>
				</c:if>
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
                        <c:forEach var="rvo" items="${rList }" begin="0" end="2">
                            <li>
                                <div class="review-header">
                                    <div class="user-name d-flex align-items-center">
                                        <div class="user-pf" style="background-image:${userprofile}"></div>
                                        <div class="d-flex flex-column">
                                            <div class="user-score" data-score="0">
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                                <div class="star"></div>
                                            </div>
                                            <p class="name">${rvo.user_id }
                                            	<span class="created-time">
                                            		<fmt:formatDate value="${rvo.regdate}" pattern="yyyy.MM.dd (E)" />
                                            	</span>
                                           	</p>
                                           	<span>
                                           		<c:if test="${sessionScope.user_id eq rvo.user_id }">
                                           			<form method="post" action="../hotel/hotel_review_delete.do">
                                           				<input type="hidden" name="no" value="${rvo.no }">
                                           				<input type="hidden" name="content_id" value="${rvo.content_id }">
	                                           			<button class="btn btn-primary btn-sm" type="button" id="r-update-${rvo.no }">수정</button>
	                                           			<button class="btn btn-danger btn-sm" type="submit">삭제</button>
                                           			</form>
	                                           	</c:if>
                                           	</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-cont">
                                	<span id="r-cont${rvo.no }">
                                		${rvo.message }
                                	</span>
	                                <div class="input-group mb-3" style="display: none;" id="r-u-${rvo.no }">
	                                	<form method="post" action="../hotel/hotel_review_update.do">
											<div class="input-group mb-3" id="${rvo.no }">
												<input type="hidden" name="content_id" value="${rvo.content_id }">
												<input type="hidden" name="no" value="${rvo.no }">
										  		<textarea class="form-control" name="message" placeholder="리뷰 작성란" aria-label="Recipient's username" aria-describedby="button-addon2" style="height: 100px; margin-left: 10px;">${rvo.message }</textarea>
											  <button class="btn btn-outline-secondary" type="submit" id="button-addon2${rvo.no }">작성</button>
											</div>
										</form>
									</div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <button class="morebtn btn-white">리뷰 전체보기</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=443acdfb0df827f13186e681c2acda8c"></script>
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
        window.onload = function() {
        //kakao map
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(${vo.cvo.mapy},${vo.cvo.mapx}), //지도의 중심좌표.
            // level: 3 //지도의 레벨(확대, 축소 정도)
        };
        var markerPosition = new kakao.maps.LatLng(${vo.cvo.mapy},${vo.cvo.mapx});
        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        marker.setMap(map);

        var mapTypeControl = new kakao.maps.MapTypeControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
        }
        //tab
        $(document).on("click",".scrollTab button",function(e){ //탭 클릭 시 해당 영역으로 이동
            let target=$(e.target).attr("data-target");
            let targetTop=$("#"+target).offset().top; //탭 컨텐츠 offset top
            let headerHeight = $("nav").outerHeight() + $(".tabWrap").outerHeight(); //sticky 탭 포함 헤더 높이
            $('html').scrollTop(targetTop-headerHeight+3);
        });
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
        $(window).on('load', function() {
            $(document).on("click", "[id^='r-update-']", function() {
                let targetDivId = $(this).attr('id').split('-')[2];  
                let targetSpan = $('#r-cont' + targetDivId);
                
                targetSpan.remove(); 
                
                
                let targetDiv = $('#r-u-' + targetDivId);
                targetDiv.css('display', 'block'); 
                $('.cont-morebtn').click();
            });
        });
    </script>
</body>
</html>
