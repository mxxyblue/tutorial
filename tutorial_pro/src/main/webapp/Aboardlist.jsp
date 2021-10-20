<%@include file="header.jsp" %>
<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.ADto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>글목록보기</title>

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
	
	function insertForm(){
		location.href="AController.do?command=insertform";
	}
	
	/*
	아작스
	*/
	
	//게시판에서 refer, step, ...등의 값을 감추거나 보이게 하는 기능
// 	function attrShow(){
// 		$("th").slice(5,8).toggle().end().eq(9).toggle();
// 		$("tr").each(function(){
// 			$(this).children("td").slice(5,8).toggle().end().eq(9).toggle();
// 		});
		
// 	}
	
</script>
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

</style>
</head>
<%
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("loginindex.jsp");
	}
%>
<%
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
<%
// 	Util util=new Util();

%>

<jsp:useBean id="util" class="com.hk.utils.Util" />
<%-- <jsp:setProperty property="arrow" name="util" value="2222"/> --%>
<%-- <jsp:getProperty property="arrow" name="util"/> --%>
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
		<h1>튜터신청게시판</h1>
		<form action="AController.do" method="post" onsubmit="return isChecked()">
		<input type="hidden" name="command" value="muldel"/>
		<table class="table table-hover">
			<tr>
				<th><input class="checkbox" type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:set var="count" value="0" />
			<c:choose>
				<c:when test="${empty list}">
					<tr><td colspan="10">---작성된 글이 없습니다.---</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr>
							<c:choose>
								<c:when test="${ldto.id eq dto.aid || ldto.role eq 'ADMIN' }">
									<td><input class="checkbox" type="checkbox" name="chk" value="${dto.aseq}"/></td>
								</c:when>
								<c:otherwise>
									<td><input class="checkbox" disabled="disabled" type="checkbox" name="chk" value="${dto.aseq}"/></td>
								</c:otherwise>
							</c:choose>						
							<td>${count=count+1}</td>
							<td>${dto.aid}</td>
							<c:choose>
								<c:when test="${dto.adelflag eq 'N'}">
									<td style="width:300px;">								 								
										<jsp:setProperty property="arrow" name="util" value="${dto.adepth}"/>
										<jsp:getProperty property="arrow" name="util"/>
										<c:choose>
											<c:when test="${dto.aid eq ldto.id || ldto.role eq 'ADMIN' }">
												<a href="AController.do?command=detailboard&seq=${dto.aseq}">${dto.atitle}</a>
											</c:when>
											<c:otherwise>
												<img src="img/lock.png"/>
												<span>비밀글은 작성자와 관리자만 볼 수 있습니다.</span>
											</c:otherwise>
										</c:choose>
									</td>					
								</c:when>  
								<c:otherwise>
									<td style="width:300px;">--삭제된 글입니다.--</td>
								</c:otherwise>             								
							</c:choose>
							<td>${dto.aregdate}</td>
							<td>${dto.areadcount}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		
			<tr>
				<td colspan="10">
					<input class="btn btn-default" type="submit" value="삭제">
					<input class="btn btn-default" type="button" value="글추가" onclick="insertForm()" />
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
<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
</body>
</html>







