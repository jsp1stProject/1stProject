<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 28.
  Time: 오후 2:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<div class="buy-wrap" id="review">
  <form action="" method="post" name="review_insert">
    <div class="popinner">
      <div class="review-content">
        <c:choose>
          <c:when test="${reviewmode eq 'update'}">
            <p class="title">내 리뷰</p>
            <input type="hidden" name="order_id">
            <input type="hidden" name="reviewmode" value="update">
          </c:when>
          <c:otherwise>
            <p class="title">리뷰 쓰기</p>
          </c:otherwise>
        </c:choose>
        <div class="user-score" id="review-starbtn" data-score="5">
          <button type="button" class="star" id="star1">1점</button>
          <button type="button" class="star" id="star2">2점</button>
          <button type="button" class="star" id="star3">3점</button>
          <button type="button" class="star" id="star4">4점</button>
          <button type="button" class="star" id="star5">5점</button>
        </div>
        <input type="hidden" name="rate" value="5">
        <input type="hidden" name="content_id" value="${vo.content_id}">
        <c:if test="${fn:length(orderlist) ne 0 || reviewmode ne 'update'}">
          <p class="mb-1 mx-1">어떤 구매 내역으로 리뷰를 작성할까요?</p>
          <select name="order_id">
            <C:forEach items="${sessionScope.orderlist2}" var="ovo">
              ${ovo}
              ${vo}
              <option value="${ovo.order_id}">${ovo.dbday} ${ovo.account}매 구매</option>
            </C:forEach>
          </select>
        </c:if>
        <textarea name="message" class="review-textarea" placeholder="어떤 경험을 했는지 알려주세요." required></textarea>
      </div>
      <div class="submitwrap">
        <button type="submit" class="cart" id="review_insert">리뷰 작성하기</button>
      </div>
    </div>
  </form>
</div>
<script type="text/javascript">
  //리뷰 팝업 띄우기
  $(document).on("click","#reviewbtn",function(){
    $("#review").addClass("active");
    $("#review").removeClass("off");
  });
  $(document).on("click","#review",function(e){
    if(e.target!==this) return
    $("#review").removeClass("active");
    $("#review").addClass("off");
  });
  //리뷰 별점 작성
  $(document).on("click","#review-starbtn button",function(e){
    let star=$(this).attr("id").substr(4,4);
    $("#review-starbtn").attr("data-score",star);
    $("input[name=rate]").val(star);
  });
  //리뷰 submit 이벤트
  const form=$("form[name=review_insert]")[0];
  $(form).on("submit",function(e){
    e.preventDefault();
    if(!form.checkValidity()){
      form.reportValidity();
      return;
    }
    reviewInsert();
  });
  //리뷰 insert ajax
  async function reviewInsert(){
    try{
      let formData=new FormData(form);
      for (const x of formData) {
        console.log(x);
      };
      let response=await axios({
        method:'post',
        url:'review_insert.do',
        headers:{
          "Content-Type":"application/json"
        },
        data:formData
      })
      console.log(response);
      if(response.data.statement=="success"){
        alert(response.data.message);
        location.reload();
      }else{
        alert("리뷰를 작성할 수 없습니다.\n새로고침 후 다시 시도해주세요.")
      }
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }
</script>
</body>
</html>
