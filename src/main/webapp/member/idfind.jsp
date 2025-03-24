<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/assets/plugin/rangeslider/rangeslider.umd.min.js"></script>
	<link href="${pageContext.request.contextPath }/assets/plugin/rangeslider/style.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath }/assets/plugin/scroll/slimscroll.js"></script>
 <script type="text/javascript">
  $(function(){
	  
	  $('.e_button').click(function(){
	    	let name=$('#e_name').val()
	    	if(name.trim()==="")
	    	{
	    		$('#e_name').focus()
	    		$('#result_email').html('<font color="red">이름을 입력하세요</font>')
	    		return
	    	}
	    	let email=$('#email').val()
	    	if(email.trim()==="")
	    	{
	    		$('#email').focus()
	    		$('#result_email').html('<font color="red">이메일을 입력하세요</font>')
	    		return
	    	}
	    	$.ajax({
	    		type:'post',
	    		url:'../member/idfind_ok1.do',
	    		data:{"name":name,"email":email},
	    		success:function(result){
	    			if(result==='no')
	    			{
	    				$('#result_email').html('<h4><font color="red">이름이나 이메일이 존재하지 않습니다</font></h4>')
	    				$('#e_name').val("")
	    				$('#email').val("")
	    				$('#e_name').focus()
	    			}
	    			else
	    			{
	    				$('#result_email').html('<h3><font color="blue">'+result+'</font></h3>')
	    			}
	    			
	    		},
	    		error:function(request,status,error){
	    			console.log(error)
	    		}
	    	})
	    })
	    $('.p_button').click(function(){
	    	let name=$('#p_name').val()
	    	if(name.trim()==="")
	    	{
	    		$('#p_name').focus()
	    		$('#result_phone').html('<font color="red">이름을 입력하세요</font>')
	    		return
	    	}
	    	let phone=$('#phone').val()
	    	if(phone.trim()==="")
	    	{
	    		$('#phone').focus()
	    		$('#result_phone').html('<font color="red">전화번호를 입력하세요</font>')
	    		return
	    	}
	    	if(phone.length!=11)
	    	{
	    		$('#phone').focus()
	    		$('#result_phone').html('<font color="red">올바른 전화번호를 입력하세요</font>')
	    		return
	    	}
	    	$.ajax({
	    		type:'post',
	    		url:'../member/idfind_ok2.do',
	    		data:{"name":name,"phone":phone},
	    		success:function(result){
	    			if(result==='no')
	    			{
	    				$('#result_phone').html('<h4><font color="red">이름이나 전화번호가 존재하지 않습니다</font></h4>')
	    				$('#p_name').val("")
	    				$('#phone').val("")
	    				$('#p_name').focus()
	    			}
	    			else
	    			{
	    				$('#result_phone').html('<h3><font color="blue">'+result+'</font></h3>')
	    			}
	    			
	    		},
	    		error:function(request,status,error){
	    			console.log(error)
	    		}
	    	})
	    })
  })
  </script>
  <style type="text/css">
  body{
  margin:0;
  color:#6a6f8c;
  font:600 16px/18px 'Open Sans',sans-serif;
}
.bradcumb-title{
 margin-top:10px;
 color:#000000;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
  width:100%;
  margin:auto;
  max-width:525px;
  min-height:670px;
  position:relative;
  box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
}
.login-html{
  width:100%;
  height:100%;
  position:absolute;
  padding:90px 70px 50px 70px;
  background:rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
  top:0;
  left:0;
  right:0;
  bottom:0;
  position:absolute;
  transform:rotateY(180deg);
  backface-visibility:hidden;
  transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
  display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .e_button,
.login-form .group .p_button{
  text-transform:uppercase;
}
.login-html .tab{
  font-size:22px;
  margin-right:15px;
  padding-bottom:5px;
  margin:0 15px 10px 0;
  display:inline-block;
  border-bottom:2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
  color:#fff;
  border-color:#1161ee;
}
.login-form{
  min-height:345px;
  position:relative;
  perspective:1000px;
  transform-style:preserve-3d;
}
.login-form .group{
  margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .e_button,
.login-form .group .p_button{
  width:100%;
  color:#fff;
  display:block;
}
.login-form .group .input,
.login-form .group .e_button,
.login-form .group .p_button{
  border:none;
  padding:15px 20px;
  border-radius:25px;
  background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
  text-security:circle;
  -webkit-text-security:circle;
}
.login-form .group .label{
  color:#aaa;
  font-size:12px;
}
.login-form .group .e_button,
.login-form .group .p_button{
  background:#23A0DE;
}
.login-form .group label .icon{
  width:15px;
  height:15px;
  border-radius:2px;
  position:relative;
  display:inline-block;
  background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
  content:'';
  width:10px;
  height:2px;
  background:#FFFB01;
  position:absolute;
  transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
  left:3px;
  width:5px;
  bottom:6px;
  transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
  top:6px;
  right:0;
  transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
  color:#FFFB01;
}
.login-form .group .check:checked + label .icon{
  background:#FFFB01;
}
.login-form .group .check:checked + label .icon:before{
  transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
  transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
  transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
  transform:rotate(0);
}

.hr{
  height:2px;
  margin:60px 0 50px 0;
  background:rgba(255,255,255,.2);
}

.foot-lnk{
  text-align:center;
}
  </style>
</head>
<body>
        <div class="container">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>아이디 찾기</h2>
                    </div>
                </div>
            </div>
        </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ****** -->
    <section class="archive-area section_padding_100">
        <div class="container">
            <div class="row" style="width:800px;margin:0px auto">
             <div class="login-wrap">
  <div class="login-html">
    <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">이메일로 찾기</label>
    <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">전화번호로 찾기</label>
    <div class="login-form">
      <div class="sign-in-htm">
        <div class="group">
          <label for="e_name" class="label">Username</label>
          <input id="e_name" type="text" class="input">
        </div>
        <div class="group">
          <label for="email" class="label">email</label>
          <input id="email" type="text" class="input">
        </div>
       
        <div class="group">
          <input type="submit" class="e_button" value="Sign In">
        </div>
         <div>
	      <div class="text-center">
	       <span id="result_email"></span>
	      </div>
	     </div>
        
        
       
      </div>
      <div class="sign-up-htm">
        <div class="group">
          <label for="p_name" class="label">Username</label>
          <input id="p_name" type="text" class="input">
        </div>
        <div class="group">
          <label for="phone" class="label">phone</label>
          <input id="phone" type="text" class="input">
        </div>
        
        <div class="group">
          <input type="submit" class="p_button" value="Sign In">
        </div>
        <div>
	      <div class="text-center">
	       <span id="result_phone"></span>
	      </div>
	     </div>
    </div>
  </div>
</div>
</div>
            </div>
         </div>
    </section>
</body>
</html>