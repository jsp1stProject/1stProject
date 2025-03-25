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
    max-width: 510px;
  }
}
#dateInput {
	margin-top: 20px;
}
#count {
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
.input-group {
	gap: 5px;
}
.popup {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	border: 1px solid #ccc;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 10px;
	z-index: 1000;
	text-align: center;
	width: 100%;
	box-sizing: border-box;
	z-index: 10000;
}
.popup-content {
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.counter-text {
	text-align: left;
	font-size: 16px;
}
.counter-btn {
	cursor: pointer;
	padding: 5px 10px;
	background-color: #ccc;
	border: none;
	font-size: 16px;
}
.counter-value {
	font-size: 18px;
	margin: 0 15px;
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
	$(document).ready(function(){
    	var popupVisible = false;
	      
	    $('#counter').text(2);
	    $('#count').val('인원 2'); 
	    $('#hiddenCount').val('인원 2'); 

  		$('#count').click(function() {
    		var inputOffset = $(this).offset(); 
    		var inputWidth = $(this).outerWidth(); 
  			$('body').append('<div id="overlay"></div>');
    		if (popupVisible) {
      			$('#popup').fadeOut();
      			popupVisible = false;
    		} else {
      			$('#popup').css({
      	    	top: inputOffset.top + $(this).outerHeight(),
      	    	left: inputOffset.left, 
     	    	width: inputWidth 
			}).fadeIn(); 
      		popupVisible = true;
			}
		});

		$(document).click(function(event) {
	    	if (!$(event.target).closest('#count, #popup').length) {
	      		$('#popup').fadeOut(); 
	      		popupVisible = false; 
	    	}
	  	});

		$('#increase').click(function() {
	    	var currentValue = parseInt($('#counter').text(), 10);
	    	var newValue = currentValue + 1;
	    	$('#counter').text(newValue);
	    	$('#count').val('인원 ' + newValue); 
	    	$('#hiddenCount').val('인원 ' + newValue); 
	  	});

		$('#decrease').click(function() {
	    	var currentValue = parseInt($('#counter').text(), 10);
	    	if (currentValue > 1) { 
	      	var newValue = currentValue - 1;
	      	$('#counter').text(newValue);
	      	$('#count').val('인원 ' + newValue); 
	      	$('#hiddenCount').val('인원 ' + newValue); 
			}
	  	});
	});

	$(document).on('click', '#overlay', function(event) {
        if (event.target !== this) {
        	 return
        }
        $('#overlay').remove(); 
    });
	
	function updateHiddenInput() {
		var countValue = $('#count').val();
		var priceValue = $('#pay_amount').data('price');
		
		$('#h-count').val(countValue);
		$('#h-price').val(priceValue);
	}
</script>
</head>
<body>
	<div id="popup" class="popup">
		<div class="popup-content">
      <span class="counter-text">인원</span>
      <div>
        <button id="decrease" class="counter-btn">-</button>
        <span id="counter" class="counter-value">1</span>
        <button id="increase" class="counter-btn">+</button>
      </div>
    </div>
	</div>
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
				  <input type="text" class="form-control" id="count" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg" value="인원 2" readonly>
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
						<p class="card-text small">
							<span class="text-secondary">체크인</span>
							<span class="fst-italic" id="selectedDate">
							입실&nbsp;&nbsp;${vo.check_in_time }&nbsp;&nbsp;퇴실&nbsp;&nbsp;${vo.check_out_time }
							</span>
						</p>
					</div>
				</div>
				<div class="card" style="width: 18rem;">
					<div class="card-body">
						<p class="card-title" style="font-weight: bold;">결제 정보</p>
						<p class="card-subtitle mb-2 text-muted fs-6" style="display: inline">객실 가격&nbsp;&nbsp;</p>
							<span><fmt:formatNumber value="${vo.hrvo.peakseason_minfee1}" pattern="#,###" /> 원</span>
						<hr class="text-muted">
						<p class="card-subtitle mb-2 text-muted fs-6" style="display: inline">총 결제 금액&nbsp;&nbsp;</p>
							<span><fmt:formatNumber value="${vo.hrvo.peakseason_minfee1}" pattern="#,###" /> 원</span>
						<hr class="text-muted">
						<form method="post" action="" onsubmit="updateHiddenInput()">
							<input type="hidden" id="h-count" name="people_count">
							<input type="hidden" id="h-date" name="reserve_date">
							<input type="hidden" id="h-price" name="pay_amount">
							<button type="submit" class="btn btn-primary btn-lg"><fmt:formatNumber value="${vo.hrvo.peakseason_minfee1}" pattern="#,###" /> 원 결제하기</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
/*
	function getRandomDate() {
	    const startDate = new Date(); 
	    const endDate = new Date(startDate); 
	    endDate.setDate(startDate.getDate() + 30); 
	
	    const randomDate = new Date(startDate.getTime() + Math.random() * (endDate.getTime() - startDate.getTime()));
	    
	    return randomDate.toISOString().split('T')[0];
	}
	const fixedRandomDate = getRandomDate();
*/
	const datepickr = $('#dateInput').flatpickr({
		locale: 'ko',
		mode: 'range',
		showMonths: 2,
		minDate: 'today',
		//disable: [fixedRandomDate],
		dateFormat: 'm.d (D)',
		defaultDate: [new Date(), new Date()],
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
	        if (selectedDates.length === 2) {
	            const startDate = selectedDates[0];
	            const endDate = selectedDates[1];
	
	            const startFormatted = formatDate(startDate);
	            const endFormatted = formatDate(endDate);
	
	            $('#selectedDate').text(startFormatted + ' ~ ' + endFormatted);
	            
	            const oracleDate = formatToOracleDate(startDate);
	            $('#h-date').val(oracleDate); // input hidden
	            console.log(oracleDate);
	        }
	    }
	});

	function formatDate(date) {
		const dayNames = ['일', '월', '화', '수', '목', '금', '토'];
	    const year = date.getFullYear();
	    const month = String(date.getMonth() + 1).padStart(2, '0');
	    const day = String(date.getDate()).padStart(2, '0');
	    const dayOfWeek = dayNames[date.getDay()];
	
	    return year + '.' + month + '.' + day + ' (' + dayOfWeek + ')';
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
	
	function formatToOracleDate(date) {
	    const year = date.getFullYear();
	    const month = (date.getMonth() + 1).toString().padStart(2, '0');
	    const day = date.getDate().toString().padStart(2, '0');
	    const hours = date.getHours().toString().padStart(2, '0');
	    const minutes = date.getMinutes().toString().padStart(2, '0');
	    const seconds = date.getSeconds().toString().padStart(2, '0');
	    
	    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	}
</script>
</body>
</html>