<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 25.
  Time: 오후 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<body>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <div class="container pt-3">
    <div class="row justify-content-center">
      <jsp:include page="mynav.jsp"></jsp:include>
      <div class="col-lg-9 col-12">
        <h3 class="pt-3 pt-lg-0 pb-3">내 정보</h3>
        <div class="myinfo">
          <form action="" method="post" name="infoUpload">
            <input type="file" id="profile" name="profile" accept="image/*" onchange="setThumbnail(event);"/>
            <div id="profilewrap" onclick="profileupload();">
              <div></div>
            </div>
            <input type="hidden" id="user_id" name="user_id" value="${vo.user_id}">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" placeholder="이름" value="${vo.name}" required>
            <label for="nickname">별명</label>
            <input type="text" id="nickname" name="nickname" placeholder="별명" value="${vo.nickname}" required>
            <label for="pwd_before">기존 비밀번호</label>
            <input type="password" id="pwd_before" name="pwd_before" placeholder="기존 비밀번호" required>
            <label for="pwd_after">새 비밀번호</label>
            <input type="password" id="pwd_after" name="pwd_after" placeholder="새 비밀번호">
            <label for="pwd_after">새 비밀번호 확인</label>
            <input type="password" id="pwd_after2" name="pwd_after2" placeholder="새 비밀번호 확인">
            <label for="birth">생일</label>
            <input type="text" id="birth" name="birth" placeholder="생일" value="${vo.birthday}" required>
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="example@festeller.com" value="${vo.email}" required>
            <button type="button" class="email-sendbtn btn-white inFormbtn">인증번호 받기</button>
            <div class="email-vf"><!--session으로 상태 확인-->
              <input type="text" id="verifyCode" name="verifyCode" placeholder="인증번호 입력">
              <button type="button" class="email-vfbtn btn-black inFormbtn">인증하기</button>
            </div>
            <label for="addr1">주소</label>
            <input type="text" id="addr1" name="addr1" placeholder="서울 마포구 독막로3길 13" value="${vo.addr1}" required>
            <label for="addr2">상세주소</label>
            <input type="text" id="addr2" name="addr2" placeholder="" value="${vo.addr2}">
            <label for="post">우편번호</label>
            <input type="text" id="post" name="post" placeholder="12345" value="${vo.post}" required>
            <label for="phone">전화번호</label>
            <input type="text" id="phone" name="phone" placeholder="010-0000-0000" value="${vo.phone}" required>
            <button type="submit" class="btn btn-black" id="submit">수정</button>
          </form>
        </div>
      </div>
    </div>
  </div>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<script type="text/javascript">
  //정보 수정 ajax
  //1.form 유효성 체크
  const form=$("form[name=infoUpload]")[0];
  $(form).on("submit",function(e){
    e.preventDefault();
    if(!form.checkValidity()){
      form.reportValidity();
      return;
    }
    update();
  });
  //2.비밀번호 확인,업데이트
  async function update(){
    try{
      let formData=new FormData($("form[name=infoUpload]")[0]);
      for (const x of formData) {
        console.log(x);
      };
      let response=await axios({
        method:'post',
        url:'myinfo_update.do',
        headers:{
          "Content-Type":"application/json"
        },
        data:formData
      })
      console.log(response);
      if(response.data.statement=="success"){
        location.reload();
      }else if(response.data.statement=="expired"){
        if(confirm("로그인 상태가 아닙니다.")) document.location = '../main/main.do';
      }else if(response.data.statement=="not_verified"){
        toast("이메일을 인증해주세요.")
      }else if(response.data.statement=="failed"){
        toast("기존 비밀번호가 일치하지 않습니다.")
      }else{
        toast(response.data.statement);
      }
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }

  //메일 인증
  //1.코드 보내기
  async function mailSend(){
    try{
      let response=await axios({
        method:'post',
        url:'../mail/codeSending.do',
        headers:{
          "Content-Type":"application/json"
        },
        params:{
          "email":$("input[name=email]").val()
        }
      })
      if(response.data.statement=="success"){
        toast("인증코드가 발송되었습니다. 코드 유효기간은 5분입니다.")
        $(".email-vf").addClass("active"); //코드 입력창 보이기
        $("input[name=verifyCode], button.email-vfbtn").prop("disabled", false);
        $(".email-vfbtn").text("인증하기");
      }
      console.log(${sessionScope.code});
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }
  //2.코드인증
  async function verifyCode(){
    try{
      let response=await axios({
        method:'post',
        url:'../mail/verification.do',
        headers:{
          "Content-Type":"application/json"
        },
        params:{
          "code":$("input[name=verifyCode]").val(),
          "email":$("input[name=email]").val()
        }
      })
      if(response.data.statement=="success"){
        toast("인증 성공!");
        $("input[name=verifyCode], button.email-vfbtn").prop("disabled", true);
        $(".email-vfbtn").text("인증성공!");
      }else if(response.data.statement=="fail"){
        toast("코드가 일치하지 않습니다.");
      }else if(response.data.statement=="expired"){
        alert("코드가 만료되었습니다. 인증번호 보내기 버튼을 다시 눌러주세요.");
      }
    }catch(e){
      console.log(e);
      throw new Error(e);
    }
  }
  //3.event 추가
  $(".email-sendbtn").on("click",function(){
    mailSend();
  });
  $(".email-vfbtn").on("click",function(){
    verifyCode();
  });

  //toast 메시지
  function toast(msg) {
    Toastify({
      text: msg,
      duration: 3000,
      newWindow: true,
      close: true,
      gravity: "bottom", // `top` or `bottom`
      position: "right", // `left`, `center` or `right`
      stopOnFocus: true, // Prevents dismissing of toast on hover
      style: {
        background: "linear-gradient(to right, #00b09b, #96c93d)",
      },
      onClick: function () {
      } // Callback after click
    }).showToast();
  }

  //비밀번호 변경
  //새 비밀번호 입력
  $("#pwd_after").blur(function(){
    if($(this).val().length<5){
      toast("비밀번호는 6글자 이상이어야 합니다.");
      $(this).val("");
    }
    if($("#pwd_before").val()==$(this).val()){
      toast("새 비밀번호는 기존 비밀번호와 달라야합니다.");
      $(this).val("");
    }
  });
  //비밀번호 확인
  $("#pwd_after2").blur(function(){
    if($("#pwd_after").val()!=$(this).val()){
      toast("새 비밀번호 확인이 일치하지 않습니다.");
      $(this).val("");
    }
  });

  //프로필사진 썸네일
  function setThumbnail(event) {
    var reader = new FileReader();
    reader.onload = function(event) {
      document.getElementById("profilewrap").innerHTML ="";
      var img = document.createElement("div");
      img.setAttribute("style", "background-image:url("+event.target.result+")");
      img.setAttribute("ID", "profileimg");
      document.querySelector("div#profilewrap").appendChild(img);
    };
    reader.readAsDataURL(event.target.files[0]);
  }
  function profileupload(){
    var ele=document.getElementById('profile');
    ele.click();
    console.log('test');
  }

  //주소찾기
  $(document).on("click keyup","#addr1, #post", function(){
    new daum.Postcode({
      oncomplete: function(data) {
        $('#addr1').val(data.address);
        $('#zipcode').val(data.zonecode);
      }
    }).open();
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

  // 생일
  $('#birth').on('input', function() {
    let birthday = $(this).val().replace(/[^0-9]/g, ''); // 숫자 외 문자 제거
    // 8자리 이상이면 입력을 차단
    if (birthday.length > 8) {
      birthday = birthday.slice(0, 8); // 8자리까지만 입력하도록 제한
    }
    if (birthday.length <= 4) {
      $(this).val(birthday); // 4자리 이하인 경우 그대로
    } else if (birthday.length <= 6) {
      $(this).val(birthday.replace(/(\d{4})(\d{0,2})/, '$1-$2')); // 6자리까지 - 추가
    } else {
      $(this).val(birthday.replace(/(\d{4})(\d{2})(\d{0,2})/, '$1-$2-$3')); // 8자리까지 - 추가
    }
  });

  // 날짜 형식으로 자동 변환
  $('#birth').on('blur', function() {
    var inputVal = $(this).val();
    if (inputVal && !inputVal.includes("-")) {
      var formattedDate = inputVal.replace(/[^0-9]/g, '').slice(0, 8); // 숫자만 취급
      if (formattedDate.length === 8) {
        formattedDate = formattedDate.replace(/^(\d{4})(\d{2})(\d{2})$/, "$1-$2-$3");
        $(this).val(formattedDate); // yyyy-mm-dd 형식으로 변환
      }
    }
  });
</script>
</body>
</html>
