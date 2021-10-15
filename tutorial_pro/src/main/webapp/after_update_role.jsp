<%@page import="com.hk.daos.LoginDao"%>
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
<body>
<%
	String id=request.getParameter("id");
	String role=request.getParameter("role");
	
	LoginDao2 dao=LoginDao2.getLoginDao();
	boolean isS=dao.updateRoleUser(id, role);
	
	if(isS){
		response.sendRedirect("userlist.jsp");
	}else{
		%>
		<script type="text/javascript">
			alert("등급수정실패");
			location.href="updateroleform.jsp?id="+id;
		</script>
		<%
	}
%>
</body>
</html>



