<%@page import="com.hk.daos.LoginDao2"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.daos.LoginDao"%>
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
	String name=request.getParameter("name");
	String password=request.getParameter("pw");
	String address=request.getParameter("address");
	String phone=request.getParameter("phone");
	String email=request.getParameter("email");
	
	LoginDao2 dao = LoginDao2.getLoginDao();
	boolean isS=dao.insertUser(
						        new LoginDto(id,name,password,address,
									phone,email,null,null,null)
							 );
	
	if(isS){
		%>
		<script type="text/javascript">
			alert("회원가입을 축하드려요~~");
			location.href="index.jsp";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("회원가입실패~~");
			location.href="registform.jsp";
		</script>
		<%
	}
%>
</body>
</html>







