<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 10.
  Time: 오후 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>템플릿 기본 사용법</title>
    <link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
    <!--css나 img 파일 경로는 위처럼 pageContext 사용해서 적어주시면 됩니다 -->
</head>
<body>
    <div class="container"><!--페이지 제일 바깥은 container class로 감싸주시면 기본 너비 적용-->
        <!--기본보다 넓은 width 사용하려면 model에서 setAttribute("wide","y"); 추가 -->
        <!--넓은 화면 예시는 /main/search.do 에서 확인 -->

        <!--이 안은 bootstrap 5.0 가이드 참고하셔서 자유롭게 구성하시면 됩니다 -->
        <!--https://getbootstrap.kr/docs/5.3/getting-started/introduction/ -->


        <!--아래는 기본 예시 -->
        <div class="row">
            <div class="col-3"></div>
            <!--레이아웃을 가로로 나누고 싶을 때는 row 안에 col을 넣기 -->
            <!--부트스트랩은 총 12 colomn 레이아웃이라서 숫자를 다 더해서 12가 되기만 하면 마음대로 나눌 수 있어요 -->
            <!--가로너비에 따라 반응형도 가능. -->
            <div class="col-9"></div>
        </div>
        <div class="row">
            <div class="col-lg-1 col-6"></div>
            <!--이렇게 하면 큰 화면일 때는 가로전체, 작은 화면일 때는 절반씩 차지하게 됩니다-->
            <div class="col-lg-1 col-6"></div>
        </div>
        <!--화면을 나눌 필요가 없으면 row는 안 쓰셔도 돼요-->
    </div>
</body>
</html>
