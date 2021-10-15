<%@include file="header.jsp" %>
<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.ADto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.daos.LoginDao2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
response.setContentType("text/html; charset=UTF-8");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.hk.dtos.LoginDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀설정게시판</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&display=swap" rel="stylesheet">
<script type="text/javascript">
	function allSel(bool){
		var chks=document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked=bool;
		}
	}
	
	function isChecked(){
		var count=0;
		var chks=document.getElementsByName("chk");
		for (var i = 0; i < chks.length; i++) {
			if(chks[i].checked){
				count++;
			}
		}
		
		if(count==0){
			alert("최소 하나이상 체크해야 됩니다.");
			return false;
		}else{
			return true;
		}
	}
	
</script>
<style type="text/css">
/* 	#tablebox{ */
/* 		width: 800px ; */
/* 		margin: 0 auto; */
/* 	} */
	
/* 	#ajaxform{ */
/* 		width:600px; */
/*  		margin-left: 450px;  */
/* 	} */

	#login >ul{list-style:none;}
	#login> ul >li{margin-right:50px; font-size: 15px;}
	
	#submenu >ul{list-style:none;}
	#submenu> ul >li{margin-right:50px; font-size: 15px;}
	
	#main >ul{ list-style:none;}
	
	#wrap{
	width: 100%;
	max-width: 1500px; margin: 0 auto;
}

	
	#submenu, #main, #login{
	margin: 10px auto;
}
	
	#submenu {
	float: left;
	width: 14%;
	height:500px;
	background-color:#0074BB;
	text-align: center;
	
}
	
	#main{
	margin-left:10px;
	float: left;
	width: 72%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	background-color: #F2F2F2;
}
	
	#login{
	margin-left:10px;
	float: left;
	width: 12%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	background-color: #F186B6;
	
	}
	
	#footer {
	color:#523D02;
	text-align: center;
	line-height: 50px;
	clear: both;
	background-color: #F2F2F2;
	
}
	#header{
		text-align: center;
	}
	
	h1{
font-family: 'Gaegu', cursive;
}
/* 	#tablelist{ */
/* 		text-align: center;  */
/* 	} */
		
</style>
</head>
<%
//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
// 	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("index2.jsp");
// 		response.sendRedirect("index.jsp");
	}
	//각 페이지마다 dao 객체 생성코드를 작성
	LoginDao2 dao=LoginDao2.getLoginDao();
	List<LoginDto> list=dao.getAllUserTeam();
%>
<body>
<div id="wrap">
	<div id="header">
				<a href="TuController.do?command=main2">
				<img width="200px" height="200px" src="img/logo.png" alt="logo"/>
				</a>
	</div>
	<div id="submenu">
			<ul>
			<li><a href="TuController.do?command=boardlist">홍보게시판</a></li>
			<li><a href="AController.do?command=boardlist">튜터신청게시판</a></li>
			<li><a href="#">공부게시판</a></li>
			</ul>
	</div>
	<div id="container">
		<div id="main">
		<h1>★ 팀 설정 ★</h1>
		<!-- <div id="ajaxform"> -->
		<!-- 	작성일:<input type="text" id="regdate" /><br/>	 -->
		<!-- 	작성자:<input type="text" id="id" /><br/> -->
		<!-- 	제목:<input type="text" id="title" /><br/> -->
		<!-- 	내용:<textarea rows="2" cols="40" id="contentview"></textarea> -->
		<!-- </div> -->
<form action="TeamController.do" method="post" onsubmit="return isChecked()">
<input type="hidden" name="command" value="updateteamnum"/>
<table class="table table-hover">
	<tr>
		<th><input class="checkbox" type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>등급</th>
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
				LoginDto dto = list.get(i);
				%>
				<tr>
					<td><input class="checkbox" type="checkbox" name="chk" value="<%=dto.getId()%>"/></td>
					<td><%=i+1%></td>
					<td><%=dto.getId()%></td>
					<td><%=dto.getName()%></td>
					<td><%=getRoleName(dto.getRole())%></td>
				</tr>
				<%
			}
		}
	%>
	<tr>
		<td colspan="10">
			<input class="btn btn-default" type="submit" value="팀생성">
		</td>
	</tr>
	
</table>
</form>
</div>
	</div>
	<div id="login">
			<ul>
				<li><%=ldto.getName() %>님</li><li>반갑습니다~</li>
				<li>등급:<%=ldto.getRole().equals("TUTOR")?"튜터★":"튜티★"%></li>
				<br>
				<li><a href="userinfo.jsp?id=<%=ldto.getId()%>">마이페이지</a></li>
				<li><a href="LoginController.do?command=logout">로그아웃</a></li>
			</ul>
	</div>
	
</div>
<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
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







