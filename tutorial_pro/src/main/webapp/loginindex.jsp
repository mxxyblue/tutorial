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
 	.table{
 	text-align: center;
 	}

	#container{
	width: 400px; 
	margin: 0 auto;
	text-align: center;
	}
	
	.td{padding: 5px;}

	#header{
	text-align: center;
	}
	
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
<div id="header">
			<a href="index.jsp">
			<img width="200px" height="200px" src="img/logo.png" alt="logo"/>
			</a>
	</div>
	<div id="container">
	<h1>회원 로그인</h1>
	<form action="LoginController.do" method="post">
		<input type="hidden" name="command" value="login"/>

		<div class="table">
			<div class="tr">
				<div class="td"><input type="text" name="id" value="hk" placeholder="아이디"/></div>
			</div>
			<div class="tr">
				<div class="td"><input type="password" name="pw" value="hk" placeholder="비밀번호"/></div>
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







