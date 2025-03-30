<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 27.
  Time: 오후 3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<body>
<script type="text/javascript">
    $(document).on("click","#loginBtn",function(event){
        event.preventDefault(); // a 태그의 기본 동작 방지
        $(".login_wrap").fadeIn();//팝업 열기
    });
    $(function(){
        $('#canBtn').click(function(){
            $(".login_wrap").fadeOut();//팝업 닫기
        })
        $('#logBtn').click(function(){
            //유효성 검사
            let user_id=$('#user_id').val()
            if(user_id.trim()===""){
                $('#user_id').focus()
                return
            }
            let pwd=$('#pwd').val()
            if(pwd.trim()===""){
                $('#pwd').focus()
                return
            }

            //로그인 ajax
            $.ajax({
                type:'post',
                url:'../member/login_ok.do',
                data:{"user_id":user_id,"pwd":pwd},
                success:function(result){
                    //alert(result)
                    // NOID , NOPWD , OK   3중 하나 받아서옴
                    if(result==='NOID'){
                        alert("아이디가 존재하지 않습니다.")
                        $('#user_id').val("")
                        $('#pwd').val("")
                        $('#user_id').focus()
                    }

                    else if(result==='NOPWD'){
                        alert("비밀번호가 일치하지 않습니다.")
                        $('#pwd').val("")
                        $('#pwd').focus()
                    }

                    else{
                        parent.location.reload();
                        parent.Shadowbox.close()
                        alert('로그인 되었습니다.')
                        //새고
                    }


                }
            })
        });

    });
    function join () {
        parent.location.href = '../member/join.do';
    }
</script>
<div class="login_wrap" style="display:none;">
    <form action="" method="post" name="loginform">
        <div class="login_inner">
            <button class="canbtn" id="canBtn" type="button"></button>
            <div class="logo">festeller 로그인</div>
            <div class="input_wrap">
                <input type="text" name="user_id" id="user_id" placeholder="아이디">
            </div>
            <div class="input_wrap">
                <input type="password" name="pwd" id="pwd" placeholder="비밀번호">
            </div>
            <button class="btn-black" type="button" id="logBtn">로그인</button>
            <button class="btn-white" type="button" onclick="join()">회원가입</button>
            <div class="find_wrap">
                <a href="../member/idfind.do">아이디 찾기</a>
                <a href="#">비밀번호 찾기</a>
            </div>
        </div>

    </form>
</div>
</body>
</html>
