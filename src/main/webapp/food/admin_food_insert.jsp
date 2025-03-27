<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시글 수정</title>
    
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
            
        }
        .container-i {
            max-width: 700px;
            margin-top: 50px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        .btn-group {
            display: flex;
            justify-content: flex-end;
        }
        .btn {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<div class="container-i" style="margin:0 auto">
  
    <div class="card">
        <div class="card-header">
            ✏️ 맛집 추가
        </div>
        <div class="card-body">
            <form action="../food/food_insert_ok.do" method="post">
                <!-- 게시글 번호 (숨김 필드) -->
                <input type="hidden" name="fno" value="${vo.fno }">

                <!-- 제목 -->
                <div class="mb-3">
                    <label for="title" class="form-label">맛집명</label>
                    <input type="text" class="form-control" id="name" name="name" value="" required>
                </div>
				<div class="mb-3">
                    <label for="title" class="form-label">맛집 유형</label>
                    <input type="text" class="form-control" id="type" name="type" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="address" class="form-label">주소</label>
                    <input type="text" class="form-control" id="address" name="address" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="theme" class="form-label">테마</label>
                    <input type="text" class="form-control" id="theme" name="theme" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">전화번호</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="price" class="form-label">가격대</label>
                    <input type="text" class="form-control" id="price" name="price" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="poster" class="form-label">사진</label>
                    <input type="text" class="form-control" id="poster" name="poster" value="" required>
                </div>
                
                <div class="mb-3">
                    <label for="time" class="form-label">시간</label>
                    <input type="text" class="form-control" id="time" name="time" value="" required>
                </div>

                <!-- 내용 -->
                <div class="mb-3">
                    <label for="content" class="form-label">내용</label>
                    <textarea class="form-control" id="content" name="content" rows="6" required></textarea>
                </div>

                <!-- 버튼 그룹 -->
                <div class="btn-group">
                    <input type=button value="취소" class="btn btn-secondary btn-sm"
                   onclick="javascript:history.back()">
                    <button type="submit" class="btn btn-primary">추가</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../../plugins/jquery/jquery.min.js"></script>
</body>
</html>
