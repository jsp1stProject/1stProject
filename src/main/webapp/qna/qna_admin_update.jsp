<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
 <script type="text/javascript">
 $(function(){
		$('#updateBtn').click(function(){
			let gi=$('#group_id').val()
			// 데이터 전송 (수정 요청)
			$.ajax({
				type:'post',
				url:'../qna/qna_qna_update_ok.do',
				data:$('#frm').serialize(),
				success:function(result)
				{
					location.href="../qna/qna_qna_list.do?no="+no
				},
				error:function(err)
				{
					alert(err)
				}
			})
		})
	})
 </script>


	<div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">QnA 답변하기</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              
                <div class="card-footer">
                  <div class="form-group row">    
                    <div class="col-6">          
                    <label for="exampleInputEmail1">이름</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.no} disabled>
                    </div>
                    <div class="col-6">
		    		<label for="exampleInputEmail1">작성일</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.dbday} disabled>
                    </div>
                  </div>
                  
                  <div class="form-group row">    
                    <div class="col-6">          
                    <label for="exampleInputEmail1">이메일</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.email} disabled>
                    </div>
                    <div class="col-6">
		    		<label for="exampleInputEmail1">핸드폰번호</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.phone} disabled>
                    </div>
                  </div>
                  
                  <div class="form-group row">
                    <label for="exampleInputPassword1">첨부파일</label>
                    <a id="exampleInputPassword1" href="download.jsp?fn=${vo.filename }">${vo.filename}</a>(${vo.filesize }Bytes)
                  </div>
                  
                  <div class="form-group row">    
                    <div class="col-4">          
                    <label for="exampleInputEmail1">타입</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.type} disabled>
                    </div>
                    <div class="col-4">
		    		<label for="exampleInputEmail1">타입상세</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.type_detail} disabled>
                    </div>
                    <div class="col-4">
		    		<label for="exampleInputEmail1">예약번호</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" value=${vo.reserve_no} disabled>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputPassword1">제목</label>
                    <input type=""text"" class="form-control" id="exampleInputPassword1" value=${vo.subject } disabled>
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputPassword1">내용</label>
                    <input type=""text"" class="form-control" id="exampleInputPassword1" value=${vo.content } disabled>
                  </div>
                  
                  
                  </div>
                  
                </div>
                <!-- /.card-body -->
				<form method="get" id="frm">
                <div class="card-body">
                 <div class="form-group">
                    <label for="exampleInputPassword1">제목</label>
                    <input type=hidden name=no value="${vo.group_id }" id="group_id">
                    <input type="text" name=subject id=subject class="form-control"placeholder="제목입력" required value="${vo.subject }">
                     <input type=hidden name=group_id value="${vo.group_id }">
                  </div>
                  
                  <div class="form-group">
                    <label for="exampleInputPassword1">내용</label>
                    <textarea class="form-control"  name=content id="exampleInputPassword1" rows="10" cols="52" placeholder="내용입력" required value="${vo.content }"></textarea>
                  </div>
                
                  <button type="button" class="btn btn-primary"  id="updateBtn">전송	</button>
                  <button type="button" class="btn btn-warning" onclick="javascript:history.back()" >취소</button>
                </div>
              </form>
            </div>
