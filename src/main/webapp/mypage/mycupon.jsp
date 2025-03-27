<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<script type="text/javascript" >
new WOW().init();
</script>
<body>
  <div class="container pt-3">
    <div class="row justify-content-center">
      <jsp:include page="mynav.jsp"></jsp:include>
      <div class="col-lg-9 col-12 wow fadeIn" data-wow-delay="0.1s">
        <h3 class="pt-3 pt-lg-0 pb-3">쿠폰 내역</h3>
         <div class="main-notice-wrap wow fadeInUp" data-wow-delay="0.1s">
				<ul class="main-notice-ul">
					<c:forEach items="${list}" var="vo" >
						<li>
							<div class="notice-title">
								<p>${vo.name }</p>
								<p class="date">${vo.issued_at2 } ~ ${vo.expired_at2 }</p>
							</div>
							<div class="notice-content">
								<p>${vo.info }</p>
								<button type="button" class="notice-more-btn w-100" onclick="location.href='#'">자세히 보기</button>
							</div>
						</li>
					</c:forEach>

				</ul>
			</div>
      </div>
    </div>
  </div>
</body>
</html>
