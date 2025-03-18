<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.4/photoswipe.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/css/lightgallery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.3/lightgallery.umd.min.js"></script>
<script type="module">
    // import PhotoSwipeLightbox from 'https://unpkg.com/photoswipe/dist/photoswipe-lightbox.esm.js';
    // const lightbox = new PhotoSwipeLightbox({
    //     gallery: '#my-gallery',
    //     children: 'a',
    //     initialZoomLevel: 1,
    //     secondaryZoomLevel: 'fit',
    //     pswpModule: () => import('https://unpkg.com/photoswipe')
    // });
    // lightbox.init();

</script>

<body>
    <div class="container">
        <div class="thumb_list">
            <a href="${vo.cvo.first_image }">
                <img alt="" src="${vo.cvo.first_image }">
            </a>
            <div class="sublist" id="my-gallery">
                <c:forEach var="dvo" items="${imglist }" begin="0" varStatus="i">
                    <a href="${dvo.divo.origin_img }" >
                        <img alt="image${i.index}" src="${dvo.divo.thumb_img }">
                        <c:if test="${i.index eq 1 }">
                            <p>+${fn:length(imglist)-3 }</p>
                        </c:if>
                    </a>
                </c:forEach>
            </div>
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
            <button class="buy-btn btn-black mt-3">입장권 구매하기</button>
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
                    <button type="button" class="count-down"></button><input type="text" name="product_count" value="1" disabled><button type="button" class="count-up"></button>
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
        });
    </script>
</body>
</html>
