<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<body>
    <div class="container">
        <div class="thumb_list${empty imglist?' nosub':''}" id="my-gallery">
            <a href="${vo.cvo.first_image }" class="item">
                <img alt="" src="${vo.cvo.first_image }">
            </a>
            <c:if test="${not empty imglist}">
                <div class="sublist">
                    <c:forEach var="dvo" items="${imglist }" begin="0" varStatus="i">
                        <a href="${dvo.divo.origin_img }"  class="item">
                            <img alt="image${i.index}" src="${dvo.divo.thumb_img }">
                            <c:if test="${i.index eq 1 }">
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
    </script>
</body>
</html>
