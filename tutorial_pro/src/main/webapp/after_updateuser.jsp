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
<body>
<%
	String id=request.getParameter("id");
	String address=request.getParameter("addr");
	String phone=request.getParameter("phone");
	String email=request.getParameter("email");
	
	LoginDao2 dao=LoginDao2.getLoginDao();
	boolean isS=dao.updateUser(new LoginDto(id,address,phone, email));
	
	if(isS){
		response.sendRedirect("userinfo.jsp?id="+id);
	}else{
		%>
		<script type="text/javascript">
			alert("나의 정보 수정 실패");
			location.href="updateform.jsp?id="+id;
		</script>
		<%
	}
%>
</body>
</html>



