<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.hk.dtos.LoginDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글추가폼</title>
<style type="text/css">
#submenu >ul{list-style:none;}
#login >ul{list-style:none;}

#submenu> ul >li{margin-right:50px; font-size: 15px;}
#login> ul >li{margin-right:50px; font-size: 15px;}

#main >ul{ list-style:none;}

.box1, .box2, .box3, .box4,.box5,.box6{
	background-color: white;
	display: inline-block;
}


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

#login{
	margin-left:10px;
	float: left;
	width: 12%;
/* 	height:500px; */
 	text-align: center; 
	position: relative;
	background-color: #F186B6;
	
	}

h1{
font-family: 'Gaegu', cursive;
}
</style>
<script type="text/javascript">
	//글목록으로 돌아가기
	function boardList(){
		location.href="StuController.do?command=stuboardlist";
	}
</script>
</head>
<%
	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");

	if(ldto==null){
		pageContext.forward("loginindex.jsp");
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
		<div id="submenu">
				<ul>
				<li><a href="TuController.do?command=boardlist">홍보게시판</a></li>
				<li><a href="#">튜터신청게시판</a></li>
				<li><a href="#">공부게시판</a></li>
				</ul>
		</div>
		<div id="main">
			<h1>게시글추가하기</h1>
			<form action="StuController.do" method="post">
				<input type="hidden" name="command" value="insertboard"/>
				<table class="table table-hover">
					<tr>
						<th>작성자</th>
						<td><input required="required" type="text" name="id" class="form-control" value="<%=ldto.getId()%>" readonly="readonly"/></td>
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
						<td colspan="2">
								<input type="submit" value="글추가" class="btn btn-default"/>
								<input type="button" value="글목록" class="btn btn-default"
																		onclick="boardList()"/>
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
</body>
</html>