<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
</head>
<body class="bg-gray-100 p-6">
  <div class="max-w-4xl mx-auto p-4 bg-white rounded-lg shadow-lg">
    <div class="grid grid-cols-2 gap-4">
      <div class="relative">
        <img src="${vo.cvo.first_image }" alt="Hotel interior" class="w-full h-auto rounded-lg" />
        <span class="absolute top-2 left-2 bg-red-500 text-white text-sm font-bold px-2 py-1 rounded">할인</span>
      </div>
      <div class="grid grid-cols-2 gap-2">
        <img src="https://placehold.co/300x200" alt="Room 1" class="w-full h-auto rounded-lg" />
        <img src="https://placehold.co/300x200" alt="Room 2" class="w-full h-auto rounded-lg" />
        <img src="https://placehold.co/300x200" alt="Room 3" class="w-full h-auto rounded-lg" />
        <img src="https://placehold.co/300x200" alt="Building exterior" class="w-full h-auto rounded-lg" />
      </div>
    </div>
    <div class="mt-4">
      <h2 class="text-xl font-bold text-gray-900">${vo.cvo.title }</h2>
      <p class="text-sm text-gray-600">예약가능</p>
      <div class="flex items-center mt-1">
        <span class="text-green-500 font-bold">9.3</span>
        <span class="text-gray-600 ml-2">4,991명 평가</span>
      </div>
      <p class="text-lg font-semibold text-blue-600">47,500 원~</p>
      <p class="text-sm text-gray-600">위치 정보</p>
      <p class="text-sm text-gray-600">서울 광진구 화양동 23-15</p>
      <a href="#" class="text-blue-500 hover:underline">지도보기</a>
    </div>
    <div class="space-y-6">
  <c:forEach var="hrvo" items="${list}">
  <div class="bg-card p-4 rounded-lg shadow-md flex items-center">
    <img class="w-48 h-48 object-cover rounded-lg mr-4" src="https://placehold.co/600x400" alt="Deluxe Room" />
    <div>
      <div class="flex justify-between items-center">
        <span class="text-lg font-semibold">${hrvo.roomtitle}</span>
        <span class="bg-accent text-accent-foreground px-2 py-1 rounded-full">19+</span>
      </div>
      <div class="mt-2">
        <h3 class="text-md font-medium">대실</h3>
        <p>⏳ 4시간 이용</p>
        <p>💰 2,500원 쿠폰 적용가: <span class="font-bold text-primary">47,500원</span></p>
        <button class="bg-secondary text-secondary-foreground hover:bg-secondary/80 mt-2 p-2 rounded">대실 예약</button>
      </div>
      <div class="mt-4">
        <h3 class="text-md font-medium">숙박</h3>
        <p>🕒 입실 20:00</p>
        <p>🕑 퇴실 13:00</p>
        <p>💰 4,500원 쿠폰 적용가: <span class="font-bold text-primary">75,500원</span> (기준2인, 최대3인)</p>
        <button class="bg-secondary text-secondary-foreground hover:bg-secondary/80 mt-2 p-2 rounded">숙박 예약</button>
      </div>
    </div>
  </div>
  </c:forEach>
  <!--
  <div class="bg-card p-4 rounded-lg shadow-md flex items-center">
    <img class="w-48 h-48 object-cover rounded-lg mr-4" src="https://placehold.co/600x400" alt="Deluxe Twin Room" />
    <div>
      <div class="flex justify-between items-center">
        <span class="text-lg font-semibold">디럭스트윈 (75"대형TV, 넷플릭스, 온열매트, 공기청정기, 침구류전면교체, 드라이기&고데기)</span>
        <span class="bg-accent text-accent-foreground px-2 py-1 rounded-full">3+</span>
      </div>
      <div class="mt-2">
        <h3 class="text-md font-medium">대실</h3>
        <p>⏳ 4시간 이용</p>
        <p>💰 2,500원 쿠폰 적용가: <span class="font-bold text-primary">47,500원</span></p>
        <button class="bg-secondary text-secondary-foreground hover:bg-secondary/80 mt-2 p-2 rounded">대실 예약</button>
      </div>
    </div>
  </div> -->
</div>
  </div>
</body>
</html>