<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
.center-wrap {
    margin: 0 auto;
    width: 100%;
    max-width: 600px;
    padding: 32px 24px;
}
.form_item {
    display: flex;
    align-items: center;
    position: relative;
    box-sizing: border-box;
    max-width: 100%;
    min-height: 50px;
    padding: 0 10px 0 45px;
}
.input {
    flex: 1 1 auto;
    box-sizing: border-box;
    width: 100%;
    font-size: 16px;
    line-height: 22px;
    color: #222;
    caret-color: #222
}
.card-body {
    flex: 1 1 auto;
    padding: 0;
    width: 554px;
}
.card {
	width: 420px;
}
.form-control {
	border-radius: 0;
	height: 3rem;
	width: 420px;
	paddig: 0.375rem 2.4rem;
}
.user {
}
.joinB{
	position: relative;
	width: 420px;
	height: 40px;
	margin-top: 4rem;
}
.joinDiv {
	position: relative;
	margin: 0px auto;
}
input:focus, textarea:focus, select:focus {
    box-shadow: none !important;
    outline: none !important;
}
input {
    background-position: left 10px center; /* 이미지를 왼쪽 중앙에 배치 */
    background-repeat: no-repeat; /* 이미지 반복하지 않도록 설정 */
    background-size: 24px 24px; /* 이미지 크기 조정 */
}
input::placeholder {
    font-weight: bold;
    opacity: 1; /* 기본적으로 placeholder는 투명도가 있음 */
}
.gender-select {
	background: url(../asstes/img/sex.png) no-repeat left 10px center !important;
	background-size: 24px 24px; /* 아이콘 크기 조정 */
	padding-left: 35px; /* 텍스트와 아이콘 간격 */
	border-radius: 0 0 10px 10px;
	width: 420px;
	height: 3rem;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	
	let prevEmptyFields = []; // 포커스 전 비어 있던 ID 저장

	$('#id, #pwd, #name').focus(function() {
	    // 현재 비어 있는 input ID 저장
	    prevEmptyFields = $('#id, #pwd, #name').filter(function() {
	        return $(this).val().trim() === '';
	    }).map(function() {
	        return this.id;
	    }).get();
	});

	$('#id, #pwd, #name').blur(function() {
	    let emptyFields = $('#id, #pwd, #name').filter(function() {
	        return $(this).val().trim() === '';
	    }).map(function() {
	        return this.id;
	    }).get();

	    // 이전에 비어 있던 항목 제외
	    let newEmptyFields = emptyFields.filter(id => !prevEmptyFields.includes(id));

	    if (newEmptyFields.length > 0) {
	        console.log("새롭게 비어진 항목: " + newEmptyFields.join(", "));
	    }
	});

	
	$('#addr1, #zipcode').on('keyup click', function() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $('#addr1').val(data.address);
	            $('#zipcode').val(data.zonecode);
	        }
	    }).open();
	});
	
	// 입력 필드에 값이 있으면 label 숨기기
    $('#birthday').on('input', function() {
        var inputVal = $(this).val();
        if (inputVal) {
            $('#birthdayLabel').hide();  // 값이 있으면 label 숨김
        } else {
            $('#birthdayLabel').show();  // 값이 없으면 label 보이기
        }
    });

    // 날짜 형식으로 자동 변환
    $('#birthday').on('blur', function() {
        var inputVal = $(this).val();
        if (inputVal && !inputVal.includes("-")) {
            var formattedDate = inputVal.replace(/[^0-9]/g, '').slice(0, 8); // 숫자만 취급
            if (formattedDate.length === 8) {
                formattedDate = formattedDate.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
                $(this).val(formattedDate); // yyyy-mm-dd 형식으로 변환
            }
        }
    });
    
    $('#phone').on('input', function() {
        let phoneNumber = $(this).val().replace(/[^0-9]/g, ''); // 숫자 외 문자 제거
        
        // 11자리 이상이면 입력을 차단
        if (phoneNumber.length > 11) {
            phoneNumber = phoneNumber.slice(0, 11); // 11자리까지만 입력하도록 제한
        }

        if (phoneNumber.length <= 3) {
            $(this).val(phoneNumber); // 3자리 이하인 경우 그대로
        } else if (phoneNumber.length <= 6) {
            $(this).val(phoneNumber.replace(/(\d{3})(\d{0,4})/, '$1-$2')); // 4자리 이하일 때
        } else {
            $(this).val(phoneNumber.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3')); // 4자리 이상일 때
        }
    });
	
});
	/*
		id / pwd / name / nickname / birthday / email / addr1 / zipcode / phone
	*/
	function checkValidation() {
	}
	
	


</script>
</head>
<body>
	<div class="joinDiv">
		<div class="center-wrap">
			<form method="post" action="../member/join_ok.do" name="frm" id="frm">
			<div class="user d-flex flex-column align-items-center" style="margin-bottom: 4.3rem;">
		    	<input type="text" class="form-control form_list" id="id" placeholder="아이디" required style="border-radius: 10px 10px 0 0; background-image: url(../assets/img/id.png)">
		    	<input type="password" class="form-control form_list" id="pwd" placeholder="비밀번호" required style="background-image: url(../assets/img/password.png)">
		    	<input type="text" class="form-control form_list" id="name" placeholder="이름" required style="border-radius: 0 0 10px 10px; background-image: url(../assets/img/name.png)">
    	 	</div>
    	 	<div class="user d-flex flex-column align-items-center" style="margin-bottom: 0.5rem;">
		    	<input type="text" class="form-control form_list" id="nickname" placeholder="닉네임" required style="border-radius: 10px 10px 0 0; background-image: url(../assets/img/name.png)">
		    	<!--<input type="text" class="form-control form_list" id="sex" placeholder="성별" required style="background-image: url(../assets/img/sex.png)"> -->
		    	<!-- <input type="date" class="form-control form_list" id="birthday" placeholder="생일" required style="background-image: url(../assets/img/date.png)">-->
		    		<div style="position: relative; display: inline-block;">
				    	<label for="birthday" id="birthdayLabel" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #aaa; pointer-events: none;"></label>
				    	<input type="text" id="birthday" class="form-control" placeholder="생년월일" style="background-image: url('../assets/img/date.png'); background-repeat: no-repeat; background-position: 10px center; padding-left: 40px;">
					</div>
		    	<input type="text" class="form-control form_list" id="email" placeholder="이메일" required style="background-image: url(../assets/img/email.png)">
		    	<input type="text" class="form-control form_list" id="addr1" placeholder="주소" required style="background-image: url(../assets/img/address.png)">
		    	<input type="text" class="form-control form_list" id="zipcode" placeholder="우편번호" required style="background-image: url(../assets/img/zipcode.png)">
		    	<input type="text" class="form-control form_list" id="phone" placeholder="전화번호" required style="background-image: url(../assets/img/phone.png); border-radius: 0 0 10px 10px;">
	    		<!-- 
	    		<select class="form-select gender-select" aria-label="Default select example" style="border-radius: 0 0 10px 10px; width: 420px; height: 3rem;">
			  		<option title="../assets/img/sex.png" selected>성별</option>
			  		<option value="1">남자</option>
			  		<option value="2">여자</option>
				</select>
				 -->
	    	</div>
	    	</form>
	    	<div class="user d-flex flex-column align-items-center">
	    		<button class="btn btn-primary joinB" type="submit">회원가입</button>
	    	</div>
		</div>
	</div>
</body>
</html>