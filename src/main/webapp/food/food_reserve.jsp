<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sist.vo.*" %>

<%
    FoodVO fvo = (FoodVO) request.getAttribute("fvo");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>맛집 예약</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .reservation-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .message {
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            display: none;
            font-weight: bold;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            text-align: left;
        }
        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }
        button {
            margin-top: 20px;
            background-color: #03C75A;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 6px;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background-color: #028a3f;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="reservation-container">
        <h2>맛집 예약</h2>

        <!-- 성공/실패 메시지 표시 -->
        <div id="messageBox" class="message"></div>

        <form id="reservationForm">
            <label for="restaurant">예약할 맛집:</label>
            <input type="text" id="restaurant" name="name" value="${fvo.name }" readonly>

            <label for="date">날짜 선택:</label>
            <input type="date" id="date" name="res_date" required>

            <label for="time">시간 선택:</label>
            <input type="time" id="time" name="res_time" required>

            <label for="people">인원 수:</label>
            <input type="number" id="people" name="people" min="1" max="10" required>

            <button type="submit">예약하기</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            $("#reservationForm").submit(function(event) {
                event.preventDefault(); // 기본 제출 동작 방지

                $.ajax({
                    type: "POST",
                    url: "../food/food_reserve_ok.do",
                    data: $(this).serialize(), // 폼 데이터 직렬화
                    success: function(response) {
                        $("#messageBox").text("예약이 성공적으로 완료되었습니다!")
                                       .addClass("success")
                                       .removeClass("error")
                                       .fadeIn();

                        // 3초 후 메시지 숨기기
                        setTimeout(function() {
                            $("#messageBox").fadeOut();
                        }, 3000);

                        // 입력 폼 초기화
                        $("#reservationForm")[0].reset();
                    },
                    error: function() {
                        $("#messageBox").text("예약 중 오류가 발생했습니다. 다시 시도해주세요.")
                                       .addClass("error")
                                       .removeClass("success")
                                       .fadeIn();

                        setTimeout(function() {
                            $("#messageBox").fadeOut();
                        }, 3000);
                    }
                });
            });
        });
    </script>
</body>
</html>
