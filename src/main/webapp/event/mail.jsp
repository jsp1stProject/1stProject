<%--
  Created by IntelliJ IDEA.
  User: sist-105
  Date: 25. 3. 24.
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<script type="text/javascript" src="https://unpkg.com/axios/dist/axios.min.js"></script>

<form action="post" name="mail" method="post">
    <input type="email" name="mail" placeholder="example@gmail.com">
    <button type="button" onclick="mailSend();">인증번호 보내기</button>
    <input type="text" name="code" placeholder="코드를 입력해주세요." disabled>
    <input type="button" value="인증하기" onclick="verifyCode();">
</form>
<script type="text/javascript">
    async function mailSend(){
        try{
            let response=await axios({
                method:'post',
                url:'codeSending.do',
                headers:{
                    "Content-Type":"application/json"
                },
                params:{
                    "email":$("input[name=mail]").val()
                }
            })
            if(response.data.statement=="success"){
                alert("인증코드가 발송되었습니다. 코드 유효기간은 5분입니다.")
                $("input[name=code]").attr("disabled",false);

            }
            console.log(${sessionScope.code})
        }catch(e){
            console.log(e);
            throw new Error(e);
        }
    }

    async function verifyCode(){
        try{
            let response=await axios({
                method:'post',
                url:'verification.do',
                headers:{
                    "Content-Type":"application/json"
                },
                params:{
                    "code":$("input[name=code]").val()
                }
            })
            if(response.data.statement=="success"){
                // location.href="mail2.do";
                alert("인증 성공");
            }else if(response.data.statement=="fail"){
                alert("인증 실패");
            }else if(response.data.statement=="expired"){
                alert("코드가 만료되었습니다. 인증번호 보내기 버튼을 다시 눌러주세요.");
            }
            console.log(${sessionScope.code})
        }catch(e){
            console.log(e);
            throw new Error(e);
        }

    }

</script>
</body>
</html>
