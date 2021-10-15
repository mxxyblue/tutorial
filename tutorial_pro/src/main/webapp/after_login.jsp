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
<% //자바 실행부

	//사용자가 로그인 정보를 입력하고 로그인 요청을 하면 
	//로그인 정보받기 작업을 수행한다.
	String id=request.getParameter("id");
	String pw=request.getParameter("pw");
	
	//싱글턴 패턴이라 객체 생성시 "클래스명.메서드명()"으로 작성
	LoginDao2 dao=LoginDao2.getLoginDao();
	LoginDto dto=dao.getLogin(id, pw);
	
	//회원인지 판단하기
	if(dto.getId()!=null){//dto에서 id값만 있는지 여부 판단하면 됨
		//회원인 경우에 실행할 코드 작성
		//개인 장바구니: session객체-> 모든 페이지에서 공유 가능한다.(개인만)
		session.setAttribute("ldto",dto);//로그인정보 저장
		//10분동안 요청이 없으면 session의 정보를 삭제한다.
		session.setMaxInactiveInterval(10*60);//초단위 입력: 10X60s=10분
		  
		//로그인 후 해당 등급별 페이지로 이동하자
		if(dto.getRole().toUpperCase().equals("ADMIN")){
			response.sendRedirect("admin_main.jsp");
		}else if(dto.getRole().toUpperCase().equals("MANAGER")){
			response.sendRedirect("manager_main.jsp");
		}else if(dto.getRole().toUpperCase().equals("USER")){
			response.sendRedirect("user_main.jsp");
		}
	}else{
		%>
		<script type="text/javascript">
			alert("아이디와 패스워드를 확인하세요!!");
			location.href="index.jsp";
		</script>
		<%
	}
%>
</body>
</html>


