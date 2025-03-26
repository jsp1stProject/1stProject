<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 25.
  Time: 오후 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="mynav col-lg-3 col-12">
    <div class="list-group d-none d-lg-block" id="list-tab" role="tablist">
        <a class="list-group-item list-group-item-action active" href="#" role="tab">내 정보</a>
        <a class="list-group-item list-group-item-action" href="#" role="tab">1:1 문의</a>
        <a class="list-group-item list-group-item-action" href="#" role="tab">찜</a>
        <a class="list-group-item list-group-item-action" href="#" role="tab">리뷰</a>
        <a class="list-group-item list-group-item-action" href="#" role="tab">쿠폰</a>
    </div>
    <%--메뉴 추가할 때 위아래 목록 2개에 모두 추가해주세요--%>
    <div class="btn-group d-block d-lg-none mobilenav">
        <button class="btn dropdown-toggle col-12" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            ${title} <%--setattribute로 title 지정--%>
        </button>
        <ul class="dropdown-menu col-12" aria-labelledby="dropdownMenuButton">
            <li><a class="dropdown-item" href="#">내 정보</a></li>
            <li><a class="dropdown-item" href="#">1:1 문의</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">찜</a></li>
            <li><a class="dropdown-item" href="#">리뷰</a></li>
            <li><a class="dropdown-item" href="#">쿠폰</a></li>
        </ul>
    </div>
</div>
