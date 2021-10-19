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

<meta charset="UTF-8" />
<title></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu:wght@700&display=swap" rel="stylesheet">
<!--       <link rel="stylesheet" type="text/css" href="style2.css"> -->
<style type="text/css">
/*    @import url("f/style2.css"); */


#main >ul{ list-style:none;}

.box1, .box2, .box3, .box4,.box5,.box6{
/*    background-color: white; */
   display: inline-block;
}


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
/*    height:500px; */
    text-align: center; 
   position: relative;
   background-color: #F186B6;
   
   }
/* 두번째 메뉴 끝 */

#main{
   margin-left:10px;
   float: left;
   width: 72%;
/*    height:500px; */
    text-align: center; 
   position: relative;
/*    background-color: #F2F2F2; */
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


h1{
font-family: 'Gaegu', cursive;
}
   
   
/*테이블 디자인 추가 */


</style>
<script type="text/javascript">
   $(function(){
      
      
      
   });
</script>
</head>

<body>
<%

%>
<div id="wrap">
   <div id="header">
         <a href="index.jsp">
         <img width="200px" height="200px" src="img/logo.png" alt="logo"/>
         </a>
   </div>
   
   <div id="container">
      <div id="menu" role="banner">
           <br>
           <div class="nav-wrap">
             <nav class="main-nav" role="navigation">
               <ul class="unstyled list-hover-slide">
                 <li><a href="loginindex.jsp">홍보게시판</a></li>
                 <li><a href="loginindex.jsp">튜터신청게시판</a></li>
                 <li><a href="loginindex.jsp">공부게시판</a></li>
               </ul>
             </nav>
           </div>
      </div>
      <div id="main">
<!--          <h1>★ 튜터 / 튜티 홍보 ★</h1> -->
         <c:forEach items="${list}" var="dto">
         <div class="box1">
            <table class="table table-hover">
<!--             <colgroup> -->
<!--             <col width="10%"><col width="10%"></colgroup> -->
               
               
               <tr>
                  <th>작성자</th>
                  <td>${dto.tid}</td>
               </tr>
               <tr>
                  <th>제목</th>
                  <td>${dto.ttitle}</td>
               </tr>
               <tr>
                  <th>내용</th>
                  <td><textarea rows="10" cols="30" readonly>${dto.tcontent}</textarea> </td>
               </tr>
               <tr>
                  <td colspan="2">
                     <a href="TuController.do?command=detailboard&seq=${dto.tseq}"><button class="btn btn-default" type="button">글이동</button></a>
                  </td>
               </tr>
            </table>
         </div>
         </c:forEach>
      </div>
      <div id="login" role="banner">
      <br>
      <div class="nav-wrap">
         <nav class="main-nav2" role="navigation">
             <ul class="unstyled list-hover-slide2">
                 <li><a href="loginindex.jsp">로그인</a></li>
               <li><a href="registform.jsp">회원가입</a></li>
              </ul>
         </nav>
      </div>
   </div>
   </div>
   
</div>

<div id="footer">주소: 서울특별시 영등포구 양평동3가 15-1 4층</div>
</body>
</html>
