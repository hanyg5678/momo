<%@ page contentType="text/html; charset=UTF-8" %> 
 
<% String root = request.getContextPath(); 
	String id = (String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
%>
 
<html>
<head>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
ul#menu li{
display : inline;
}
ul#menu li a{
background-color: black;
color:white;
pading : 10px 20px;
text-decoration:none;
border-radius:4px 4px 0 0;
}
ul#menu li a:hover{
background-color: orange;
}
.table {
widht: 100%;
}
.table, .td{
border-style: none;
}
* {
text-align: center;
margin: 1px auto ;
}
li#admin{
padding-right: 10px;
}
body {
	background-color: #f9c596;
}
.bg-1 { 
      background-color: #f9c596;
      color: #fd5c9f;
  }
.bg-2 { 
      background-color: black;
      color: white;
  }
  .carousel-inner {
      width: 250px;
      height: 250px;
      margin: auto;
}
</style>
<link href="<%=root %>/css/style.css" rel="stylesheet">
</head>
<body>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
      <div class="item active">
        <img src="<%=root %>/menu/images/트와이스.jpg" width="250px" height="250px">
        <div class="carousel-caption">
        </div>      
      </div>

      <div class="item">
        <img src="<%=root %>/menu/images/트와이스2.jpg" width="250px" height="250px">
        <div class="carousel-caption">
        </div>      
      </div>
    
      <div class="item">
        <img src="<%=root %>/menu/images/트와이스3.jpg" width="250px" height="250px">
        <div class="carousel-caption">
        </div>      
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>    

</div>
<!-- 상단 메뉴 -->
<div class="dropdown"  style="text-align: left;">
    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
    <span class="glyphicon glyphicon-menu-hamburger"></span></button>
    <ul class="dropdown-menu">
	      <li class="active"><a href="<%=root %>/index.jsp">메인페이지</a></li>
	     <%if(id==null) { %>
	     <li><a href="<%=root %>/member/agreement.jsp">회원가입</a></li>
	     <li><a href="<%=root %>/member/loginForm.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li> 
	    <% } else if (id!= null && grade.equals("H")){ %>
	     <li><a href="<%=root %>/member/read.jsp"><span class="glyphicon glyphicon-user"></span>나의정보</a></li>
	     <li><a href="<%=root %>/bbs/list.jsp">게시판목록</a></li>
	     <li><a href="<%=root %>/bbs/createForm.jsp">게시판작성</a></li>
	     <li><a href="<%=root %>/memo/list.jsp">메모목록</a></li>
	     <li><a href="<%=root %>/memo/createForm.jsp">메모작성</a></li>
	     <li><a href="<%=root %>/imgbbs/list.jsp">이미지게시판</a></li>
	     <li><a href="<%=root %>/imgbbs/createForm.jsp">이지미게시판작성</a></li>
	     <li><a href="<%=root %>/member/deleteForm.jsp">회원탈퇴</a></li>
	     <li><a href="<%=root %>/member/logout.jsp"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
	     <% } %>	     
		<%if(id!=null && grade.equals("A")){ %>
		<li><a href="<%=root %>/member/logout.jsp"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
	     <li id="admin"><a href="<%=root %>/admin/list.jsp">회원목록</a></li>
	     <li><a href="<%=root %>/member/updateForm.jsp">회원정보수정</a></li>
	    <%} %>
  </ul>
</div>

<!-- 상단 메뉴 끝 -->
  
<!-- 내용 시작 -->
<div class="bg-1" style="width: 100%; padding-top: 10px;">
