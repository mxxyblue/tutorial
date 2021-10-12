<%@page import="com.hk.utils.Util"%>
<%@page import="com.hk.dtos.CalDto"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정보기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	th{width: 80px;}
	td{height: 80px;width: 80px; vertical-align: top; position: relative; }
	a{text-decoration: none;}
	a > img{width: 15px; height: 15px;}
	.ctitle{background-color: skyblue;}
	
	/*일정 개수를 출력하는 div */
	.count{ 
		position: absolute;
		top:-25px;
		left:10px;
		background-color: skyblue;
		width: 30px;
		height: 30px;
		display: none;
		text-align: center;
		line-height: 30px;
		border-radius: 15px 15px 15px 0px;
	}
	#remain {
		background-color: skyblue;
	}
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
<body>
<h1>${sessionScope.ldto.name}님의 일정보기</h1>
<table border="1">
	<caption>
		<a href="CalController.do?command=calendar&year=<%=year-1%>&month=<%=month%>">◁</a>
		<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month-1%>">◀</a>
		<span><%=year%></span>년<span><%=month%></span>월
		<a href="CalController.do?command=calendar&year=<%=year%>&month=<%=month+1%>">▶</a>
		<a href="CalController.do?command=calendar&year=<%=year+1%>&month=<%=month%>">▷</a>
		<button onclick="penChg()">pen</button>
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
					<img src="img/pen1.png" alt="일정추가하기" />
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
<br/>
<a href="user_main.jsp" id="remain">메인으로</a>

<script type="text/javascript">
	function penChg(){
		var imgs=document.querySelectorAll("a > img");
		var n="";
		if(imgs[0].getAttribute("src")=="img/pen2.png"){
			n=1;
		}else{
			n=2;
		}
		for(var i=0;i<imgs.length;i++){
			imgs[i].setAttribute("src","img/pen"+n+".png");
		}
		
	}
</script>
</body>
</html>







