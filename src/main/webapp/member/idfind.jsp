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
	  
          $('.tab').click(function () {
              $('.tab').removeClass('active');
              $(this).addClass('active');
              $('.tab-content').removeClass('active');
              $($(this).data('target')).addClass('active');
          })
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
	    				$('#result_email').html('<font color="red">이름이나 이메일이 존재하지 않습니다</font>')
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
	    				$('#result_phone').html('<font color="red">이름이나 전화번호가 존재하지 않습니다</font>')
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
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container1 {
            width: 100%;
            max-width: 500px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #444;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: #23A0DE;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn:hover {
            background: #1a8ac7;
        }
        .result {
            margin-top: 10px;
            font-weight: bold;
            color: red;
        }
        .tabs {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
            cursor: pointer;
        }
        .tabs div {
            padding: 10px 20px;
            font-weight: bold;
            border-bottom: 3px solid transparent;
        }
        .tabs .active {
            border-bottom: 3px solid #23A0DE;
            color: #23A0DE;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
    </style>
</head>
<body>
       <div class="container1">
        <h2>아이디 찾기</h2>
        <div class="tabs">
            <div class="tab active" data-target="#email-find">이메일로 찾기</div>
            <div class="tab" data-target="#phone-find">전화번호로 찾기</div>
        </div>
        
        <div id="email-find" class="tab-content active">
            <div class="input-group">
                <label for="e_name">이름</label>
                <input type="text" id="e_name">
            </div>
            <div class="input-group">
                <label for="email">이메일</label>
                <input type="text" id="email">
            </div>
            <button class="btn e_button">아이디 찾기</button>
            <div id="result_email" class="result"></div>
        </div>
        
        <div id="phone-find" class="tab-content">
            <div class="input-group">
                <label for="p_name">이름</label>
                <input type="text" id="p_name">
            </div>
            <div class="input-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone">
            </div>
            <button class="btn p_button">아이디 찾기</button>
            <div id="result_phone" class="result"></div>
        </div>
    </div>
</body>
</html>