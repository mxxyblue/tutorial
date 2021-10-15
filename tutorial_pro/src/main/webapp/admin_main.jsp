<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
<h1>관리자 메인</h1>
<div>
	<span><%=ldto.getName()%></span>님 반갑습니다.(아이디:<%=ldto.getId()%>)
	<a href="after_logout.jsp">로그아웃</a>
</div>
<div>
	<ul>
		<li><a href="userlist_status.jsp">회원상태정보조회</a></li>
		<li><a href="userlist.jsp">튜터/튜티 등급 변경</a></li>
		<li><a href="updateteamnum.jsp">팀번호 부여</a></li>
		<li><a href="index3.jsp">홍보게시판</a></li>
		<li><a href="#">공부게시판</a></li>
	</ul>
</div>
</body>
</html>



