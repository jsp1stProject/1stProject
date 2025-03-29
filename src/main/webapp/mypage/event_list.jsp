<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<body>
	<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
	<style type="text/css">
		.content-ul .thumb-wrap {
			width: 120px;
			height: 120px;
		}
		.content-ul .title-wrap p.enddate {
			font-size: 14px;
			color: #737373;
		}
		p.price {
			font-size: 18px;
			font-weight: 600;
		}
		button.btn-white:disabled {
			opacity: .3;
		}
	</style>
	<div class="container pt-5 pt-lg-3">
		<div class="row justify-content-center">
			<jsp:include page="mynav.jsp"></jsp:include>
			<div class="col-lg-9 col-12">
				<h3 class="pt-3 pt-lg-0 pb-3">내 티켓</h3>
				<div>
					<form action="../mypage/event_list.do" method="post" name="filter">
						<select name="used" id="used" class="form-select filter-sm">
							<option value="a" selected>선택하기</option>
							<option value="a">전체</option>
							<option value="n">사용 가능</option>
							<option value="y">관람 완료</option>
						</select>
					</form>
					<h4 class="search-title my-3"><span>${count}</span>장의 티켓이 아직 <span>관람 전</span>이에요!</h4>
					<ul class="content-ul event">
						<c:forEach items="${list }" var="vo">
							<li>
								<a href="#" class="d-flex">
									<div class="thumb-wrap" style="background-image:url(${vo.cvo.first_image})">
										<button type="button" class="bookmark-btn on"></button>
									</div>
									<div class="d-flex flex-column flex-md-row right">
										<div class="title-wrap">
											<p class="cat">
											<c:choose>
												<c:when test="${vo.used eq 'n' }"><span class="hotel">사용 가능</span></c:when>
												<c:otherwise><span class="event1">관람 완료</span></c:otherwise>
											</c:choose>
											</p>
											<p class="content-name">${vo.cvo.title}</p>
											<p class="enddate">${vo.account}매│${vo.evo.dbend}까지</p>
											<p class="price">
												<c:choose>
													<c:when test="${vo.total_price eq 0 }"><p class="price">무료</p></c:when>
													<c:otherwise><p class="price"><fmt:formatNumber value="${vo.total_price }" pattern="#,###" />원</p></c:otherwise>
												</c:choose>
											</p>
										</div>
									</div>
								</a>
								<c:choose>
									<c:when test="${vo.used eq 'n' }"><a href="#" class="mt-3" style="display:block;"><button class="btn-white usedbtn" data-payid="${vo.payment_id}">사용 완료하기</button></a></c:when>
									<c:when test="${vo.used eq 'y' }"><a href="../event/event_detail.do?id=${vo.cvo.content_id}" class="mt-3" style="display:block;"><button class="btn-white">리뷰 작성하기</button></a></c:when>
									<c:when test="${vo.used eq 'r' }"><a href="#" class="mt-3" style="display:block;"><button class="btn-black">리뷰 확인하기</button></a></c:when>
								</c:choose>

							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$(".usedbtn").on("click",function(){
		let payid=$(this).attr("data-payid");
		let used = async function(){
			try{
				let response=await axios({
					method:'post',
					url:'../event/used.do',
					headers:{
						"Content-Type":"application/json"
					},
					data:{
						"payment_id":payid
					}
				});
				if(response.data.statement=="success"){
					if(confirm("사용 처리가 완료되었습니다.\n티켓 환불은 고객센터로 문의해주세요.")){
						window.location.reload();
					}
				}
			}catch(e){
				console.log(e);
				throw new Error(e);
			}
		}
		used();
	});
	$("#used").on("change",function(){
		$("form[name=filter]").submit();
	});

	$('.bookmark-btn').on('click',function(e){
		e.preventDefault();
		$(this).toggleClass('on');
	});

</script>
</body>
</html>