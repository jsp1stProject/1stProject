<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<script src="https://cdn.ckeditor.com/ckeditor5/38.1.1/classic/ckeditor.js"></script>
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.ck.ck-editor {
   	max-width: 900px;
}
.ck-editor__editable {
    min-height: 550px;
    width: 900px;
}
</style>
</head>
<body>
<div class="container">
    <div class="d-flex justify-content-start">
        <h2 style="margin: 10px 0 0 100px;">공지사항</h2>
    </div>
    <form method="post" action="../notice/notice_admin_insert_ok.do" style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100vh;">
        <!-- 셀렉트와 인풋을 같은 줄로 배치 -->
        <div class="d-flex" style="align-items: center; margin-bottom: 10px;">
            <select name="type" style="height: 28px; width: 74px; padding: 2px; margin-right: 10px;">
                <option value="일반">일반</option>
                <option value="행사">행사</option>
                <option value="축제">축제</option>
                <option value="숙소">숙소</option>
            </select>
            <input type="text" placeholder="제목을 입력해주세요." name="subject" id="subject" style="width: 814px;">
        </div>
        <div class="d-flex justify-content-center align-items-center" id="classic" style="width: 100%; max-width: 600px;">
            <!-- 에디터 부분 -->
            <textarea id="editor" name="content" style="display: none"></textarea>
        </div>
        <!-- 등록 버튼을 에디터와 동일한 열에 맞춰서 오른쪽 정렬 -->
        <div class="d-flex justify-content-end" style="width: 100%; max-width: 600px; margin-top: 20px;">
    		<button class="btn btn-primary" id="trans" type="submit" style="margin-right: 0;">등록</button>
		</div>
    </form>
</div>
<script>
        ClassicEditor
            .create( document.querySelector( '#editor' ) )
            .catch( error => {
                console.error( error );
            } );
</script>
</body>
</html>