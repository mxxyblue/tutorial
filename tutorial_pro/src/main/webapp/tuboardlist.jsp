<%-- <%@include file="header.jsp" %> --%>
<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.TuDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홍보게시판</title>
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
		location.href="TuController.do?command=insertform";
	}
	
	/*
	아작스
	*/
	
	//게시판에서 refer, step, ...등의 값을 감추거나 보이게 하는 기능
	function attrShow(){
		$("th").slice(5,8).toggle().end().eq(9).toggle();
		$("tr").each(function(){
			$(this).children("td").slice(5,8).toggle().end().eq(9).toggle();
		});
		
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

	#submenu >ul{list-style:none;}
	#submenu> ul >li{margin-right:50px; font-size: 15px;}
	
	#main >ul{ list-style:none;}
	
	#main, #footer{
	  	background-color: silver;  
	}
	
	#wrap{
		width: 100%;
		max-width: 1280px; margin: 0 auto;
	}
	
	#submenu, #main{
		margin: 10px auto;
	}
	
	#submenu {
		float: left;
		width: 18%;
		height:500px;
		background-color: #DAE3F3;
		text-align: center;
	}
	
	#main{
		margin-left:10px;
		float: left;
		width: 78%;
	/* 	height:500px; */
	 	text-align: center; 
		position: relative;
	}
	
	
	#footer {
		color:#523D02;
		text-align: center;
		line-height: 50px;
		clear: both;
		
	}
	#header{
		text-align: center;
	}
		
</style>
</head>

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
	<div id="submenu">
			<ul>
			<li><a href="TuController.do?command=boardlist">홍보게시판</a></li>
			<li><a href="#">튜터신청게시판</a></li>
			<li><a href="#">공부게시판</a></li>
			</ul>
	</div>
	<div id="container">
		<div id="main">
		<h1>게시판 글목록</h1>
		<!-- <div id="ajaxform"> -->
		<!-- 	작성일:<input type="text" id="regdate" /><br/>	 -->
		<!-- 	작성자:<input type="text" id="id" /><br/> -->
		<!-- 	제목:<input type="text" id="title" /><br/> -->
		<!-- 	내용:<textarea rows="2" cols="40" id="contentview"></textarea> -->
		<!-- </div> -->
		
		<form action="TuController.do" method="post" onsubmit="return isChecked()">
		<input type="hidden" name="command" value="muldel"/>
		<input type="button" value="속성보기" onclick="attrShow()">
		<table class="table table-hover">
			<tr>
				<th><input class="checkbox" type="checkbox" name="all" onclick="allSel(this.checked)"/></th>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>refer</th>
				<th>step</th>
				<th>depth</th>
				<th>조회수</th>
				<th>delflag</th>
			</tr>
			<c:set var="count" value="0" />
			<c:choose>
				<c:when test="${empty list}">
					<tr><td colspan="10">---작성된 글이 없습니다.---</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td><input class="checkbox" type="checkbox" name="chk" value="${dto.tseq}"/></td>
							<td>${count=count+1}</td>
							<td>${dto.tid}</td>
							<c:choose>
								<c:when test="${dto.tdelflag eq 'N'}">
									<td style="width:300px;">
		<%-- 							<c:forEach begin="0" end="${dto.depth}" var="nbsp" step="1"> --%>
		<!-- 								&nbsp;&nbsp;&nbsp;&nbsp; -->
		<%-- 							</c:forEach> --%>
		<%-- 							<c:if test="${dto.depth!=0}"> --%>
		<!-- 								 → -->
		<%-- 							</c:if> --%>
		<%-- 								<%=util.arrowNbsp(${dto.depth}) %>	 --%>
										<jsp:setProperty property="arrow" name="util" value="${dto.tdepth}"/>
										<jsp:getProperty property="arrow" name="util"/>
										<a href="TuController.do?command=detailboard&seq=${dto.tseq}">${dto.ttitle}</a>
									</td>					
								</c:when>
								<c:otherwise>
									<td style="width:300px;">--삭제된 글입니다.--</td>
								</c:otherwise>
							</c:choose>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${dto.tregdate}"/></td>
							<td>${dto.trefer}</td>
							<td>${dto.tstep}</td>
							<td>${dto.tdepth}</td>
							<td>${dto.treadcount}</td>
							<td>${dto.tdelflag}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="10">
					<input class="btn btn-primary" type="submit" value="삭제">
					<input class="btn btn-success" type="button" value="글추가" onclick="insertForm()" />
				</td>
			</tr>
			
		</table>
		</form>
		</div>
	</div>
</div>
<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
<%!
// public String arrowNbsp(String depth){
// 	String nbsp="";
// 	int depthInt=Integer.parseInt(depth);
// 	for(int i=0;i<depthInt;i++){
// 		nbsp+="&nbsp;&nbsp;&nbsp;&nbsp;";
// 	}
	
// 	return nbsp+(depthInt>0?"<img src='arrow.jpg'/>":"");
// }
%>
</body>

</html>







