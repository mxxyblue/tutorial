<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.daos.LoginDao2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등급변경하기</title>
</head>
<%

	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
	//	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("index.jsp");
	//		response.sendRedirect("index.jsp");
	}
	
	//등급을 변경할 회원의 id값을 받는다
	String id=request.getParameter("id");

	LoginDao2 dao=LoginDao2.getLoginDao();
	LoginDto dto=dao.getUser(id);
%>
<body>
<h1>회원등급변경하기</h1>
<form action="after_update_role.jsp" method="post">
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
			<th>이메일</th>
			<td><%=dto.getEmail()%></td>
		</tr>
		<tr>
			<th>등급</th>
			<td>
				<select name="role">
					<option value="ADMIN" <%=dto.getRole().toUpperCase().equals("ADMIN")?"selected":"" %>>관리자</option>
					<option value="TUTOR" <%=dto.getRole().toUpperCase().equals("TUTOR")?"selected":"" %>>튜터</option>
					<option value="TUTEE" <%=dto.getRole().toUpperCase().equals("TUTEE")?"selected":"" %>>튜티</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="변경완료">
				<input type="button" value="목록" onclick="location.href='userlist.jsp'"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>





