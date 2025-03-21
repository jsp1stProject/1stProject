<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
		<jsp:include page="notice_popup.jsp"/>
	<div class="container-fluid p-0 pb-4 wow fadeIn" data-wow-delay="0.1s">
		<div class="owl-carousel-inner">
            <div class="container">
                <div class="row justify-content-start">
                    <div class="col-12">
						<p class="display-4 text-light mb-4 slideInDown">여행가기 좋은 계절,<br><span class="impact">Festeller</span>와 함께 가요</p>
                        <p class="text-light fs-5 mb-4 pb-3">봄맞이 최대 30% 할인 쿠폰 이벤트</p>
                        <a href="" class="btn btn-primary rounded-pill py-3 px-5">자세히 보기</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="owl-carousel header-carousel position-relative">
            <div class="owl-carousel-item position-relative">
            	<div class="backimg" style="background-image:url('${pageContext.request.contextPath }/assets/img/main_visual_21.png')"></div>
            </div>
            <div class="owl-carousel-item position-relative">
            	<div class="backimg" style="background-image:url('${pageContext.request.contextPath }/assets/img/main_visual_22.png')"></div>
            </div>
            <div class="owl-carousel-item position-relative">
            	<div class="backimg" style="background-image:url('${pageContext.request.contextPath }/assets/img/main_visual_23.png')"></div>
            </div>
        </div>
    </div>
    <!-- Carousel End -->
	<!-- hotel list-->
    <div class="container-xxl py-4">
    	<div class="container">
    		<h3 class="main-h3 wow fadeInUp" data-wow-delay="0.1s">이번 주 많이 찾는 숙소</h3>
    		<div class="tab-nav-wrap wow fadeInUp" data-wow-delay="0.1s">
    			<div class="tab-nav-item active" data-tab="1">서울</div>
    			<div class="tab-nav-item" data-tab="2">부산</div>
    			<div class="tab-nav-item" data-tab="3">강원</div>
    		</div>
    		<div class="tab-content-wrap wow fadeInUp" data-wow-delay="0.1s">
    			<div class="tab-cont-item active" data-tab="1">
	    			<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel1.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">노보텔 앰배서더 서울 용산</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel2.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">페어필드 바이 메리어트 서울 페어필드 바이 메리어트 페어필드 바이 메리어트</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel3.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">동서울 관광호텔</p>
				    						<p class="price">90,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.0</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel4.png);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">왕십리 포레스타 호텔</p>
				    						<p class="price">542,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.7</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
		    				<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel5.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">체스터톤스 강남</p>
				    						<p class="price">65,500원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.4</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
		    			</div>
		    		</div>
	    		</div>
    			<div class="tab-cont-item" data-tab="2">
    				<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel5.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">노보텔 앰배서더 서울 용산</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel6.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">페어필드 바이 메리어트 서울 페어필드 바이 메리어트 페어필드 바이 메리어트</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel7.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">동서울 관광호텔</p>
				    						<p class="price">90,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.0</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel1.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">왕십리 포레스타 호텔</p>
				    						<p class="price">542,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.7</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
		    				<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel2.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">체스터톤스 강남</p>
				    						<p class="price">65,500원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.4</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
		    			</div>
		    		</div>
    			</div>
    			<div class="tab-cont-item" data-tab="3">
    				<div class="swiper main-slide-list">
		    			<div class="swiper-wrapper">
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel7.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">노보텔 앰배서더 서울 용산</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel6.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">페어필드 바이 메리어트 서울 페어필드 바이 메리어트 페어필드 바이 메리어트</p>
				    						<p class="price">132,400원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.2</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel1.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">동서울 관광호텔</p>
				    						<p class="price">90,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.0</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
			    			<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel3.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">왕십리 포레스타 호텔</p>
				    						<p class="price">542,000원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.7</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
		    				<div class="li-item swiper-slide">
			    				<a href="#">
				    				<div class="item-inner">
				    					<div class="item-img" style="background-image:url(../assets/img/hotel5.jpg);">
				    					</div>
				    					<div class="text-wrap">
				    						<p class="title">체스터톤스 강남</p>
				    						<p class="price">65,500원</p>
				    						<p class="score">
				    							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" class="size-16"><path fill="currentColor" d="M12.638 2.471a1.465 1.465 0 0 0-1.945.652L8.44 7.69v.002a.36.36 0 0 1-.255.191h-.002l-5.026.73c-.289.04-.61.175-.85.446a1.462 1.462 0 0 0 .033 2.037l3.647 3.557.004.003c.07.068.112.174.09.305v.001l-.86 5.007-.001.013c-.043.28.005.53.064.724l.01.035.015.033c.096.23.256.457.491.628.233.17.488.252.744.271l.028.003h.03c.203 0 .458-.031.715-.16l.007-.003 4.507-2.374.002-.001a.33.33 0 0 1 .316 0l.003.001 4.507 2.374.007.003c.259.13.586.203.926.136a1.466 1.466 0 0 0 1.18-1.663l-.862-5.02a.38.38 0 0 1 .106-.317l3.629-3.54.007-.006c.224-.224.358-.502.415-.783l.003-.017.002-.016a1.45 1.45 0 0 0-1.2-1.651l-.029-.007-5.031-.748-.008-.001a.32.32 0 0 1-.248-.185l-2.252-4.564-.002-.004a1.46 1.46 0 0 0-.655-.655z"></path></svg>
				    							<span>4.4</span>
				    						</p>
				    					</div>
			    					</div>
			    				</a>
			    			</div>
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
</body>
</html>