<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.hk.dtos.LoginDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	
	#replyForm{
		display: none;
	}
	#tablebox{
		overflow: auto;
		height: 500px;
	}
</style>
</head>
<%
	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
// 	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("index.jsp");
// 		response.sendRedirect("index.jsp");
	}
%>
<body>
<div id="tablebox">
<h1>게시글 상세보기</h1>
<table class="table table-hover">
	<tr>
		<th>작성자</th>
		<td>${dto.aid}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${dto.atitle}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" class="form-control" readonly>${dto.acontent}</textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="button" class="btn btn-primary" onclick="updateForm(${dto.aseq})">수정</button>
			<button type="button" class="btn btn-danger" onclick="delBoard(${dto.aseq})">삭제</button>
			<button type="button" class="btn btn-warning" onclick="replyForm()">답글</button>
			<button type="button" class="btn btn-info" onclick="boardList()">목록</button>
		</td>
	</tr>
</table>
<hr/>
	<div id="replyForm">
	<h1>답글 추가하기</h1>
	<form action="AController.do" method="post">
		<input type="hidden" name="command" value="replyboard"/>
		<input type="hidden" name="seq" value="${dto.aseq}"/>
		<table class="table table-hover">
			<tr>
				<th>작성자</th>
				<td><input required="required" type="text" name="id" class="form-control" value="<%=ldto.getId()%>" readonly/></td>
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
				<td colspan="2"><input type="submit" value="답글추가" class="btn btn-primary"/></td>
			</tr>
		</table>
	</form>
	</div>
</div>

<script type="text/javascript">
	//글 수정하기
	function updateForm(seq){
		location.href="AController.do?command=updateform&seq="+seq;
	}

	//글삭제 기능
	function delBoard(seq){
		location.href="AController.do?command=muldel&chk="+seq;
	}
	
	//답글 폼의 위치를 스크롤 이동을 통해 보여주는 기능
	function replyForm(){
		$("#replyForm").show();
		var replyPosition=$("#replyForm").offset().top;//div의 상단위치를 구함
		$("#tablebox").animate({
			"scrollTop":replyPosition
		},1000);
	}
	
	//글목록으로 돌아가기
	function boardList(){
		location.href="AController.do?command=boardlist";
	}
</script>
</body>
</html>









