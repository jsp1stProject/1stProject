<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr@4.6.9/dist/l10n/ko.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/dark.css">
<style type="text/css">
.btn-primary {
    color: #fff;
    background-color: #3A8FFA;
    border-color: #1f9edd;
}
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
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 9999;
}
</style>
<script type="text/javascript">

	$(function() {
		  var today = new Date();
		  var mm = String(today.getMonth() + 1).padStart(2, '0');
		  var dd = String(today.getDate()).padStart(2, '0');
		  var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
		  var dayOfWeek = daysOfWeek[today.getDay()];

		  var currentDate = mm + '-' + dd + ' (' + dayOfWeek + ')';

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
				<hr class="text-muted">
				<h5>예약 날짜</h5>
				<div class="input-group input-group-lg">
				  <input type="text" class="form-control" id="dateInput" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" readonly>
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
					<div class="mb-3">
						<h5 style="margin-top: 10px;">방문 방법</h5>
						<input type="radio" class="btn-check" name="options" id="option1" autocomplete="off" checked>
						<label class="btn btn-outline-secondary" for="option1">도보</label>
						
						<input type="radio" class="btn-check" name="options" id="option2" autocomplete="off">
						<label class="btn btn-outline-secondary" for="option2">차량</label>
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
					<img src="${vo.hrvo.img1 }" class="card-img-top">
					<div class="card-body">
						<h5 class="card-title">${vo.cvo.title }</h5>
						<p class="card-text small">
							<span class="text-secondary">객실</span>
							<span class="fst-italic">${vo.hrvo.roomtitle }(${facility })</span>
						</p>
						<p class="card-text small">
							<span class="text-secondary">일정</span>
							<span class="fst-italic" id="selectedDate"></span>
						</p>
					</div>
				</div>
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<p class="card-title" style="font-weight: bold;">결제 정보</p>
						<p class="card-subtitle mb-2 text-muted fs-6" style="display: inline">객실 가격&nbsp;&nbsp;</p>
							<span><fmt:formatNumber value="${vo.hrvo.offseason_minfee1}" pattern="#,###" /> 원</span>
						<hr class="text-muted">
						<p class="card-subtitle mb-2 text-muted fs-6" style="display: inline">총 결제 금액&nbsp;&nbsp;</p>
							<span><fmt:formatNumber value="${vo.hrvo.offseason_minfee1}" pattern="#,###" /> 원</span>
						<hr class="text-muted">
						<button type="button" class="btn btn-primary btn-lg"><fmt:formatNumber value="${vo.hrvo.offseason_minfee1}" pattern="#,###" /> 원 결제하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
	const datepickr = $('#dateInput').flatpickr({
		locale: 'ko',
		enableTime: true,
		minTime: '12:00',
		maxTime: '21:00',
		minDate: 'today',
		dateFormat: 'm.d H:00 (D)',
		defaultDate: new Date(),
	    onOpen: function() {
	        $('body').append('<div id="overlay"></div>');
	    },
	    onClose: function() {
	        $('#overlay').remove();
	    },
	    onDayCreate: function(dObj, dStr, fp, dayElem) {
	        let date = new Date(dayElem.dateObj);
	        let day = date.getDay(); 
	
	        if (day === 0 || day === 6) { 
	            $(dayElem).css('color', 'red'); 
	        }
	        if ($(dayElem).hasClass('flatpickr-disabled')) {
	            $(dayElem).css('color', ''); 
	        }
	    },
	    onChange: function(selectedDates, dateStr, instance) {
	        if (selectedDates.length === 1) {
	            const startDate = selectedDates[0];
	            const startFormatted = formatDate(startDate);
	            const endDate = new Date(startDate.getTime());
	            endDate.setHours(endDate.getHours() + 4);
	            const endFormatted = formatDate(endDate);
	            $('#selectedDate').text(startFormatted + ' ~ ' + endFormatted);
	        }
	    }
	});

	function formatDate(date) {
	    const month = date.getMonth() + 1;
	    const day = date.getDate();
	    const hours = date.getHours();
	    const minutes = date.getMinutes();
	    const weekDays = ['일', '월', '화', '수', '목', '금', '토'];
	    const weekDay = weekDays[date.getDay()];

	    return month + '.' + day + ' ' + hours + ':00' + ' (' + weekDay + ')';
	}
	$(document).ready(function() {
	    const selectedDates = datepickr.selectedDates;
	    if (selectedDates.length === 2) {
	        const startDate = selectedDates[0];
	        const endDate = selectedDates[1];

	        const startFormatted = formatDate(startDate);
	        const endFormatted = formatDate(endDate);

	        $('#selectedDate').text(startFormatted + ' ~ ' + endFormatted);
	    }
	});
</script>
</body>
</html>