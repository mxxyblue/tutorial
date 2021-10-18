<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.hk.dtos.LoginDto"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

#replyForm{
		display: none
 	} 

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
	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
// 	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("index.jsp");
// 		response.sendRedirect("index.jsp");
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
			        <li><a href="#">공부게시판</a></li>
			      </ul>
			    </nav>
			  </div>
		</div>
		<div id="main">
		<h1>튜터신청게시판</h1>
		<table class="table table-hover">
			<tr>
				<th>작성자</th>
				<td>${dto.aid}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${dto.atitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" class="form-control" readonly>${dto.acontent}</textarea> </td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-default" onclick="updateForm(${dto.aseq})">수정</button>
					<c:choose>
						<c:when test="${ldto.id eq dto.aid || ldto.role eq 'ADMIN' }">
							<button type="button" class="btn btn-default" onclick="delBoard(${dto.aseq})">삭제</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default" disabled="disabled" onclick="delBoard(${dto.aseq})">삭제</button>
						</c:otherwise>
					</c:choose>
					<button type="button" class="btn btn-default" onclick="replyForm()">답글</button>
					<button type="button" class="btn btn-default" onclick="boardList()">목록</button>
				</td>
			</tr>
		</table>
		<hr/>
			<div id="replyForm">
			<h1>답글 추가하기</h1>
			<form action="AController.do" method="post">
				<input type="hidden" name="command" value="replyboard"/>
				<input type="hidden" name="seq" value="${dto.aseq}"/>
				<table class="table table-hover">
					<tr>
						<th>작성자</th>
						<td><input required="required" type="text" name="id" class="form-control" value="<%=ldto.getId()%>" readonly/></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input required="required" type="text" name="title" class="form-control"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea required="required" rows="10" cols="60" name="content" class="form-control"></textarea> </td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="답글추가" class="btn btn-primary"/></td>
					</tr>
				</table>
			</form>
			</div>
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

<script type="text/javascript">
	//글 수정하기
	function updateForm(seq){
		location.href="AController.do?command=updateform&seq="+seq;
	}

	//글삭제 기능
	function delBoard(seq){
		location.href="AController.do?command=muldel&chk="+seq;
	}
	
	//답글 폼의 위치를 스크롤 이동을 통해 보여주는 기능
	function replyForm(){
		$("#replyForm").show();
		var replyPosition=$("#replyForm").offset().top;//div의 상단위치를 구함
		$("#tablebox").animate({
			"scrollTop":replyPosition
		},1000);
	}
	
	//글목록으로 돌아가기
	function boardList(){
		location.href="AController.do?command=boardlist";
	}
</script>
</body>
</html>









