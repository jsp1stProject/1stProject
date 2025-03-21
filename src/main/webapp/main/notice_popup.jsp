<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
					popupContent += '<h5>' + data.subject + '</h5>' //제목 h5, data p 고정
						 + '<p>' + data.content + '</p>';
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
<body>
<div class="layerPopup" id="layer_popup" style="display: none;">
    <div class="layerBox">
        <div class="title">
			<h4>공지사항</h4>
		</div>
        <div class="cont" id="popup_content">
        </div>
		<div class="d-flex justify-content-between p-3 check-df">
			<div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id="chkbox" >
				<label for="chkbox">오늘 하루동안 보지 않기</label>
			</div>
			<div id="close" >
				<a href="javascript:closePop();">닫기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>