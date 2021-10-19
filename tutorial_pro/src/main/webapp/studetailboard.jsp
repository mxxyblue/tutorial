<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@page import="com.hk.dtos.LoginDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	
 	#replyForm{
		display: none
 	} 
/* 	#tablebox{ */
/* 		overflow: auto; */
/* 		height: 500px; */
/* 	} */
	
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
</head>
<%
	//scope객체에 저장하면 모두 Object타입
	LoginDto ldto=(LoginDto)session.getAttribute("ldto");
// 	Object ldto=session.getAttribute("ldto");
	
	//sesseion에 로그인 정보가 없다면(로그아웃) 로그인 페이지로 이동
	if(ldto==null){
		pageContext.forward("loginindex.jsp");
// 		response.sendRedirect("index.jsp");
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
				<li><a href="StuController.do?command=boardlist">공부게시판</a></li>
				</ul>
		</div>
		<div id="main">
		<h1>게시글 상세보기</h1>
		<table class="table table-hover">
			<tr>
				<th>작성자</th>
				<td>${dto.sid}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${dto.stitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="60" class="form-control" readonly>${dto.scontent}</textarea> </td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" class="btn btn-default" onclick="updateForm(${dto.sseq})">수정</button>
					<button type="button" class="btn btn-default" onclick="delBoard(${dto.sseq})">삭제</button>
					<button type="button" class="btn btn-default" onclick="replyForm()">답글</button>
					<button type="button" class="btn btn-default" onclick="boardList()">목록</button>
				</td>
			</tr>
		</table>
		<hr/>
			<div id="replyForm">
			<h1>답글 추가하기</h1>
			<form action="StuController.do" method="post">
				<input type="hidden" name="command" value="replyboard"/>
				<input type="hidden" name="seq" value="${dto.sseq}"/>
				<table class="table table-hover">
					<tr>
						<th>작성자</th>
						<td><input required="required" type="text" name="id" class="form-control"/></td>
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

<script type="text/javascript">
	//글 수정하기
	function updateForm(seq){
		location.href="StuController.do?command=updateform&seq="+seq;
	}

	//글삭제 기능
	function delBoard(seq){
		location.href="StuController.do?command=muldel&chk="+seq;
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
		location.href="StuController.do?command=boardlist";
	}
</script>
</body>
</html>









