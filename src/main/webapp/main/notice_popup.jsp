<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
font-family: SF Pro KR, SF Pro Display, SF Pro Icons, AOS Icons, Apple Gothic, HY Gulim, MalgunGothic, HY Dotum, Lexi Gulim, Helvetica Neue, Helvetica, Arial, sans-serif;
.layerPopup img{
margin-bottom : 20px;}
.layerPopup:before {display:block; content:""; position:fixed; left:0; top:0; width:100%; height:100%; background:rgba(0,0,0,.5); z-index:9000}
.layerPopup .layerBox {    z-index:10000;   
position:fixed; left:85%; top:48%; transform:translate(-50%, -50%); padding:30px; background:#fff; border-radius:6px; }
.layerPopup .layerBox .title {margin-bottom:10px; padding-bottom:10px; font-weight:600; border-bottom:1px solid #d9d9d9;}
.layerPopup .layerBox .btnTodayHide {
font-size:14px; font-weight:600; color:black; 
float: left;text-decoration:none;width: 150px; 
height : 30px;line-height:30px;border:black solid 1px; text-align : center;text-decoration:none;
}
.layerPopup div{
	display : inline;
}
.layerPopup form{
	margin-top : 5px;
	font-size:16px; font-weight:600;
	weight: 100%;
	height : 30px;
	line-height:30px
}
.layerPopup #close {
font-size:16px; font-weight:600; width: 40px; height : 30px;color:black; float: right; line-height:30px; text-align : center;text-decoration:underline;
}
.layerPopup a{
	text-decoration : none;
	color : black;width: 50px;height : 40px;
}
</style>
<script type="text/javascript">
/*
// 팝업 닫기 버튼 클릭 이벤트
$("#closeBtn").click(function() {
    if ($("#chkbox").prop("checked")) {
        setCookie("maindiv", "done", 1); // "오늘 하루 안보기" 체크 시 쿠키 설정
    }
    $("#layer_popup").hide();
});
*/

/*
 	home.jsp 에서 ajax 를 통해 model 로 데이터 주고 받기
 	비동기 데이터 출력
 */

	$(function() {
		$("#layer_popup").hide();
		// 쿠키 확인 후 팝업 표시/숨김 처리
	    if (document.cookie.indexOf("maindiv=done") < 0) {
	        $("#layer_popup").show();
	    } else {
	        $("#layer_popup").hide();
	    }	
		
		let popupContent = '';
		$.ajax({
			type: 'get',
			url: '../main/notice_popup.do',
			dataType: 'json',
			success: function(data) {
				if (data) {
					popupContent += '<div class="notice-item">'
						 + '<h3>' + data.subject + '</h3>'
						 + '<p>' + data.content + '</p>'
						 + '</div>';
		 			$('#popup_content').html(popupContent);	
				} else {
					console.log('데이터 비어있음');
				}
				
			},
			error: function(xhr, status, error) {
				console.log('데이터 출력 실패: ' + error);
			}
		});
	});

    // 쿠키 설정 함수
    function setCookie(name, value, days) {
        let expires = new Date();
        expires.setDate(expires.getDate() + days);
        document.cookie = name + "=" + encodeURIComponent(value) + "; path=/; expires=" + expires.toUTCString() + ";";
    }

	function closePop() {
		if ($('#chkbox').prop('checked')) {
			setCookie('maindiv', 'done', 1);
		}
		$('#layer_popup').hide();
	}
</script>
</head>
<body>
<div class="layerPopup" id="layer_popup" style="display: none;">
    <div class="layerBox">
        <h4 class="title">공지사항</h4>
        <div class="cont" id="popup_content">
            <p>
				<img src="../assets/img/hotel1.jpg" width=350 height=500 usemap="#popup" alt="event page">
            </p>
        </div>
        <form name="pop_form">
        	<div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
        		<label for="chkbox">&nbsp;&nbsp;오늘 하루동안 보지 않기</label>
       		</div>
			<div id="close" >
				<a href="javascript:closePop();">닫기</a>
			</div>    
		</form>
	</div>
</div>
</body>
</html>