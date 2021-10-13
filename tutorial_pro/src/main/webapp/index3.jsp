<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.hk.dtos.LoginDto"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8" />
<title></title>
<!--    	<link rel="stylesheet" type="text/css" href="style2.css"> -->
<style type="text/css">
/* 	@import url("f/style2.css"); */


#submenu >ul{list-style:none;}
#login >ul{list-style:none;}

#submenu> ul >li{margin-right:50px; font-size: 15px;}
#login> ul >li{margin-right:50px; font-size: 15px;}

#main >ul{ list-style:none;}

.box1, .box2, .box3, .box4,.box5,.box6{
	background-color: white;
	display: inline-block;
}

#main, #footer{
  	background-color: silver;  
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
	background-color: #DAE3F3;
	text-align: center;
}

#main{
	margin-left:10px;
	float: left;
	width: 72%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
}


#footer {
	color:#523D02;
	text-align: center;
	line-height: 50px;
	clear: both;
	
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
	background-color: red;
}
/*테이블 디자인 추가 */


</style>

</head>
<%
	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
// 	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("index2.jsp");
// 		response.sendRedirect("index.jsp");
	}
%>
<body>
<%-- <jsp:forward page="TuController.do"> --%>
<%-- <jsp:param name="command" value="main2" /> --%>
<%-- </jsp:forward> --%>

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
			<h1>흠</h1>
			<c:forEach items="${list}" var="dto">
			<div class="box1">
				<table border="1">
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
							<a href="TuController.do?command=detailboard&seq=${dto.tseq}"><button type="button">글이동</button></a>
						</td>
					</tr>
				</table>
			</div>
			</c:forEach>
		</div>
	</div>
	<div id="login">
			<ul>
				<li><%=ldto.getName() %>님 반갑습니다.</li>
				<li>(등급:<%=ldto.getRole().equals("TUTOR")?"튜터":"튜티"%>)</li>
				<li><a href="LoginController.do?command=logout">로그아웃</a></li>

			<li><a href="userinfo.jsp?id=<%=ldto.getId()%>">마이페이지</a></li>
			</ul>
	</div>
</div>

<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
</body>
</html>