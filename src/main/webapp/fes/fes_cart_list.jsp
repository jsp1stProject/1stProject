<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script
	src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
<link
	href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-js"></script>
<link rel="stylesheet" type="text/css"
	href="//optimizer.poxo.com/css/ticketmdshop/e8fd6ad0e1e864d3709ee2de247ec0e0a2cf8dd3.84554ca7a5767d94093f7e391c642c44/1720492392"
	crossorigin="anonymous">
<script type="text/javascript">
let sel=0;
var IMP = window.IMP;

IMP.init("imp68206770"); 
function requestPay(json,name,price) {
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
    	location.href='http://localhost/JSPLastProject/fes/fes_home.do' 
}); 
    
}
$(function(){	

	
	$('up').click(function(){
		console.log($('#fno').val())
		console.log($('#price').val())
		
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
		let price=$('#price').val();
		let account=$('#sel').val();
		let name=$('#title').text()
		$.ajax({
			type:'post',
			url:'../fes/fes_buy_insert.do',
			data:{"fno":fno,"price":price,"account":account},
			success:function(result)
			{
				alert(result)
				let json=JSON.parse(result)
				console.log(json)
				console.log(price)
				console.log(name)
				requestPay(json,name,price)
			}
		})
	})
	
	
	$('#countup').click(function(){
		let fno=$('#fno').val();
		let account=$('#quantity_id_0').val();
		console.log("수량변경 버튼 업 확인")
		console.log("account값 : "+account)
		console.log("fno값 : "+fno)
		account=Number(account)+1
		$('#quantity_id_0').val(account);
		
	})
	$('#countdown').click(function(){
		let account=$('#quantity_id_0').val();
		console.log("수량변경 버튼 다운확인")
		if(account==1)
		{
			alert("최소 수량입니다.");
		}
		else
		{
			$('#quantity_id_0').val(account-1);
		}

	})
})


function countchange()
{
	console.log("수량변경확인버튼")
	let account=$('#quantity_id_0').val();
	let price=$('#price').val();
	let fno=$('#fno').val();
	
	$.ajax({
		type:'post',
		url:'../fes/fes_cart_update.do',
		data:{"fno":fno,"account":account},
		success:function(result)
		{
			console.log("수량이 변경되었습니다.")
			totalprice()
		}
	})
	
	
}

function totalprice()
{	
	console.log("totalprice함수 실행")
	let account=$('#quantity_id_0').val();
	console.log(account)
	let price=$('#price').val();
	console.log("갸격"+price)
	let total=Number(price)*Number(account)
	console.log(total)
	$('#totalprice').text(total.toLocaleString())
}


function totalbuy()
{
	console.log($('#fno').val())
	console.log($('#price').val())
	
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
	let price=$('#price').val();
	let account=$('#sel').val();
	let name=$('#title').text()
	$.ajax({
		type:'post',
		url:'../fes/fes_buy_insert.do',
		data:{"fno":fno,"price":price,"account":account},
		success:function(result)
		{
			alert(result)
			let json=JSON.parse(result)
			console.log(json)
			console.log(price)
			console.log(name)
			requestPay(json,name,price)
		}
	})
	
}
</script>

</head>
<body class="theme01 button--fixed">
	<div id="wrap">
		<div id="container">
			<div id="contents" style="margin-top: 52px;">
				<div class="section path">
					<span>현재 위치</span>
					<ol>
						<li><a href="/">홈</a></li>
						<li title="현재 위치"><strong>장바구니</strong></li>
					</ol>
				</div>
				<div class="section titleArea">
					<h2>장바구니</h2>
				</div>
				<div class="section ec-base-step">
					<ol class="step">
						<li class="selected">1. 장바구니</li>
						<li>2. 주문서작성</li>
						<li>3. 주문완료</li>
					</ol>
				</div>
				<div
					class="xans-element- xans-order xans-order-basketpackage section ">
					<div
						class="xans-element- xans-order xans-order-tabinfo ec-base-tab  typeNav ">
						<ul class="menu">
							<li class="selected "><a href="/order/basket.html">국내배송상품</a></li>
						</ul>
						<p class="right  RW">장바구니에 담긴 상품은 7일 동안 보관됩니다.</p>
					</div>
					<div class="cart-container">
						<div class="cart-product">
							<div
								class="xans-element- xans-order xans-order-emptyitem ec-base-fold theme1 selected eToggle ">
								<div class="title">
									<h3>장바구니 상품</h3>
								</div>
								
								
								<div class="contents">
									<div class="xans-element- xans-order xans-order-normtitle title subTitle ">
										<h4>일반상품</h4>
									</div>
									<c:forEach var="vo" items="${list }">
									<div
										class="xans-element- xans-order xans-order-normnormal xans-record-">
										<div class="xans-element- xans-order xans-order-list">
											<div class="ec-base-prdInfo gCheck xans-record-">
												<div class="prdBox">
													<input type="checkbox" id="basket_chk_id_0"
														name="basket_product_normal_type_normal" class="check">&nbsp;
													<div class="thumbnail">
														<a
															href="#">
															<img
															src="${vo.fvo.first_image }"
															width="83" height="83" loading="lazy" ez-prevent="img">
														</a>
													</div>
													<div class="description">
														<strong class="prdName" title="상품명" id="basket_prod_id_0">
															<a
															href="#"
															class="ec-product-name">${vo.fvo.title}</a>
															
														</strong>
														<ul class="price">
															<li id="price" name="price" value="${vo.fvo.price}"><strong>${vo.fvo.price}</strong>원 <span
																class="displaynone"><span></span></span></li>
															<li class="" id=""><span class="txtSecondary">-0</span>원
																<span class="displaynone"><span></span></span></li>
														</ul>
														<ul class="info">
															<li>배송 : <span class="displaynone">0원<span
																	class="refer displaynone"></span></span> [무료] / 기본배송
															
														</ul>
													</div>
													<div class="quantity">
														<span class="label">수량</span>
														<div class="">
															<span class="ec-base-qty"> 
															<div>
															<input type="hidden" name="fno" value="${vo.fno}" id="fno">
															</div>
															<input
																id="quantity_id_0" name="quantity_name_0" size="2" value="${vo.account }" type="text"> 
															<a href="javascript:;" class="up" name="countup" id="countup">수량증가</a>
															<a href="javascript:;" class="down" name="countdown" id="countdown">수량감소</a>
															
															</span> <a href="javascript:;" class="btnNormal sizeQty" name="countchange" onclick=countchange()>변경</a>
														</div>
														<div class="displaynone">1</div>
													</div>
													<div class="sumPrice">
														<span class="label">주문금액</span> <strong name="totalprice" id="totalprice">${vo.cart_price }</strong>원
														<span class="displaynone"></span>
													</div>
													<div class="buttonGroup">
														<a href="#none" onclick="BasketNew.moveWish(0);"
															class="btnNormal sizeM">관심상품</a> <a href="#none"
															onclick="Basket.orderBasketItem(0);"
															class="btnSubmit sizeM ">주문하기</a>

													</div>
												</div>
												<a href="#none" onclick="Basket.deleteBasketItem(0);"
													class="btnDelete" onclick="con">삭제</a>
											</div>
										</div>

									</div>
									</c:forEach>


									<div
										class="xans-element- xans-order xans-order-selectorder ec-base-button typeMulti ">
										<div class="gLeft ">
											<a href="#none" class="btnNormal sizeS"
												id="product_select_all" data-status="off">전체선택</a> <a
												href="#none" onclick="Basket.deleteBasket()"
												class="btnNormal sizeS">선택삭제</a>
										</div>

									</div>
								</div>
								
							</div>

						</div>
						<div class="cart-total" style="">
							<div class="sticky">
								<!-- 총 주문금액 : 국내배송상품 -->
								<div
									class="xans-element- xans-order xans-order-totalsummary  totalSummary ">
									<div class="totalSummary__item">
										<div class="heading">
											<h4 class="title">총 상품금액</h4>
											<div class="data">
												<strong><span
													class="total_product_price_display_front">120,000</span></strong>원 <span
													class="refer displaynone"><span
													class="total_product_price_display_back"></span></span>
											</div>
										</div>
										<div class="contents displaynone">
											<div class="item">
												<h5 class="title">상품금액</h5>
												<div class="data">
													<span class="total_product_price_display_front_mobile">0</span>
												</div>
											</div>
											<div class="item">
												<h5 class="title">부가세</h5>
												<div class="data">
													<span class="total_product_vat_price_front_mobile">0원</span>
												</div>
											</div>
										</div>
									</div>
									<div class="title shipping totalSummary__item">
										<div class="heading">
											<h4 class="title">총 배송비</h4>
											<div class="data">
												<strong id="total_delv_price_front"><span
													class="total_delv_price_front">0</span></strong>원 <span
													class="refer displaynone"><span
													class="total_delv_price_back"></span></span>
												<div class="shippingArea displaynone">
													<span class="status">(</span>
													<div class="shippingFee">
														<a href="#none" class="btnText" id="">자세히</a>)
														<div class="ec-base-tooltip" style="display: none;">

															<div class="content">
																<strong class="title"></strong>
																<div class="ec-base-table"></div>
															</div>
															<button type="button" class="btnClose">닫기</button>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<p class="displaynone ec-base-help">착불 상품이 포함되어 있습니다.</p>
									<div id="total_benefit_price_title_area"
										class="totalSummary__item displaynone">
										<div class="heading">
											<h4 class="title">총 할인금액</h4>
											<div class="data">
												<strong id="total_product_discount_price_front">0</strong>원
												<span class="refer displaynone"><span
													id="total_product_discount_price_back"></span></span>
											</div>
										</div>

									</div>
									<div class="total">
										<h3 class="title">결제예정금액</h3>
										<div class="paymentPrice">
											<strong id="total_order_price_front">120,000</strong>원 <span
												class="refer displaynone"><span
												id="total_order_price_back"></span></span>
										</div>
									</div>
								</div>


								<div id="orderFixItem"
									class="xans-element- xans-order xans-order-totalorder ">
									<div class="ec-base-button">
										<a href="#none" onclick="Basket.orderAll(this)"
											link-order="/order/orderform.html?basket_type=all_buy"
											link-login="/member/login.html"
											class="btnSubmit gFull sizeL  onclick="totalbuy()">전체상품주문</a> <a href="#none"
											
											link-order="/order/orderform.html?basket_type=all_buy"
											link-login="/member/login.html"
											class="btnNormal gFull sizeL ">선택상품주문</a>
									</div>
								</div>

							</div>
						</div>
					</div>

				</div>

				<div data-ez="contents-0zuam8s-1"
					class="xans-element- xans-order xans-order-basketguide section ec-base-help">
					<h3>이용안내</h3>
					<div class="inner">
						<h4>장바구니 이용안내</h4>
						<ul>
							<li class=" ">해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해
								주시기 바랍니다.</li>
							<li class=" ">해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여
								결제하실 수 있습니다.</li>
							<li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
							<li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
							<li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
							<li>파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
						</ul>
						<h4>무이자할부 이용안내</h4>
						<ul>
							<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제
								하시면 됩니다.</li>
							<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가
								이루어집니다.</li>
							<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
							<li class=" ">무이자할부 상품은 장바구니에서 별도 무이자할부 상품 영역에 표시되어, 무이자할부
								상품 기준으로 배송비가 표시됩니다.<br>실제 배송비는 함께 주문하는 상품에 따라 적용되오니 주문서 하단의
								배송비 정보를 참고해주시기 바랍니다.
							</li>
							<li class="displaynone">무이자할부 상품은 장바구니에서 별도 무이자할부 상품 영역에
								표시됩니다.</li>
						</ul>
					</div>
				</div>
				<!--#ez="1/1"-->
			</div>
		</div>
		<div class="bottom-nav RMB RTB bottom-nav--hide">
			<div class="bottom-nav__top bottom-nav__top--show">
				<a href="#wrap" title="화면 최상단으로 이동하기"><svg
						xmlns="http://www.w3.org/2000/svg" width="14" height="20"
						fill="#1a1a1a" viewBox="0 0 14 20" class="icon" role="img">
						<path
							d="M3,8.4C2.3,9,1.2,9,0.5,8.3c-0.6-0.7-0.6-1.7,0-2.4l5.3-5.2C6.5,0,7.6,0,8.3,0.7l5.2,5.1c0.7,0.7,0.7,1.8,0,2.5
   c-0.7,0.7-1.8,0.7-2.4,0L8.8,6.1l0,12.1c0,2.3-3.6,2.3-3.6,0l0-12L3,8.4z"></path></svg></a>
			</div>
		</div>
		<div class="footer_margin"></div>

		<!--#ez="1/5"-->
	</div>
	<!-- //wrap -->
	<script type="text/javascript">
/* 	$(function(){
		$('#countup').change(function(){
			console.log("수량 증가버튼")
		})
		$('#countdown').change(function(){
			console.log("수량 감소버튼")
		})
	}) */
	</script>
</body>
</html>


