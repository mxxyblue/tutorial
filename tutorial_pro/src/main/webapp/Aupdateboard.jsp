<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기폼</title>
</head>
<body>
<div id="tablebox">
<h1>게시판 수정하기</h1>
<form action="AController.do" method="post">
	<input type="hidden" name="command" value="updateboard"/>
	<input type="hidden" name="seq" value="${requestScope.dto.aseq}"/>
	<table class="table table-hover">
		<tr>
			<th>작성자</th>
			<td>${requestScope.dto.aid}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input name="title" value="${dto.atitle}"  required="required" type="text"  class="form-control"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" required="required" rows="10" cols="60"  class="form-control">${dto.acontent}</textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정완료" class="btn btn-primary"/>
				<input type="button" value="취소" class="btn btn-primary"
				 onclick="location.href='AController.do?command=detailboard&seq=${dto.aseq}'"/>
			</td>
		</tr>
	</table>
</form>
</div>

<h1>계시판 수정하기</h1>
<form action="AController.do" method="post">
	<input type="hidden" name="command" value="updateboard"/>
	<input type="hidden" name="seq" value="${requestScope.dto.aseq}"/>
	<table class="table table-hover">
		<tr>
			<th>작성자</th>
			<td>${dto.aid}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input name="title" value="${dto.atitle}" required="required" type="text" class="form-control"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name="content" required="required" rows="10" cols="60" class="form-control">${dto.acontent}</textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
					<input type="submit" value="수정완료" class="btn btn-primary"/>
					<input type="button" value="글목록" class="btn btn-info"
															onclick="boardList()"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>






