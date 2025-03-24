<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr@4.6.9/dist/l10n/ko.js"></script>
<style type="text/css">
.custom-ok-btn {
    display: block;
    width: 100%;
    padding: 5px;
    background-color: #007bff;
    color: white;
    text-align: center;
    border: none;
    cursor: pointer;
    margin-top: 5px;
    border-radius: 5px;
}
.weekend {
        color: red !important;
    }
.mb-3 {
	margin-bottom: 0 !important;
}
.form-label {
	margin-bottom: 0 !important;
}
@media (min-width: 992px) {
  .input-group {
    max-width: 280px;
  }
}
#dateInput {
	margin-top: 20px;
}
#overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 반투명한 어두운 배경 */
    z-index: 9999; /* 달력보다 위에 표시 */
}
</style>
<script type="text/javascript">
	$(function() {
		  var today = new Date();
		  var mm = String(today.getMonth() + 1).padStart(2, '0'); // 월
		  var dd = String(today.getDate()).padStart(2, '0'); // 일
		  var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
		  var dayOfWeek = daysOfWeek[today.getDay()]; // 오늘의 요일

		  var currentDate = mm + '-' + dd + ' (' + dayOfWeek + ')'; // MM-DD (요일) 형식으로 결합

		  $('#dateInput').attr('placeholder', currentDate);
		});
</script>
</head>
<body>
	<div class="container">
		<a href="#">&lt; 뒤로가기</a>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-12 order-2 order-md-1">
				<div class="input-group input-group-lg">
				  <input type="text" class="form-control" id="dateInput" placeholder="날짜 선택하기" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
				</div>
				<p id="selectedDateTime"></p>
				<hr class="text-muted">
				<h5>예약자 정보</h5>
				<form>
					<div class="mb-3">
						<label for="name" class="form-label text-secondary small">예약자 이름</label>
						<input type="text" class="form-control" id="name" placeholder="이름을 입력하세요" style="width: 300px;" >
					</div>
					<div class="mb-3">
						<label for="phone" class="form-label text-secondary small">전화번호</label>
						<input type="tel" class="form-control" id="phone" placeholder="전화번호를 입력하세요" style="width: 300px;">
					</div>
				</form>
				<hr class="text-muted">
				<p>
					======================== 쿠폰 목록 ========================
					
				</p>
				<hr class="text-muted">
				<p>
					======================== 결제 수단 목록 ========================
				</p>
				
			</div>
			<div class="col-md-4 col-12 order-1 order-md-2">
				<div class="card" style="width: 18rem; margin-bottom: 30px;">
					<img src="../assets/img/hotel2.jpg" class="card-img-top">
					<div class="card-body">
						<h5 class="card-title">건대 호텔 더 디자이너스 프리미어 성수 AND 건대</h5>
						<p class="card-text small">
							<span class="text-secondary">객실</span>
							<span class="fst-italic">디럭스더블(대형TV, 넷플릭스, 욕조, 공기청정기...)</span>
						</p>
						<p class="card-text small">
							<span class="text-secondary">일정</span>
							<span class="fst-italic">2025-03-28 11:00 - 2025-03-29 12:00</span>
						</p>
					</div>
				</div>
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<p class="card-title">결제 정보</p>
						<p class="card-subtitle mb-2 text-muted fs-6" style="display: inline">객실 가격</p><span>50,000원</span>
						<hr class="text-muted">
						<p class="card-subtitle mb-2 fs-6" style="display: inline">총 결제 금액</p><span>50,000원</span>
						<hr class="text-muted">
						<button type="button" class="btn btn-primary btn-lg">50,000원 결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	
	const datepickr = $('#dateInput').flatpickr();
	
	flatpickr(datepickr, {
		onOpen: function () {
			$('body').append('<div id="overlay"></div>');
	    },
	    onClose: function () {
	    	$('#overlay').remove();
	    }
	});
	

/*
 	달력: 
 		주말 빨간색 표시
 		국경일 빨간색 표시
 		OK 버튼
 	대실:
 		시간 ~ 시간 형식으로 대실 시간 지정
 		시간 선택하는 select 옵션
 	숙박: 
 		// 날짜 활성화
 		const randomDates = [
 			  "2025-03-20",
 			  "2025-03-22",
 			  "2025-03-24"
 			];

 			flatpickr("#datepicker", {
 			  enable: randomDates
 			});
		
		// 날짜 비활성화
		const randomDisabledDates = [
			  "2025-03-19",
			  "2025-03-21",
			  "2025-03-23"
			];

			flatpickr("#datepicker", {
			  disable: randomDisabledDates
			});

 */

/*
 	$(document).ready(function () {
	    const showCalendar = (options) => {
	        let reserveDate = document.getElementById("dateInput");
	        //reserveDate.style.display = "block";

	        flatpickr(reserveDate, {
	            locale: "ko",
	            ...options,
	            onReady: (selectedDates, dateStr, instance) => {
	                if (!$(".custom-ok-btn").length) {
	                    let $okButton = $("<button>")
	                        .text("OK")
	                        .addClass("custom-ok-btn")
	                        .on("click", () => instance.close());

	                    $(instance.calendarContainer).append($okButton);
	                }
	            },
	            onDayCreate: function (dObj, dStr, fp, dayElem) {
	                let date = dayElem.dateObj;
	                let day = date.getDay(); // 0: 일요일, 6: 토요일
	                let currentMonth = fp.currentMonth; // 현재 보고 있는 달
	                let dateMonth = date.getMonth(); // 날짜의 달
	                let minDate = new Date(fp.config.minDate); // minDate를 Date 객체로 변환

	                if (date >= minDate && dateMonth === currentMonth && (day === 0 || day === 6)) {
	                    $(dayElem).addClass("weekend"); // 현재 달의 주말만 빨간색
	                }
	            }
	        });
	    };

	    $("#dateInput").on("click", function () {
	        showCalendar({
	            enableTime: true,
	            noCalendar: false,
	            dateFormat: "Y-m-d (1)",
	            minDate: "today",
	            defaultHour: 12,
	        });
	    });

	});

*/
</script>
</body>
</html>