<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글추가폼</title>
<style type="text/css">
	#tablebox{
		width: 600px;
		margin: 0 auto;
	}
</style>
<script type="text/javascript">
	//글목록으로 돌아가기
	function boardList(){
		location.href="TuController.do?command=tuboardlist";
	}
</script>
</head>
<body>
<div id="tablebox">
	<h1>게시글추가하기</h1>
	<form action="TuController.do" method="post">
		<input type="hidden" name="command" value="insertboard"/>
		<table class="table table-hover">
			<tr>
				<th>작성자</th>
				<td><input required="required" type="text" name="id" class="form-control"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input required="required" type="text" name="title" class="form-control"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea required="required" rows="10" cols="60" name="content" class="form-control"></textarea> </td>
			</tr>
			<tr>
				<td colspan="2">
						<input type="submit" value="글추가" class="btn btn-primary"/>
						<input type="button" value="글목록" class="btn btn-info"
																onclick="boardList()"/>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>