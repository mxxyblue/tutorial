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
<% //실행부
// 	session.removeAttribute("ldto");//선택적으로 삭제
	session.invalidate();//session의 정보 모두 삭제
	response.sendRedirect("index.jsp");
%>
</body>
</html>









