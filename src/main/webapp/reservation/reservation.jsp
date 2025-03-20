<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
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
</style>
</head>
<body>
	<div class="container">
		<a href="#">&lt; 뒤로가기</a>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-12 order-2 order-md-1">
				=============================================================<br>
				<input type="button" class="btn btn-secondary" value="대실" id="Time">
				<input type="button" class="btn btn-secondary" value="숙박" id="Stay"><br>
				<input type="date" id="reserveDate" placeholder="날짜 및 시간 선택" size="30" style="display: none; margin-top: 20px;">
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
/*
 	달력: 
 		주말 빨간색 표시
 		국경일 빨간색 표시
 		OK 버튼
 	대실:
 		시간 ~ 시간 형식으로 대실 시간 지정
 		시간 선택하는 select 옵션
 	숙박: 
 		
 */


	const showCalendar = (options) => {
		let reserveDate = document.getElementById("reserveDate");
		reserveDate.style.display = "inline";
		flatpickr(reserveDate, {
			locale: "ko",
			...options,
			onReady: (selectedDates, dateStr, instance) => {
				if (!document.querySelector(".custom-ok-btn")) {
					let okButton = document.createElement("button");
					okButton.innerText = "OK";
					okButton.className = "custom-ok-btn";
					okButton.addEventListener("click", () => instance.close());
					
					instance.calendarContainer.appendChild(okButton);
				}
			},
			onDayCreate: function(dObj, dStr, fp, dayElem) {
				let date = dayElem.dateObj;
	            let day = date.getDay(); // 0: 일요일, 6: 토요일
	            let currentMonth = fp.currentMonth; // 현재 보고 있는 달 (0: 1월, 1: 2월, ...)
	            let dateMonth = date.getMonth(); // 날짜의 달 (0: 1월, 1: 2월, ...)
	            let minDate = new Date(fp.config.minDate); // minDate를 Date 객체로 변환

	            if (date >= minDate && dateMonth === currentMonth && (day === 0 || day === 6)) {
	                dayElem.classList.add("weekend"); // 현재 달의 주말만 빨간색
	            }
	        }
		});
	};
	
	document.getElementById("Time").addEventListener("click", () => {
		showCalendar({
			enableTime: true,
			noCalendar: false,
			dateFormat: "Y-m-d H:i",
			minDate: "today",
			//maxDate: "today",
			defaultHour: 12,
		});
	});
	
	document.getElementById("Stay").addEventListener("click", () => {
		showCalendar({
			enableTime: false,
			noCalendar: false,
			dateFormat: "Y-m-d",
			minDate: "today",
			mode: "range",
		});
	});
</script>
</body>
</html>