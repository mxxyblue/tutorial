<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
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
	LoginDao2 dao=LoginDao2.getLoginDao();
	boolean isS=dao.deleteUser(id);
	if(isS){
		%>
		<script type="text/javascript">
			alert("그동안 이용해 주셔서 감사합니다.");
// 			location.href="index.jsp";
			location.replace("index.jsp");
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("탈퇴실패");
			location.href="userinfo.jsp?id=<%=id%>";
		</script>
		<%
	}
%>
</body>
</html>


