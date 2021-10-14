<%@page import="com.hk.daos.LoginDao2"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.daos.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의정보</title>
<script type="text/javascript">
	function updateForm(id){
		location.href="updateform.jsp?id="+id;
	}
	
	function deleteUser(id){
		location.href="after_deleteUser.jsp?id="+id;
	}
</script>
<style type="text/css">

#submenu >ul{list-style:none;}
#login >ul{list-style:none;}

#submenu> ul >li{margin-right:50px; font-size: 15px;}
#login> ul >li{margin-right:50px; font-size: 15px;}

#main >ul{ list-style:none;}

.box1, .box2, .box3, .box4,.box5,.box6{
	background-color: white;
	display: inline-block;
}



#wrap{
	width: 100%;
	max-width: 1500px; margin: 0 auto;
}

#submenu, #main, #login{
	margin: 10px auto;
}

#submenu {
	float: left;
	width: 14%;
	height:500px;
	background-color:#0074BB;
	text-align: center;
	
}

#main{
	margin-left:10px;
	float: left;
	width: 72%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	background-color: #F2F2F2;
}

#footer {
	color:#523D02;
	text-align: center;
	line-height: 50px;
	clear: both;
	background-color: #F2F2F2;
	
}

#header{
	text-align: center;
}
#login{
	margin-left:10px;
	float: left;
	width: 12%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	background-color: #F186B6;
	
	}
h1{
font-family: 'Gaegu', cursive;
}

table{width: 50px;}

#test{display: inline-block;}
</style>
</head>
<%
	String id=request.getParameter("id");
	LoginDao2 dao = LoginDao2.getLoginDao();
	LoginDto dto=dao.getUser(id);
%>
<body>
<div id="wrap">
	<div id="header">
			<a href="TuController.do?command=main2">
			<img width="200px" height="200px" src="img/logo.png" alt="logo"/>
			</a>
	</div>
	<div id="container">
		<div id="submenu">
				<ul>
				<li><a href="TuController.do?command=boardlist">홍보게시판</a></li>
				<li><a href="#">튜터신청게시판</a></li>
				<li><a href="#">공부게시판</a></li>
				</ul>
		</div>
		<div id="main">
			<h1>나의정보</h1>
			<div id="test">
			<table class="table table-bordered" style="width: 500px;">
				<tr>
					<th>아이디</th>
					<td><%=dto.getId()%></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><%=dto.getName()%></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><%=dto.getAddress()%></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><%=dto.getPhone()%></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=dto.getEmail()%></td>
				</tr>
				<tr>
					<th>등급</th>
					<td><%=dto.getRole().equals("TUTOR")?"튜터":"튜티"%></td>
				</tr>
				<tr>
					<td colspan="2">
						<button class="btn btn-default" onclick="updateForm('<%=dto.getId()%>')">수정</button>
						<button class="btn btn-default" onclick="deleteUser('<%=dto.getId()%>')">탈퇴</button>
					</td>
				</tr>
			</table>
			</div>
		</div>
	</div>
	<div id="login">
			<ul>
				<li><%=dto.getName()%>님</li><li>반갑습니다~</li>
				<li>등급:<%=dto.getRole().equals("TUTOR")?"튜터★":"튜티★"%></li>
				<br>
				<li><a href="userinfo.jsp?id=<%=dto.getId()%>">마이페이지</a></li>
				<li><a href="LoginController.do?command=logout">로그아웃</a></li>
			</ul>
	</div>
</div>
<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
</body>
</html>





