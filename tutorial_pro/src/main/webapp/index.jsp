<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title></title>
</head>
<body>
<jsp:forward page="TuController.do">
<jsp:param name="command" value="main" />
</jsp:forward>
</body>
</html>