<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> <!-- 부트스트랩 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet"> <!-- 썸머노트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	function check(f){
		//유효성검사 (제목, 이름, 내용)
		var title = /^.{1,30}$/; 
		if(!title.test(f.title.value)){
			alert("제목은 1글자 이상 30글자이하");
			f.title.focus();
			return;
		}
		
		var name = /^.{2,10}$/;
		if(!name.test(f.name.value)){
			alert("이름은 2글자 이상 10글자 이하");
			f.name.focus();
			return;
		}
		
		var content = /^.{1,2000}$/;
		if(!content.test(f.content.value)){
			alert("내용은 1글자 이상 2000글자 이하 입력바랍니다.");
			f.content.focus();
			return;
		}
		
		f.submit();
		
	}
</script>
</head>
<body>
	<div class="container">
		<div class="header">
			<h1 class="title text_center">글수정</h1>
		</div>
		
		<div class="body">
		<form action="${pageContext.request.contextPath }/board/update" method="post">
			<input type="hidden" name="id" value="${board.id }" />
			<table class="board-view">
				<tr>
					<th width="30%">제목</th>
					<td>
						<input type="text" name="title" value="${board.title } " />
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name= name value = "${board.name }"/>
					</td>
				</tr>
				<tr>
					<td></td>				
					<td>
						<textarea id="content" class="content" name="content">${board.content }</textarea>											
					</td>
				</tr>
			</table>			
			<div class="buttons">
				<button type="button" onclick="
					location.href='${pageContext.request.contextPath}/board/list'">목록</button>
				<button type="button" onclick="check(this.form);">수정</button>
			</div>
			</form>
		</div>
		
		<div class="footer">
		</div>
	</div>
	<!-- BootStrap -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- SummerNote -->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/lang/summernote-ko-KR.min.js"></script>
	<!-- 이게 있어야 한글 사용 가능 -->
	<script>
		$("#content").summernote({
			height: 300,
			focus: true, //계속 텍스트에어리어를 가리킴
			lang: 'ko-KR',
			callbacks:{
				onImageUpload: function(files, editor, welEditable){
//					console.log('image upload', files);
					sendFile(files[0], editor, welEditable);
				}
			}
		});
		
		function sendFile(file, editor, welEditable){
			var data = new FormData();
			data.append('upload', file);
			$.ajax({
				url:"${pageContext.request.contextPath}/board/fileupload",
				contentType: false,
				processData: false,
				data: data,
				type:"post",
				success: function(data){
					//console.log(data);
					var $img = $('<img>').attr('src', data.url);
					$('#content').summernote('insertNode', $img[0]);
//					editor.insertImage(welEditable, data);
				}
			});
		}
	</script>
</body>
</html>