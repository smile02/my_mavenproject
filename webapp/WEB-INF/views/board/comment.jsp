<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	function send(f){
		//유효성검사 필요
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
		
		f.action = "${pageContext.request.contextPath}/board/comment";
		
		f.submit();
		
		
		
	}
</script>
</head>
<body>
	<div class="container">
		<div class="header">
			<h1 class="title text_center">자유게시판</h1>
		</div>
		
		<div class="body">
			<table class="board-view">
				<tr>
					<th width="30%">제목</th>
					<td>${board.title }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${board.name }</td>
				</tr>
				<tr>
					<td></td>				
					<td class="content">${board.content }</td>
				</tr>
			</table>
			<hr />
			<form method="post">
				<input type="hidden" name="id" value="${board.id}" />
				<table class="board-view">
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" />
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" name="name" />
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<textarea name="content"></textarea>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<button type="button"
								onclick="send(this.form);">전송</button>
						</th>
					</tr>
				</table>
			</form>
			
		</div>
		
		<div class="footer">
			
		</div>
	</div>
</body>
</html>