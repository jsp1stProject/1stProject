<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
  <script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <link rel="stylesheet" type="text/css" href="../assets/css/cart.css">
<body>
<div id="wrap">
  <div>
    <div class="container-lg px-0">
      <div class="section titleArea">
        <h2>행사 장바구니</h2>
      </div>
      <div class="section ec-base-step">
        <ol class="step">
          <li class="selected">1. 장바구니</li>
          <li>2. 주문서작성</li>
          <li>3. 주문완료</li>
        </ol>
      </div>
      <div class="xans-order-basketpackage">
        <div class="xans-element- xans-order xans-order-tabinfo ec-base-tab  typeNav ">
          <ul class="menu">
          </ul>
        </div>
        <div class="cart-container">
          <div class="cart-product">
            <div class="xans-element- xans-order xans-order-emptyitem ec-base-fold theme1 selected eToggle ">
                <div class="contents">
                  <c:forEach var="vo" items="${list }" varStatus="i">
                  <div class="thisContent xans-element- xans-order xans-order-normnormal xans-record-" data-id="${vo.cvo.content_id}" data-cno="${vo.cno}">
                    <div class="xans-element- xans-order xans-order-list">
                      <div class="ec-base-prdInfo gCheck xans-record-">
                        <div class="prdBox">
                          <input type="checkbox" id="basket_chk_id_0" name="basket_product_normal_type_normal" class="check">&nbsp;
                          <div class="thumbnail">
                            <a href="event_detail.do?id=${vo.cvo.content_id}">
                              <img src="${vo.cvo.first_image2 }" width="83" height="83" loading="lazy" ez-prevent="img">
                            </a>
                          </div>
                          <div class="description">
                            <strong class="prdName" title="상품명">
                              <a href="#" class="ec-product-name">${vo.cvo.title}</a>
                            </strong>
                            <ul class="price" id="price${i}">
                              <li>
                                <c:choose>
                                  <c:when test="${vo.price eq 0}">
                                    <strong>무료</strong>
                                  </c:when>
                                  <c:otherwise>
                                    <strong><fmt:formatNumber value="${vo.price }" pattern="#,###" /></strong>원
                                  </c:otherwise>
                                </c:choose>
                              </li>
                            </ul>
                            <ul class="info">
                              <li></li>
                            </ul>
                          </div>
                          <div class="quantity">
                            <span class="label">수량</span>
                            <div class="">
                              <span class="ec-base-qty">
                                <input id="account${i.index}" name="account${i.index}" size="2" value="${vo.account }" type="text">
                                <a href="javascript:;" class="up" id="countup">수량증가</a>
                                <a href="javascript:;" class="down" id="countdodwn">수량감소</a>
                              </span>
                              <a href="javascript:;" class="btnNormal sizeQty" data-index="${i.index}">변경</a>
                            </div>
                            <div class="displaynone">1</div>
                          </div>
                          <div class="sumPrice">
                            <span class="label">주문금액</span> <strong><fmt:formatNumber value="${vo.total_price }" pattern="#,###" /></strong>원
                            <span class="displaynone"></span>
                          </div>
                        </div>
                        <a href="#none"
                           class="btnDelete" data-index="${i.index}">삭제</a>
                      </div>
                    </div>
                  </div>
                  </c:forEach>
                  <div class="xans-element- xans-order xans-order-selectorder ec-base-button typeMulti ">
                    <div class="gLeft ">
                      <a href="#none" class="btnNormal sizeS"
                         id="product_select_all" data-status="off">전체선택</a>
                    </div>
                  </div>
                </div>
            </div>
          </div>
          <div class="cart-total" style="">
            <div class="sticky">
              <div class="xans-element- xans-order xans-order-totalsummary  totalSummary ">
                <div class="totalSummary__item">
                  <div class="heading">
                    <h4 class="title">총 상품금액</h4>
                    <div class="data">
                      <strong><span class="total_product_price_display_front" id="total_price">120,000</span></strong>원
                    </div>
                  </div>
                </div>
                <div class="title shipping totalSummary__item">
                  <div class="heading">
                    <h4 class="title">총 배송비</h4>
                    <div class="data">
                      <strong id="total_delv_price_front"><span class="total_delv_price_front">0</span></strong>원
                    </div>
                  </div>
                </div>
                <div class="total">
                  <h3 class="title">결제예정금액</h3>
                  <div class="paymentPrice">
                    <strong id="total_price2">120,000</strong>원 <span
                          class="refer displaynone"><span
                          id="total_order_price_back"></span></span>
                  </div>
                </div>
              </div>
              <div id="orderFixItem"
                   class="xans-element- xans-order xans-order-totalorder ">
                <div class="ec-base-button">
                  <a href="#none" class="btnSubmit gFull sizeL">전체상품주문</a>
                  <a href="#none" class="btnNormal gFull sizeL">선택상품주문</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--#ez="1/1"-->
    </div>
  </div>
  <!--#ez="1/5"-->
</div>
<!-- //wrap -->
<script type="text/javascript">
  IMP.init("imp65865212");
  //결제 portone
  async function pay(){
    const response = IMP.request_pay(
      {
        channelKey: "channel-key-25b060d8-f0ea-4057-bb0d-ba89c6945247",
        pay_method: "EASY_PAY",
        merchant_uid: `payment-`+generateUUID(), // 주문 고유 번호
        name: productsList(),
        amount: $("#total_price2").text().replace(/[^0-9]/g, ''),
        buyer_email: "${sessionScope.email}",
        buyer_name: "${sessionScope.name}",
        buyer_tel: "${sessionScope.phone}",
        m_redirect_url:window.location.host+"/web/event/cart_ok.do",
        customData:{
          user_id: "${user_id}"
        }
      },
      async (response) => {
        if (response.error_code != null) {
          return alert(`결제에 실패하였습니다. 에러 내용: `+response.error_msg);
        }
        console.log(response.imp_uid);
        console.log(response.merchant_uid);
        const order = await fetch("order_ok.do", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          // imp_uid와 merchant_uid, 주문 정보를 서버에 전달합니다
          body: JSON.stringify({
            imp_uid: response.imp_uid, //실결제 검증 생략
            order_id: response.merchant_uid, //uuid
            user_id: "${user_id}"
          }),
        }).then((order) => {return order.json()})
          .then((data) => {
            console.log(data.statement);
            if(confirm("주문이 완료되었습니다.")) document.location = '../mypage/event_list.do';
          })
      },
    );
  }

  //결제상품 이름 가져오기
  function productsList() {
    let products = "";
    $(".ec-product-name").each(function () {
      products += $(this).text() + ", ";
    });
    products = products.substring(0, products.length - 2);
    console.log(products);
    return products;
  }

  //전체 주문하기
  $(".btnSubmit").on("click",function(e){
    e.preventDefault();
    pay();
  });

  //변경버튼 클릭 시
  $(".sizeQty").on("click",function(e){
    e.preventDefault();
    qchange(this); //상품 실제 주문금액 반영
    total()//총 상품금액 반영
    cartUpdate(this); //cart 테이블 업데이트
  });

  //업데이트 ajax
  async function cartUpdate(t){
    let index=$(t).attr("data-index"); //카트의 상품 인덱스
    let content_id=$(t).closest(".thisContent").attr("data-id");
    let account=$("input[name=account"+index+"]").val();
    let price=$(t).closest(".thisContent").find(".price strong").text().replace(/[^0-9]/g, '');
    let total_price=$(t).closest(".thisContent").find(".sumPrice strong").text().replace(/[^0-9]/g, '');
    let content=content_id+"/"+account+"/"+price+"/"+total_price+"/update";
    try{
      let response=await axios({
        method:'post',
        url:'cart_insert.do',
        headers:{
          "Content-Type":"application/json"
        },
        data:{
          "content":content
        }
      });
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }

  //삭제 버튼 클릭 시
  $(".btnDelete").on("click",function(e){
    e.preventDefault();
    cartDelete(this); //삭제 수행
    $(this).closest(".thisContent").remove(); //페이지에서 요소 삭제
    total(); //총 금액 변경
  });

  //삭제 ajax
  async function cartDelete(t){
    let cno=$(t).closest(".thisContent").attr("data-cno");
    try{
      let response=await axios({
        method:'post',
        url:'cart_delete.do',
        headers:{
          "Content-Type":"application/json"
        },
        params:{"cno":cno}
      })
      console.log(response);
      if(response.data.statement=="success"){ //삭제 성공
        console.log("삭제");
      }else{
        console.log(response.data.statement);
        console.log("삭제실패");
      }
      if(response.data.eventcart!=null){ //장바구니 수량 업데이트
        $("nav .cart_num").text(response.data.eventcart);
      }else{
        console.log(response.data);
      }
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }

  //수량버튼
  $(document).on("click",".ec-base-qty a",function(e) {
    e.preventDefault();
    let count = Number($(e.target).siblings("input").val());
    if ($(e.target).hasClass("down")) {
      if (count > 1) { //1개 미만 불가능(삭제버튼으로만 삭제 가능)
        $(e.target).siblings("input").val(count - 1);
      }
    } else if ($(e.target).hasClass("up")) {
      if (count < 10) { //같은 상품 10개 초과 불가능
        $(e.target).siblings("input").val(count + 1);
      }
    }
  })
  //상품 주문 금액 변경
  function qchange(t){
    let count=Number($(t).siblings(".ec-base-qty").find("input").val()); //수량
    console.log("count:"+$(t).siblings(".ec-base-qty input").val());
    let p = $(t).closest(".thisContent").find(".price strong").text().trim();
    console.log("price:"+p);
    if(p=="무료") p="0";
    let price = p.replace(/[^0-9]/g, ""); //상품개별금액
    console.log("price replace:"+price);

    $(t).closest(".thisContent").find(".sumPrice strong").text((price*count).toLocaleString('ko-KR'));
  }

  //총 상품 금액 변경
  function total(){
    let total=0;
    $(".sumPrice strong").map(function(index,el){
      total+=Number($(el).text().trim().replace(/[^0-9]/g, ""));
    });
    $("#total_price, #total_price2").text(total.toLocaleString('ko-KR'));
  }

  // uuid
  function generateUUID() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    const r = Math.random() * 16 | 0;
    const v = c === 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
  }

  //페이지 진입 시 총 상품 금액 초기화
  total();

</script>
</script>
</body>
</html>


