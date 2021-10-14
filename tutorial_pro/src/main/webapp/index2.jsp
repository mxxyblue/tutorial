<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8" />
<title></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&display=swap" rel="stylesheet">
<!--    	<link rel="stylesheet" type="text/css" href="style2.css"> -->
<style type="text/css">
/* 	@import url("f/style2.css"); */


#submenu >ul{list-style:none;}
#login >ul{list-style:none;}

#submenu> ul >li{margin-right:50px; font-size: 15px;}
#login> ul >li{margin-right:50px; font-size: 15px;}

#main >ul{ list-style:none;}

.box1, .box2, .box3, .box4,.box5,.box6{
/* 	background-color: white; */
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
	
	
/*테이블 디자인 추가 */


</style>
<script type="text/javascript">
	$(function(){
		
		
		
	});
</script>
</head>

<body>
<%

%>
<div id="wrap">
	<div id="header">
			<a href="index.jsp">
			<img width="200px" height="200px" src="img/logo.png" alt="logo"/>
			</a>
	</div>
	
	<div id="container">
		<div id="submenu">
			<ul>
			<li><a href="loginindex.jsp">홍보게시판</a></li>
			<li><a href="loginindex.jsp">튜터신청게시판</a></li>
			<li><a href="loginindex.jsp">공부게시판</a></li>
			</ul>
		</div>
		<div id="main">
			<h1>★ 튜터 / 튜티 홍보 ★</h1>
			<c:forEach items="${list}" var="dto">
			<div class="box1">
				<table class="table table-hover">
<!-- 				<colgroup> -->
<!-- 				<col width="10%"><col width="10%"></colgroup> -->
					
					
					<tr>
						<th>작성자</th>
						<td>${dto.tid}</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${dto.ttitle}</td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="30" readonly>${dto.tcontent}</textarea> </td>
					</tr>
					<tr>
						<td colspan="2">
							<a href="TuController.do?command=detailboard&seq=${dto.tseq}"><button class="btn btn-default" type="button">글이동</button></a>
						</td>
					</tr>
				</table>
			</div>
			</c:forEach>
		</div>
	</div>
	<div id="login">
			<ul>
			<li><a href="loginindex.jsp">로그인</a></li>
			<li><a href="registform.jsp">회원가입</a></li>
			</ul>
	</div>
</div>

<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
</body>
</html>