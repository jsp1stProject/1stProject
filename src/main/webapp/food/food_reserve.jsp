<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            text-align: left;
        }
        select, input {
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
</head>
<body>
    <% String fno = request.getParameter("fno"); %>
    <div class="reservation-container">
        <h2>맛집 예약</h2>
        <form action="../food/food_reserve_ok.do" method="post">
            <label for="restaurant">예약할 맛집:</label>
            <input type="text" id="restaurant" name="restaurant" value="${vo.name }" readonly>
            
            <label for="date">날짜 선택:</label>
            <input type="date" id="date" name="date" required>
            
            <label for="time">시간 선택:</label>
            <input type="time" id="time" name="time" required>
            
            <label for="people">인원 수:</label>
            <input type="number" id="people" name="people" min="1" max="10" required>
            
            <button type="submit">예약하기</button>
        </form>
    </div>
</body>
</html>
