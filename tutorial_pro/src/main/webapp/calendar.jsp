<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<%@page import="com.hk.dtos.LoginDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정보기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	th{width: 80px;}
	td{height: 80px;width: 80px; vertical-align: top; position: relative; }
/* 	a{text-decoration: none;} */
	#pen{width: 15px; height: 15px;}
	.ctitle{background-color: #0074BB; color: white;}
	
	/*일정 개수를 출력하는 div */
	.count{ 
		position: absolute;
		top:-25px;
		left:10px;
		background-color: #F186B6;
		width: 30px;
		height: 30px;
		display: none;
		text-align: center;
		line-height: 30px;
		border-radius: 15px 15px 15px 0px;
		color: white;
	}
	#remain {
		background-color: skyblue;
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
	font-family: 'Gothic A1', sans-serif;
	
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
	
	caption > a{color: black;}
	
 	h1{ 
 font-family: 'Gaegu', cursive; 
 } 

	#test{display: inline-block;}

</style>
<script type="text/javascript">
	$(function(){
		var countA;//hover의 함수들에 모두 공유하기 위해 선언
		$(".countA").hover(function() {
			console.log("일정 개수 보여 주세요!");
			//sever에 전달할 파라미터: yyyyMMdd 
			var year=$("caption > span").eq(0).text().trim();//" 2021  "
			var month=$("caption > span").eq(1).text().trim();//trim()은 앞뒤공백 제거
			var date=$(this).text().trim();
			countA=$(this);//hover 이벤트가 발생된 a태그
			$.ajax({
				url:"CalController.do",
				method:"post",
				async:false,
				data:{"command":"calCount",
					  "year":year,
					  "month":month,
					  "date":date
					},
				dataType:"text", // text, html, xml, json
				success:function(obj){
// 					console.log(obj);
// 					$(".count").text(obj);
					countA.parent().find(".count").text(obj).show();
				},
				error:function(){
					console.log("통신실패!!");
				}
			});
		}, function() {
			countA.parent().find(".count").text("").hide();
		});
	});
	
	
</script>
</head>
<%
	//요청한 년 , 월 파라미터를 받는다.
	String pYear=request.getParameter("year");//year-1
	String pMonth=request.getParameter("month");//month-1

	//java에서 제공하는 API:  Calendar 객체를 사용
	//추상클래스이기 때문에 new를 쓸 수 없다.
	Calendar cal=Calendar.getInstance();
	int year=cal.get(Calendar.YEAR);//현재 년도를 구함
	int month=cal.get(Calendar.MONTH)+1;//현재 월을 구함(0월~11월)
// 	int date=cal.get(Calendar.DATE);
	
	//원하는 년도와 월을 요청했다면 year와 month값을 해당값으로 변경하자
	if(pYear!=null){
		year=Integer.parseInt(pYear);
	}
	if(pMonth!=null){
		month=Integer.parseInt(pMonth);
	}
	
	//과제3
	//문제점: 12월에서 다음달로 넘어갈때 13월... , 년도도 다음년도로 변경
	//       1월에서 전달로 넘어갈때 0월,-1월.... 년도도 전년도로 변경
	
	//월중에 1월전으로 이동할 경우 month는 12월로, 년도는 전년도로 변경
	if(month<1){
		month=12;
		year--;
	}
	
	//월중에 12월이후로 이동할 경우 month는 1월로, 년도는 다음년도로 변경
	if(month>12){
		month=1;
		year++;
	}
	
	//1.현재 달의 1일에 대한 요일을 구하기---> 달력의 처음 시작하는 공백수를 구하기 위함 
	//해당 달의 1일로 Calendar객체를 설정하자
	cal.set(year, month-1, 1);// 2021-09-01로 셋팅한다.
	int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);//일(1)~토(7)
// 	System.out.println("현재 요일:"+dayOfWeek);
	
	//2.해당 달의 마지막 날 구하기
	int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	//한달 단위 일정 목록
	List<CalDto>list=(List<CalDto>)request.getAttribute("list");
%>
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
	<div id="container">
	<div id="main">
		<h1>${sessionScope.ldto.name}님의 일정보기</h1>
		<div id="test">
		<table class="table table-bordered">
			<caption>
				<a href="CalController.do?command=calendar&year=<%=year-1%>&month=<%=month%>">◁</a>
				<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month-1%>">◀</a>
				<span><%=year%></span>년<span><%=month%></span>월
				<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month+1%>">▶</a>
				<a href="CalController.do?command=calendar&year=<%=year+1%>&month=<%=month%>">▷</a>

			</caption>
			
			<tr>
				<th>일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
			</tr>
			<tr>
				<%
				//공백td출력하는 for문
				for(int i=0;i<dayOfWeek-1;i++){
					out.print("<td>&nbsp;</td>");//out은 jsp의 기본객체중에 하나임
				}
				//날짜td출력하는 for문
				for(int i=1;i<=lastDay;i++){
					%>
					<td>
						<a class="countA" style="color:<%=Util.fontColor(dayOfWeek, i) %>"
						href="CalController.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
						<a href="CalController.do?command=calinsertform&year=<%=year%>&month=<%=month%>&date=<%=i%>">
							<img id="pen" src="img/pen2.png" alt="일정추가하기" />
						</a>
						<div style="font-size: 3px;">
							<%=Util.getCalView(list, i)%>
						</div>
						<div class="count"></div>
					</td>
					<%
					// (현재날짜+공백수)%7==0 조건을 만족하는 요일은 토요일이다.
					if((i+dayOfWeek-1)%7==0){
						out.print("</tr><tr>");
					}
				}
				//과제: 1.달력의 나머지 공백수 출력하는 for문
				int nbsp=(7-(dayOfWeek-1+lastDay)%7)%7;
				for(int i=0;i<nbsp;i++){
					out.print("<td>&nbsp;</td>");
				}
				//     2.토요일과 일요일의 폰트색을 파란색과 빨간색으로 표현
				
				%>
			</tr>
			
		</table>
		</div>
		<br/>
		<button type="button" class="btn btn-default" onclick="boardList()">돌아가기</button>
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

<script type="text/javascript">
function boardList(){
	location.href="StuController.do?command=boardlist";
}
</script>
</body>
</html>







