<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../shadow/css/shadowbox.css">
<body>
	<%// wow는 main에서만 적용 %>
    <nav class="navbar navbar-expand-lg fixed-top py-lg-0 px-lg-4 ${title eq '메인'?'wow':'bg-white' }">
        <a href="${pageContext.request.contextPath }/main/main.do" class="navbar-brand ms-4 ms-lg-0">
            <h1 class="m-0 home">Festeller</h1>
        </a>
        <div class="d-flex justify-content-end flex-fill">
	        <div class="collapse navbar-collapse" id="navbarCollapse">
	            <div class="navbar-nav mx-auto p-4 p-lg-0">
	                <a href="../hotel/hotel_list.do" class="nav-item nav-link">숙소</a>
	                <a href="../event/main.do" class="nav-item nav-link ${not empty event?'active':''}">행사</a>
	                <a href="../fes/fes_home.do" class="nav-item nav-link">축제</a>
	                <a href="../food/food_find.do" class="nav-item nav-link">맛집</a>
	                <div class="nav-item">
	                    <a href="#" class="nav-link" data-bs-toggle="collapse" data-bs-target="#subnav1">게시판</a>
	                    <div class="collapse subnav mb-lg-4" id="subnav1">
	                        <a href="../notice/notice_admin_list.do" class="nav-item nav-link">공지사항</a>
	                        <a href="../qna/qna_list.do" class="nav-item nav-link">Q&A</a>
	                        <a href="404.html" class="nav-item nav-link">404 Page</a>
	                    </div>
	                </div>
	                <a href="../adminpage/admin_main.do" class="nav-item nav-link">관리자페이지</a>
	            </div>
	        </div> 
	        <div class="d-flex justify-content-end align-self-baseline">
	        	<div class="d-flex" id="nav-wide-right">
	            	<div class="flex-shrink-0 btn-square rounded-circle srhbtn">
						<svg xmlns="http://www.w3.org/2000/svg" id="svg4162" viewBox="70 620 360 360">
							<g id="layer1">
								<g id="g1400">
									<path id="path4714" d="M 232.83952,614.96702 A 154.04816,154.04794 0 0 0 78.79153,769.01382 154.04816,154.04794 0 0 0 232.83952,923.06184 154.04816,154.04794 0 0 0 386.88751,769.01382 154.04816,154.04794 0 0 0 232.83952,614.96702 Z m 0,26.77613 A 129.95832,127.2707 0 0 1 362.79832,769.01382 129.95832,127.2707 0 0 1 232.83952,896.28449 129.95832,127.2707 0 0 1 102.88194,769.01382 129.95832,127.2707 0 0 1 232.83952,641.74315 Z"></path>
									<rect ry="18.08342" rx="33.249443" transform="matrix(0.65316768,0.7572133,-0.60689051,0.79478545,0,0)" y="319.55432" x="794.8775" height="36.16684" width="173.02675" id="rect4721"></rect>
								</g>
							</g>
						</svg>
					</div>
	                <div class="flex-shrink-0 btn-square rounded-circle cartbtn">
						<span class="cart_num">0</span> <!--100 이상은 99+로 표시-->
						<svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M2.5 2.25C2.08579 2.25 1.75 2.58579 1.75 3C1.75 3.41421 2.08579 3.75 2.5 3.75H4.27924C4.38685 3.75 4.48238 3.81886 4.51641 3.92094L7.83264 13.8696C8.20695 14.9926 9.25783 15.75 10.4415 15.75H17.614C18.7603 15.75 19.7864 15.0389 20.1889 13.9656L21.9422 9.29003C22.4938 7.81909 21.4065 6.25 19.8355 6.25H9.5C9.08579 6.25 8.75 6.58579 8.75 7C8.75 7.41421 9.08579 7.75 9.5 7.75H19.8355C20.3592 7.75 20.7216 8.27303 20.5377 8.76334L18.7844 13.4389C18.6015 13.9268 18.1351 14.25 17.614 14.25H10.4415C9.90348 14.25 9.42581 13.9057 9.25566 13.3953L5.93944 3.4466C5.70124 2.732 5.03249 2.25 4.27924 2.25H2.5Z"></path><path clip-rule="evenodd" d="M10 22C11.3807 22 12.5 20.8807 12.5 19.5C12.5 18.1193 11.3807 17 10 17C8.61929 17 7.5 18.1193 7.5 19.5C7.5 20.8807 8.61929 22 10 22ZM10 20.5C10.5523 20.5 11 20.0523 11 19.5C11 18.9477 10.5523 18.5 10 18.5C9.44772 18.5 9 18.9477 9 19.5C9 20.0523 9.44772 20.5 10 20.5Z"></path><path clip-rule="evenodd" d="M18 22C19.3807 22 20.5 20.8807 20.5 19.5C20.5 18.1193 19.3807 17 18 17C16.6193 17 15.5 18.1193 15.5 19.5C15.5 20.8807 16.6193 22 18 22ZM18 20.5C18.5523 20.5 19 20.0523 19 19.5C19 18.9477 18.5523 18.5 18 18.5C17.4477 18.5 17 18.9477 17 19.5C17 20.0523 17.4477 20.5 18 20.5Z"></path></svg>
					</div>
					<div class="flex-shrink-0 btn-square rounded-circle userbtn">
						<div class="user-wrapper">
							<ul>
							<c:if test="${sessionScope.user_id==null }">
								<li><a href="#" id="loginBtn">로그인</a></li>
								<li><a href="../member/join.do">회원가입</a></li>
								<li><a href="../member/idfind.do">아이디찾기</a></li>
								<li><a href="#">비회원 예약</a></li>
							</c:if>
								<!--로그인 상태에 따라 다른 메뉴 보이기-->
							<c:if test="${sessionScope.user_id!=null }">
								<h6>${sessionScope.name}님 로그인되었습니다&nbsp;</h6>
								<li><a href="../mypage/myinfo.do">마이페이지</a></li>
								<li><a href="../member/logout.do">로그아웃</a></li>
							</c:if>
							</ul>
						</div>
	                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512l388.6 0c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304l-91.4 0z"/></svg>
	                </div>
	            </div>
	            <button type="button" class="navbar-toggler me-4 ms-2" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
		            <!-- <span class="navbar-toggler-icon"></span>-->
		            <div class="menu-icon">
			            <div class="i_menu"></div>
		            </div>
		        </button>
	        </div>
        </div>
    </nav>
    <div class="search-wrap">
    	<div class="search-inner">
    		<div class="search-header">
    			<button type="button" class="closebtn"></button>
    		</div>
    		<div class="center_wrap">
    			<form action="" method="post" name="main-search">
	    			<div class="sch_wrap">
						<select name="option">
							<option value="1">숙박</option>
							<option value="2">행사</option>
							<option value="3">축제</option>
						</select>
						<input type="text" name="key" placeholder="검색어를 입력하세요.">
						<input type="submit" value="검색">
					</div>
    			</form>
				<div class="latest_wrap">
					<div class="latest">
						<span>검색어</span>
						<button type="button" name="del"></button>
					</div>
				</div>
    		</div>
    	</div>
    </div>
	<div class="scrollTopBtn">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.--><path d="M214.6 41.4c-12.5-12.5-32.8-12.5-45.3 0l-160 160c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L160 141.2 160 448c0 17.7 14.3 32 32 32s32-14.3 32-32l0-306.7L329.4 246.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-160-160z"></path></svg>
	</div>
	<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
	<script type="text/javascript" src="../shadow/js/shadowbox.js"></script>
    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function(){
    	const inputWrap = document.querySelector(".sch_wrap");
    	const inputkey = document.querySelector("input[name='key']");
    	const sel = document.querySelector("select[name='option']");
    	inputkey.onfocus = function() {
    		inputWrap.classList.add('focus');
    	};
    	inputkey.onblur = function() {
    		inputWrap.classList.remove('focus');
    	};
    });
    $(document).on("click",".srhbtn", function(){
    	$('body').addClass('on');
    	$('.search-wrap').fadeIn(100);
    	$('input[name="key"]').focus();
    });
    $(document).on("click",".closebtn", function(){
    	$('.search-wrap').fadeOut(100);
    	$('body').removeClass('on');
    });
	$(document).on("click",".userbtn", function(){
		$(this).toggleClass('active');
	});
	
	Shadowbox.init({
        players: ['iframe']
    });

    // 로그인 버튼 클릭 시 Shadowbox로 팝업 띄우기
    document.getElementById("loginBtn").addEventListener("click", function(event){
        event.preventDefault(); // a 태그의 기본 동작 방지

        Shadowbox.open({
            content: '../member/login.do',
            player: 'iframe',
            width: 320,
            height: 300,
            title: '로그인'
        });
    });

	//scroll-top btn
	let preScrollTop = 0;
	window.addEventListener('scroll',() => {
		let nextScrollTop = window.scrollY;
		if(preScrollTop > nextScrollTop && window.scrollY!==0) {
			$(".scrollTopBtn").fadeIn();
		}else{

			$(".scrollTopBtn").fadeOut();
		}
		preScrollTop = nextScrollTop;
	});
	$(document).on("click",".scrollTopBtn",function(){
		$('html').scrollTop(0);
	})
    </script>
</body>
</html>