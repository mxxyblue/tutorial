<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.daos.LoginDao2"%>
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
	String id=request.getParameter("id");
	LoginDao2 dao=LoginDao2.getLoginDao();
	LoginDto dto=dao.getUser(id);
%>
<body>
<h1>나의정보수정하기</h1>
<form action="after_updateuser.jsp" method="post">
<input type="hidden" name="id" value="<%=dto.getId()%>"/>
<table border="1">
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
		<td><input type="text" name="addr" value="<%=dto.getAddress()%>"/></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><input type="tel" name="phone" value="<%=dto.getPhone()%>"/></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="email" name="email" value="<%=dto.getEmail()%>"/></td>
	</tr>
	<tr>
		<th>등급</th>
		<td><%=dto.getRole().equals("TUTOR")?"튜터":"튜티"%></td>
	</tr>
	<tr>
		<td colspan="2">
			<button type="submit">수정완료</button>
			<button onclick="location.href='userinfo.jsp?id=<%=dto.getId()%>'">나의정보</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>