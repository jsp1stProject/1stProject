<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 25.
  Time: 오후 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<body>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <div class="container pt-3">
    <div class="row justify-content-center">
      <jsp:include page="mynav.jsp"></jsp:include>
      <div class="col-lg-9 col-12">
        <h3 class="pt-3 pt-lg-0 pb-3">회원 탈퇴</h3>
        <div class="myinfo">
          <c:choose>
            <c:when test="${mode eq 1}">
              <form action="withdraw.do" method="post" name="password">
                <label for="pwd">비밀번호</label>
                <input type="password" id="pwd" name="pwd" placeholder="비밀번호" required>
                <input type="hidden" id="user_id" name="user_id" value="${sessionScope.user_id}">
                <button type="submit" class="btn btn-black" id="submit">확인</button>
              </form>
            </c:when>
            <c:when test="${mode eq 2}">
              <p>탈퇴 후 삭제된 계정은 복구할 수 없습니다.</p>
              <p>정말 탈퇴하시겠습니까?</p>
              <button type="button" class="btn-black mb-2" id="withdraw">탈퇴하기</button>
              <button type="button" class="btn-white" onclick="location.href='../main/main.do'">메인으로</button>
            </c:when>
          </c:choose>

        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<c:if test="${mode eq 1}"> <%--탈퇴 전 비밀번호 검증--%>
<script type="text/javascript">

</script>
</c:if>

<c:if test="${mode eq 2}"> <%--탈퇴 진행 페이지--%>
  <script type="text/javascript">
    //탈퇴 ajax
    //1.버튼에 이벤트 추가
    $("#withdraw").on("click",function(){
      withdraw();
    });
    //2.탈퇴
    async function withdraw(){
      try{
        let response=await axios({
          method:'post',
          url:'withdrawExecute.do',
          headers:{
            "Content-Type":"application/json"
          },
          params:{"user_id":"${sessionScope.user_id}"}
        })
        console.log(response);
        if(response.data.statement=="success"){
          if(confirm("계정이 탈퇴되었습니다. 3초 뒤 메인페이지로 이동합니다.")){
            setTimeout('location.href="../main/main.do"', 3000);
          }
        }else{
          toast(response.data.statement);
          toast("이런, 문제가 발생했어요.")
        }
      }catch(e){
        console.log(e);
        throw new Error(e);
      }
    }

    //toast 메시지
    function toast(msg) {
      Toastify({
        text: msg,
        duration: 3000,
        newWindow: true,
        close: true,
        gravity: "bottom", // `top` or `bottom`
        position: "right", // `left`, `center` or `right`
        stopOnFocus: true, // Prevents dismissing of toast on hover
        style: {
          background: "linear-gradient(to right, #00b09b, #96c93d)",
        },
        onClick: function () {
        } // Callback after click
      }).showToast();
    }
  </script>
</c:if>

<c:if test="${mode eq 3}"> <%--비밀번호 불일치로 강제 로그아웃--%>
  <script type="text/javascript">
    alert("비밀번호가 일치하지 않습니다.\n잠시 뒤 메인 페이지로 이동합니다.");
    setTimeout('location.href="../main/main.do"', 3000);
  </script>
</c:if>
<script type="text/javascript">

</script>
</body>
</html>
