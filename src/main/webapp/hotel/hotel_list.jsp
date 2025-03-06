<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>숙소 검색</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-horizontal {
      display: flex;
      flex-direction: row;
    }
    .card-horizontal img {
      width: 200px; /* 이미지 크기 조정 */
      height: 150px;
      object-fit: cover;
    }
    .card-body {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    .line-3{
    	margin-top: 20px;
    }
    .line-4{
    	margin-top: 15px;
    }
    ul {
  		list-style-type: none; /* 기본 점 제거 */
		padding-left: 0; /* 왼쪽 여백 제거 */
	}
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <!-- Left Sidebar -->
      <div class="col-md-3 p-3 bg-light">
        <h4>숙소 필터</h4>
        <form>
          <button class="btn btn-primary mb-2 w-100">필터 1</button>
          <button class="btn btn-secondary mb-2 w-100">필터 2</button>
          
		  <hr class="my-3"> <!-- 구분선 -->
		  
		  <h5>숙소 유형</h5>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="low" checked>
            <label class="form-check-label line-4" for="lowPrice"> 전체 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 관광호텔 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 콘도미니엄 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 유스호스텔 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 모텔 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 민박 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 게스트하우스 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 서비스드레지던스 </label>
          </div>
          <div class="form-check">
            <input class="form-check-input line-3" type="radio" name="sortOption" id="highPrice" value="high">
            <label class="form-check-label line-4" for="highPrice"> 한옥 </label>
          </div>
          
          
		  <hr class="my-3"> <!-- 구분선 -->
		  
		  <div class="mt-3">
            <h5>가격 범위</h5>
            <input type="range" class="form-range" id="priceRange" min="0" max="10000" step="100">
          </div>
        </form>
		  
		  	
		  <hr class="my-3"> <!-- 구분선 -->
		  
          <div class="mt-3">
		  	<h5>#지역</h5>
	  			<span class="d-flex flex-wrap w-100">
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">서울</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">부산</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">제주</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">강릉</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">광주</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">서울</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">부산</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">제주</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">강릉</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">광주</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">부산</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">제주</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">강릉</button>
				    <button type="button" class="btn btn-outline-secondary me-2 mb-2 rounded">광주</button>
			    </span>
		  </div>
		  
		  
		  
		  
      	</div>
		  
      <!-- Right Sidebar (숙소 리스트) -->
      <div class="col-md-9 p-3">
        <div class="row">
          <!-- 숙소 카드 -->
          <c:forEach var="vo" items="${list }">
          <div class="col-md-12 mb-3">
            <div class="card card-horizontal">
              <img src="${vo.firstImage }" class="card-img-left" alt="숙소 이미지">
              <div class="card-body">
                <h5 class="card-title">${vo.title }</h5>
                <p class="card-text">${vo.addr1 }</p>
                <p class="card-text"></p>
              </div>
            </div>
          </div>
          </c:forEach>

        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

