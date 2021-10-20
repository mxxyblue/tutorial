<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	#main >ul{ list-style:none;}
	
	#wrap{
	width: 100%;
	max-width: 1500px; margin: 0 auto;
}

	
	#menu, #main, #login{
	margin: 10px auto;
}
	
	/* 메뉴 시작 */
	:before, :after {
	  box-sizing: border-box;
	}
	
	.unstyled {
	  list-style: none;
	  padding: 0;
	  margin: 0;
	}
	.unstyled a {
	  text-decoration: none;
	}
	
	.list-inline {
	  overflow: hidden;
	}
	.list-inline li {
	  float: left;
	}
	
	#menu {  
	  	float: left;
		width: 14%;
		height:500px;
		background-color:#0074BB;
		text-align: center;
		
	}
	
	.logo {
	  text-transform: lowercase;
	  font: 300 2em "Source Sans Pro", Helvetica, Arial, sans-serif;
	  text-align: center;
	  padding: 0;
	  margin: 0;
	  color: white;
	}

	.logo span {
	  font-weight: 700;
	  transition: .15s linear color;
	  padding: 10px;
	}
	
	.main-nav ul {
	  border-top: solid 1px #0074BB;
	}
	.main-nav li {
	  border-bottom: solid 1px #0074BB;
	}
	.main-nav a {
	  padding: 1.1em 0;
	  color: #DFDBD9;
	  font: 400 1.125em "Source Sans Pro", Helvetica, Arial, sans-serif;
	  text-align: center;
	  text-transform: lowercase;
	}
	.main-nav a:hover {
	  color: #fff;
	}
	
	
	.list-hover-slide li {
	  position: relative;
	  overflow: hidden;
	}
	.list-hover-slide a {
	  display: block;
	  position: relative;
	  z-index: 1;
	  transition: .35s ease color;
	}
	.list-hover-slide a:before {
	  content: '';
	  display: block;
	  z-index: -1;
	  position: absolute;
	  left: -100%;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  border-right: solid 5px #F186B6; 
	  background: #0074BB;
	  transition: .35s ease left;
	}
	.list-hover-slide a.is-current:before, .list-hover-slide a:hover:before {
	  left: 0;
	}
/* 메뉴 끝 */
/* 두번쨰 메뉴 시작 */

	.main-nav2 ul {
	  border-top: solid 1px #F186B6;
	}
	.main-nav2 li {
	  border-bottom: solid 1px #F186B6;
	}
	.main-nav2 a {
	  padding: 1.1em 0;
	  color: #fff;
	  font: 400 1.125em "Source Sans Pro", Helvetica, Arial, sans-serif;
	  text-align: center;
	  text-transform: lowercase;
	}
	.main-nav2 a:hover {
	  color: #DFDBD9;
	}
	
	
	.list-hover-slide2 li {
	  position: relative;
	  overflow: hidden;
	}
	.list-hover-slide2 a {
	  display: block;
	  position: relative;
	  z-index: 1;
	  transition: .35s ease color;
	}
	.list-hover-slide2 a:before {
	  content: '';
	  display: block;
	  z-index: -1;
	  position: absolute;
	  left: -100%;
	  top: 0;
	  width: 100%;
	  height: 100%;
	  border-right: solid 5px #0074BB; 
	  background: #F186B6;
	  transition: .35s ease left;
	}
	.list-hover-slide2 a.is-current:before, .list-hover-slide2 a:hover:before {
	  left: 0;
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
/* 두번째 메뉴 끝 */
	
	#main{
	margin-left:10px;
	float: left;
	width: 72%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	font-family: 'Gothic A1', sans-serif;
/* 	background-color: #F2F2F2; */
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

#test{display: inline-block;}
</style>
</head>
<%
LoginDto ldto=(LoginDto)session.getAttribute("ldto");
	String finalRole;
	if(ldto.getRole().equals("TUTOR")){
		finalRole="튜터★";
}else if(ldto.getRole().equals("TUTEE")){
	finalRole="튜티★";
}else{
	finalRole="관리자";
}
%>
<body>
<div id="wrap">
	<div id="header">
			<a href="TuController.do?command=main2">
			<img width="200px" height="200px" src="img/logo.png" alt="logo"/>
			</a>
	</div>
	<div id="container">
		<div id="menu" role="banner">
			  <br>
			  <div class="nav-wrap">
			    <nav class="main-nav" role="navigation">
			      <ul class="unstyled list-hover-slide">
			        <li><a href="TuController.do?command=boardlist">홍보게시판</a></li>
			        <li><a href="AController.do?command=boardlist">튜터신청게시판</a></li>
			        <li><a href="StuController.do?command=boardlist">공부게시판</a></li>
			      </ul>
			    </nav>
			  </div>
		</div>
		<div id="main">
		<h1>일정 수정하기</h1>
		<form action="CalController.do" method="post">
			<input type="hidden" name="command" value="calupdate"/>
			<input type="hidden" name="cseq" value="${dto.cseq}"/>
			<div id="test">
			<table class="table table-hover" style="width: 600px;">
				<tr>
					<th>아이디</th>
					<td>${sessionScope.ldto.id}</td>
				</tr>
				<tr>
					<th>일정</th>
					<td>
		<%-- 				<c:set var="num" value="0" /> --%>
		<!-- 				<input type="date" name="ymd"  -->
		<%-- 				value="${param.year}-${fn:length(param.month)<2?num+=param.month:param.month}-${fn:length(param.date)<2?num+=param.date:param.date}" /> --%>
						<select name="year" >
							<c:set var="yearP"  value="${fn:substring(dto.mdate,0,4)}"/>
							<c:forEach var="i" begin="${yearP-5}" end="${yearP+5}" step="1">
								<option ${yearP==i?"selected":""} value="${i}">${i}</option>						
							</c:forEach>
						</select>년
						<select name="month">
							<c:set var="monthP"  value="${fn:substring(dto.mdate,4,6)}"/>
							<c:forEach var="i" begin="1" end="12" step="1" >
							<option ${monthP==i?"selected":""} value="${i}">${i}</option>						
							</c:forEach>
						</select>월
						<select name="date">
							<c:set var="dateP"  value="${fn:substring(dto.mdate,6,8)}"/>
							<c:forEach var="i" begin="1" end="31" step="1" >
							<option ${dateP==i?"selected":""} value="${i}">${i}</option>						
							</c:forEach>
						</select>일
						<select name="hour">
							<c:set var="hourP"  value="${fn:substring(dto.mdate,8,10)}"/>
							<c:forEach var="i" begin="0" end="23" step="1" >
							<option ${hourP==i?"selected":""} value="${i}">${i}</option>						
							</c:forEach>
						</select>시
						<select name="min">
							<c:set var="minP"  value="${fn:substring(dto.mdate,10,12)}"/>
							<c:forEach var="i" begin="0" end="59" step="1" >
							<option ${minP==i?"selected":""} value="${i}">${i}</option>						
							</c:forEach>
						</select>분
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="caltitle" value="${dto.caltitle}"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="60" name="calcontent">${dto.calcontent}</textarea> </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" class="btn btn-default" value="수정완료"/>
						<input type="button" class="btn btn-default" value="돌아가기"
						  onclick=
			"location.href='CalController.do?command=caldetail&cseq=${dto.cseq}&year=${param.year}&month=${param.month}&date=${param.date}'"/>
					</td>
				</tr>
			</table>
			</div>
		</form>
		</div>
		<c:choose>
		<c:when test="${ldto.role eq 'ADMIN'}"> 
				<div id="login" role="banner">
					<br>
					<div class="nav-wrap">
						<nav class="main-nav2" role="navigation">
						    <ul class="unstyled list-hover-slide2">
							<li style="color: white; font-weight: bold;"><%=ldto.getName()%>님</li><li>반갑습니다~</li>
							<li>등급:<%=finalRole%></li>
							<br>
							<li><a href="userlist_status.jsp">회원정보조회</a></li>
							<li><a href="userlist.jsp">회원등급변경</a></li>
							<li><a href="updateteamnum.jsp">튜터링팀생성</a></li>
							<li><a href="LoginController.do?command=logout">로그아웃</a></li>
						</ul>
						</nav>
					</div>
				</div>
		</c:when>
		<c:otherwise>
				<div id="login" role="banner">
				<br>
				<div class="nav-wrap">
					<nav class="main-nav2" role="navigation">
					    <ul class="unstyled list-hover-slide2">
						<li style="color: white; font-weight: bold;"><%=ldto.getName() %>님</li><li>반갑습니다~</li>
						<li>등급:<%=finalRole%></li>
						<br>
						<li><a href="userinfo.jsp?id=<%=ldto.getId()%>">마이페이지</a></li>
						<li><a href="LoginController.do?command=logout">로그아웃</a></li>
					</ul>
					</nav>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	</div>
	</div>
</body>
</html>