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
body{
	line-height: 1.2;
}
.form-group {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: 10px;
}

select, input {
    width: 100%;
    max-width: 727px;
    box-sizing: border-box; 
}
input {
	min-width: 654px;
	height: 28px;
}
select {
    margin-right: 10px; 
    min-width: 65px;
}

.editor {
    width: 100%;
    max-width: 727px; 
    box-sizing: border-box; 
    max-height: 520px;
    min-height: 400px;
}
.cke_show_borders {
	overflow-y: scroll;
}

@media (min-width: 768px) {
    .editor, select, input {
        width: 50%;
        max-width: 727px;
    }
}

@media (min-width: 1024px) {
    .editor, select, input {
        width: 25%;
        max-width: 727px;
    }
}
.submit-btn-container {
    width: 100%;
    max-width: 727px;
    margin-top: 20px;
    text-align: right;
}

.submit-btn-container button {
    width: auto;
}
/* 에디터 부분 스크롤 / height 조절 */
.ck-editor__editable {
	min-height: 400px;
    max-height: 400px; 
}
.cke_editable
{
    font-size: 13px;
    line-height: 0.3rem;
}
p { 
	margin: 0; 
}
</style>
<script type="text/javascript">
/*
 
	TO-DO
	1. 작성 페이지에서 텍스트 입력창 아래로 넘어갈 시 등록 버튼 아래로 사라짐 -> O
	2. 검색 분류 셀렉트 배경색
	3. 뒤로가기 시 조회수 증가 -> O
 */
</script>
</head>
<body>
<div class="container">
    <div class="col-12">
        <h2 style="margin: 10px 0 0 100px;">공지사항</h2>
        <hr class="text-muted">
    </div>
    <form method="post" action="../notice/notice_admin_insert_ok.do" style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <div class="form-group">
            <select name="type" style="height: 28px; padding: 2px;">
                <option value="일반">일반</option>
                <option value="행사">행사</option>
                <option value="축제">축제</option>
                <option value="숙소">숙소</option>
            </select>
            <input type="text" placeholder="제목을 입력해주세요." name="subject" id="subject" style="width: 100%; max-width: 727px;">
        </div>
        <div id="classic" style="width: 100%; max-width: 727px;">
            <!-- 에디터 부분 -->
            <textarea id="editor" name="content" style="display: none;"></textarea>
        </div>
        <div class="submit-btn-container">
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