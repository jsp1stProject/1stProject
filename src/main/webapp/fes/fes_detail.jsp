
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=433db32967fe83b6259bc22338c25ba1&libraries=services"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="/assets/plugin/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">

</style>
<body>
    <div class="container mini px-0">
         <div class="thumb_list${fn:length(plist)<2?' nosub':''}" id="my-gallery">
            <a href="${vo.first_image }" class="item">
                <img alt="" src="${vo.first_image }">
            </a>
            <c:if test="${not empty plist}">
                <div class="sublist">
                    <c:forEach var="dvo" items="${plist }" begin="0" varStatus="i">
                        <a href="${dvo.origin_img }"  class="item">
                            <img alt="image${i.index}" src="${dvo.thumb_img }">
                            <c:if test="${i.index eq 1 && fn:length(plist)>2 }">
                                <p>+${fn:length(plist)-2 }</p>
                            </c:if>
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <div class="detail_titleWrap">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                	<c:if test="${vo.cat2=='A02070100'}">
                    <p class="cate">문화관광축제</p>
                    </c:if>
                    <c:if test="${vo.cat2=='A02070200'}">
                    <p class="cate">일반축제</p>
                    </c:if>
                    <p class="title" id="title">${vo.title}</p>
                </div>
                <div class="detail_btnWrap">
                    <button type="button" class="bookmark-btn"></button>
                    <button type="button" class="share-btn"></button>
                </div>
            </div>
            <p class="location">${vo.addr1}</p>
            <p class="eventdate"><b>${vo.event_startdate}</b>부터 <b>${vo.event_enddate}</b>까지</p>
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
               <c:forEach items="${ilist}" var="info">
                    <h4>${info.infoname}</h4>
                    <p>${info.infotext}</p>
                </c:forEach>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub2">
            <div>
                <h4>행사 이름</h4>
                <p>${vo.title}</p>
                <h4>장소</h4>
                <p>${vo.addr1} ${vo.addr2 }</p>
                <h4>기간</h4>
                <p>${vo.event_startdate}부터 ${vo.event_enddate}까지</p>
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
                <div id="map" style="width:100%; height:400px;"><a href="https://map.kakao.com/link/to/${vo.title},${vo.mapy},${vo.mapx}" target="_blank" class="findWay">길 찾기</a></div>
            </div>
        </div>
        <div class="detail_subWrap scrollTab_cont" id="sub3">
        <c:if test="${sessionScope.user_id ne null}">
        		<form method="post" action="../fes/review_insert.do">
	        		<input type="hidden" name="type" value="3">
	        		<input type="hidden" name="content_id" value="${vo.content_id }">
					<div class="form-floating mb-3">
						<!-- 
				  		<textarea class="form-control" name="message" id="floatingTextarea2" style="height: 100px"></textarea>
				  		<label for="floatingTextarea2">리뷰 작성란</label>
				  		-->
				  		<div class="input-group mb-3">
						  <textarea class="form-control" name="msg" placeholder="리뷰 작성란" aria-label="Recipient's username" aria-describedby="button-addon2" style="height: 100px"></textarea>
						  <button class="btn btn-outline-secondary" type="submit" id="button-addon2">작성</button>
						</div>
				</div>
				</form>
				</c:if>
            <div>
                <h4>리뷰 <b class="text-blue">231</b></h4>
                <div class="d-flex align-content-center flex-column flex-wrap">
                    <div class="score-avg align-self-center py-3">
                        <div class="bigstar">
                            3.8
                        </div>
                    </div>
                    <div class="pt-3">
                        <select class="form-select filter-sm" aria-label="Default select">
                            <option value="0" selected>최신순</option>
                            <option value="1">평가 높은순</option>
                        </select>
                    </div>
                    <ul class="review-ul">
                        <c:forEach items="${rlist }" var="rvo" begin="0" end="2">
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
                                           			<form method="post" action="../fes/review_delete.do">
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
                                <div class="review-cont" id="r-cont">
                                	${rvo.message }
	                                <div class="input-group mb-3" style="display: block; margin-left: 10px; width: 400px" > 
	                                	<form method="post" action="../fes/review_update.do">
											<div class="input-group mb-3">
												<input type="hidden" name="content_id" value="${rvo.content_id }">
												<input type="hidden" name="no" value="${rvo.no }">
										  		<textarea class="form-control" name="message" placeholder="리뷰 작성란" aria-label="Recipient's username" aria-describedby="button-addon2" style="height: 100px">${rvo.message }
									  			</textarea>
											  <button class="btn btn-outline-secondary" type="submit"">작성</button>
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
        <div class="detail_subWrap">
            <div>
                <%-- <h4 class="pb-2">이 근처 숙소 찾기</h4>
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
                </div> --%>
                <%-- <h4 class="pb-2 mt-3">최근 확인한 행사</h4>
                <div class="swiper main-slide-list">
                    <div class="swiper-wrapper">
                        <c:forEach items="${clist }" var="vo">
                            <div class="li-item swiper-slide">
                                <a href="../hotel/hotel_detail.do?content_id=${vo.cvo.content_id}">
                                    <div class="item-inner">
                                        <div class="item-img" style="background-image:url(${vo.cvo.first_image});">
                                        </div>
                                        <div class="text-wrap">
                                            <p class="date">${vo.dbcate}</p>
                                            <p class="title">${vo.cvo.title}</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div> --%>
            </div>
        </div>
    </div>
    <div class="buy-wrap">
        <ul class="buy-ul">
            <li class="d-flex justify-content-between align-items-center"> <%-- li = 구매 아이템 --%>
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
                    <button type="button" class="count-down">-</button>
                    <input type="text" name="product_count" id="sel" value="0" disabled>
                    <button type="button" class="count-up">+</button>
                </div>
            </li>
            <li class="d-flex justify-content-end">
                <div>
                    <p class="product">합계</p>
                    <p class="totalPrice">0원</p>
                </div>
            </li>
            <li class="submitwrap">
                <button type="button" class="buynow" id="buy">바로구매</button>
                <form method="post" action="../fes/fes_cart_insert.do" style="float: left" id="frm">
                <input type="hidden" name="fno" value="${vo.content_id}" id="fno">
		        <input type="hidden" name="cart_price" value="" id="cart_price">
		        <input type="hidden" name="product_count" value="" id="product_count">
                <button type="button" class="cart" id="cart">장바구니</button>
                </form>
            </li>
        </ul>
    </div>
    <script type="text/javascript">
    	user_id="${user_id}"
        //Image Slide
        lightGallery(document.getElementById('my-gallery'), {
            thumbnail: true,
            selector: '.item'
        });

        //구매 팝업
        $(document).on("click","#buybtn",function(){
        	if(user_id=="")
			{
				alert("로그인이 필요한 기능입니다")
				//location.href='../member/login.do' 
				
			}
        	else
        	{	
            	$(".buy-wrap").addClass("active");
            	$(".buy-wrap").removeClass("off");
        	}
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
                   $('#product_count').val(count-1)
                   total-=parseInt(result);
               }
            }else if($(e.target).hasClass("count-up")){
               if(count<10){
                   $(e.target).siblings("input[name=product_count]").val(count+1);
                   $('#product_count').val(count+1)
                   total+=parseInt(result);
               }
            }
            $(".totalPrice").text(total.toLocaleString('ko-KR')+'원');
            $('#cart_price').val(total)
            $('#product_count').val($('#sel').val())
        });
		//바로구매
		let sel=0;
		var IMP = window.IMP; 
		/* 
		IMP.init("imp27087325"); 
		function requestPay(json,name,price) {
			console.log("requestPay")
		    IMP.request_pay({
		        pg: "html5_inicis",
		        pay_method: "card",
		        merchant_uid: "ORD20180131-0000011",   // 주문번호
		        name: name,
		        amount: json.account,         // 숫자 타입
		        buyer_email: json.email,
		        buyer_name: json.name,
		        buyer_tel:json.phone,
		        buyer_addr: json.address,
		        buyer_postcode: json.post
		    }, function (rsp) { // callback
		    	//location.href='http://localhost/JSPLastProject/mypage/mypage_buy_list.do' 
		    });
			
		    //결제정보에 들어가는 데이터 값이 달라져서 그런건가?*/ 
		    		
		    IMP.init("imp68206770"); 
		    function requestPay(json,name,price) {
		        IMP.request_pay({
		            pg: "html5_inicis",
		            pay_method: "card",
		            merchant_uid: "ORD20180131-0000011",   // 주문번호
		            name: name,
		            amount: json.cart_price,         // 숫자 타입
		            buyer_email: json.email,
		            buyer_name: json.name,
		            buyer_tel:json.phone,
		            buyer_addr: json.address,
		            buyer_postcode: json.post
		        }, function (rsp) { // callback
		        	location.href='../fes/fes_home.do' 
		        }); 
		    
		    
			
		}

		$(function(){
			$('#buy').click(function(){
				
				
				console.log($('#fno').val())
				console.log($('#cart_price').val())
				
				console.log(total)
				console.log($('#sel').val())
				if(total===0)
				{
					if($('#price').val()==0)
						alert("입장료 무료! 현장 추가결제 있을 수 있습니다")
					else
					{
						alert("수량 선택하세요")
					}
					return
				}
				let fno=$('#fno').val();
				let price=$('#cart_price').val();
				let account=$('#sel').val();
				let name=$('#title').text()
				$.ajax({
					type:'post',
					url:'../fes/fes_buy_insert.do',
					data:{"fno":fno,"price":price,"account":account},
					success:function(result)
					{
						//alert(result)
						let json=JSON.parse(result)
						console.log(json)
						console.log(price)
						console.log(name)
						requestPay(json,name,price)
					}
				})
			})
			
			$('#cart').click(function(){
				
				if(total===0)
				{
					if($('#price').val()==0)
						alert("입장료 무료! 현장 추가결제 있을 수 있습니다")
					else
					{
						alert("수량 선택하세요")
					}
					return
				}
				$('#frm').submit()
			})
			
			
		})
		
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
        $(window).on('load', function() {
            $(document).on("click", "[id^='r-update-']", function() {
                console.log("???")
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
