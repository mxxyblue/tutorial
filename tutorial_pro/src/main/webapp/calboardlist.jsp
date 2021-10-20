<%@page import="com.hk.utils.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp" %>
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

</style>
<script type="text/javascript">
	function allSel(bool){
		var chks=document.getElementsByName("cseq");
		for (var i = 0; i < chks.length; i++) {
			chks[i].checked=bool;
		}
	}
	
	function calendar(year,month){
		location.href=
		"CalController.do?command=calendar&year="+year+"&month="+month;
	}
	function chkConfirm(){
		var chks=document.getElementsByName("cseq");
		var count=0;
		for (var i = 0; i < chks.length; i++) {
			if(chks[i].checked){
				count++;
			}
		}
		if(count<=0){
			alert("최소 하나 이상 체크하세요")
			return false;
		}else{
			return true;
		}
	}
</script>
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
		<h1>일정목록<small>[${param.year}년 ${param.month}월 ${param.date}일]</small></h1>
		<form action="CalController.do" method="post" onsubmit="return chkConfirm()">
			<input type="hidden" name="command" value="muldel"/>
			<input type="hidden" name="year" value="${param.year}"/>
			<input type="hidden" name="month" value="${param.month}"/>
			<input type="hidden" name="date" value="${param.date}"/>
			<table class="table table-hover">
				<col width="5px">
				<col width="50px">
				<col width="200px">
				<col width="300px">
				<col width="100px">
				<tr>
					<th><input type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
					<th>번호</th>	
					<th>아이디</th>	
					<th>일정</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
				<c:choose>
					<c:when test="${empty list}">
						<tr><td colspan="5">---- 작성된 일정이 없습니다. ----</td></tr>
					</c:when>
					<c:otherwise>
						<c:set var="num" value="0" />
						<jsp:useBean id="util" class="com.hk.utils.Util" />
						<c:forEach var="dto" items="${list}">
							<tr>
								<td><input type="checkbox" name="cseq" value="${dto.cseq}"/></td>
								<td><c:set var="num" value="${num+1}"/>
									${num}
								</td>
								<td>${dto.id}</td>
								<td>
		<!-- 						jstl을 이용해서 날짜 형식 표현하기 -->
			<%-- 					<fmt:parseDate var="parseMdate" value="${dto.mdate}" pattern="yyyyMMddHHmm"/> --%>
			<%-- 					<fmt:formatDate value="${parseMdate}" pattern="yyyy년MM월dd일 HH시mm분"/> --%>
		<!-- 						Action Tag를 이용해서 날짜 형식 표현하기 -->
								 	<jsp:setProperty property="toDates" name="util" value="${dto.mdate}"/>
								 	<jsp:getProperty property="toDates" name="util"/>
								 </td>
								<td><a href="CalController.do?command=caldetail&cseq=${dto.cseq}&year=${param.year}&month=${param.month}&date=${param.date}">${dto.caltitle}</a></td>
								<td><fmt:formatDate value="${dto.calregdate}" pattern="yyyy-MM-dd"/> </td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<tr>
					<td colspan="6">
						<input type="button" class="btn btn-default" value="달력보기" onclick="calendar(${param.year},${param.month})"/>
						<input type="submit" class="btn btn-default" value="삭제"/>
					</td>
				</tr>
			</table>
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







