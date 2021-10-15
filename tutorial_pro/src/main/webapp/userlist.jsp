<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.daos.LoginDao2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보목록조회</title>
<script type="text/javascript">
	function updateRole(userId){
		location.href="updateroleform.jsp?id="+userId;
	}
</script>
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

	//각 페이지마다 dao 객체 생성코드를 작성
	LoginDao2 dao=LoginDao2.getLoginDao();
	List<LoginDto> list=dao.getAllUser();
%>
<body>
<h1>회원정보목록조회</h1>
<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>등급</th>
		<th>등급변경</th>
	</tr>
	<%
		if(list==null||list.size()==0){
			%>
			<tr>
				<td colspan="5">----가입한 회원이 없습니다.----</td>
			</tr>
			<%
		}else{
			for(int i=0;i<list.size();i++){
			 	LoginDto dto=list.get(i);
			%>
			<tr>
				<td><%=i+1%></td>
				<td><%=dto.getId()%></td>
				<td><%=dto.getName()%></td>
				<td><%=getRoleName(dto.getRole())%></td>
				<td><button <%=(dto.getId().equals(ldto.getId())||dto.getRole().equals("ADMIN"))?"disabled='disabled' title='자신은 변경할 수 없습니다.'":"" %> onclick="updateRole('<%=dto.getId()%>')">변경</button> </td>
			</tr>
			<%
			}
		}
	%>
	<tr>
		<td colspan="5">
			<button onclick="location.href='admin_main.jsp'" >메인</button>
		</td>
	</tr>
</table>
<%! //자바 선언부: 메서드 선언코드 작성
	public String getRoleName(String rName){
		String s="";
		switch(rName){
			case "ADMIN": s="관리자"; break;
			case "TUTOR" : s="튜터"; break;
			case "TUTEE" : s="튜티"; break;
			default : s="미정"; break;
		}
		return s;
	}
%>
</body>
</html>


