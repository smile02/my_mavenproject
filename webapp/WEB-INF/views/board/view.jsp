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
	function del(id){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/board/delete",
				type:"post",
				data:{id:id},
				success : function(data){
					if(data=='y'){
						alert("삭제가 완료되었습니다. 메인페이지로 이동하겠습니다.");
						location.href="${pageContext.request.contextPath}/board/list";	
					}else{
						alert("잠시후에 다시 시도해주세요.");
					}
				}
			});
		}
	}
	
	function modify(id){
		if(confirm("수정 페이지로 이동하시겠습니까?")){
			location.href="${pageContext.request.contextPath}/board/update?id="+id;
		}
	}
	
	function send(f){
		if(/^.{2,10}$/.test(f.name.value) == false){
			alert("이름은 2글자 이상 10글자 이하로 입력해주세요.");
			f.name.focus();
			return;
		}
		
		if(/^.{1,100}$/.test(f.content.value) == false){
			alert("내용은 1글자 이상 100글자 이하로 입력해주세요.");
			f.contents.focus();
			return;
		}
		
		f.action = "${pageContext.request.contextPath}/reply/insert";
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
			<div class="buttons">
				<button type="button" onclick="
				location.href='${pageContext.request.contextPath}/board/list?page=${param.page }'">목록</button>
				<button type="button"
					onclick="del(${board.id});">삭제</button>
				<button type="button"
					onclick="location.href=
					'${pageContext.request.contextPath}/board/comment?id=${board.id}'">답글</button>
				<button type="button"
 					onclick="modify(${board.id})">수정</button>
			</div>
		</div>
		
		<div class="footer">
			<div class="reply">
			<form method="post">
				<input type="hidden" name="b_id" value="${board.id }" />
				<table class="board-view">
					<tr>
						<th width="30%">이름</th>
						<td><input type="text" name="name" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<input type="text" name="content"/>
						</td>
					</tr>
					<tr>
						<th>
							<button type="button" onclick="send(this.form);" >댓글등록</button>
						</th>
					</tr>
				</table>
			</form>
				<table class="board-view">					
					<c:if test="${empty board.replyList }">
					<tr>
						<th colspan="2" style="text-align: center">
							댓글이 존재하지 않습니다.
						</th>
					</tr>
					</c:if>
											
					<c:forEach var="reply" items="${board.replyList}">
						<tr>
							<th width="30%"> ${reply.name }</th>
							<td>${reply.content }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>