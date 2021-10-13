<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인화면</title>
<style type="text/css">
	.table, .tr, .td {border: 1px solid black;}
	.table{display: table; position: relative;}
	.tr{display: table-row;}
	.td{display: table-cell; padding: 5px;}
	#container{width: 400px; margin: 200px auto;  }
	.colspan{width:95%;position: absolute;}
</style>
<script type="text/javascript">
	//회원가입 폼으로 이동하기
	function registForm(){
		location.href="registform.jsp";
// 		alert("아직 개발중입니다.");
	}
</script>
</head>
<body>
<div id="container">
	<h1>회원 로그인</h1>
	<form action="LoginController.do" method="post">
		<input type="hidden" name="command" value="login"/>
		<div class="table">
			<div class="tr">
				<div class="td">아이디</div>
				<div class="td"><input type="text" name="id" value="hk"/></div>
			</div>
			<div class="tr">
				<div class="td">비밀번호</div>
				<div class="td"><input type="password" name="pw" value="hk" /></div>
			</div>
			<div class="tr">
				<div class="td colspan">
					<input type="submit" value="로그인"/>
					<input type="button" value="회원가입" onclick="registForm()"/>
				</div>
			</div>
		</div>
	</form>
</div>
</body>
</html>







