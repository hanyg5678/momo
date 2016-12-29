<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<% request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
	String str = null;
	if(id==null) {
		str = "ONCE & TWICE";
	} else {
		str = "우리는 ONCE & TWICE 입니다" + id + "님!";
	}
%> 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<meta charset="utf-8">
<style type="text/css"> 
* {
  text-align: center;
  }
</style> 
<link href="css/style.css" rel="stylesheet">
</head> 
<body> 
<jsp:include page="./menu/top.jsp"/>
<div class="bg-1">
<div class="container-fluid bg-1 text-center">
<div class="content">
<h1><%=str %></h1>
</div>
  <div class="container text-center">
  <h3>One in a million! 안녕하세요 트와이스입니다.</h3>
  <br>
  <div class="row">
    <div class="col-sm-4">
      <p class="text-center"><strong>모모</strong></p><br>
      <a href="#demo" data-toggle="collapse" data-target="#demo">
        <img src="<%=root %>/menu/images/모모.jpg" class="img-circle person">
      </a>
      <div id="demo" class="collapse">
        <p>생일 : 1996년 11월 9일</p>
        <p>국적 : 일본</p>
        <p>트와이스 여신</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>나연</strong></p><br>
      <a href="#demo2" data-toggle="collapse" data-target="#demo2">
        <img src="<%=root %>/menu/images/나연.jpg" class="img-circle person">
      </a>
      <div id="demo2" class="collapse">
        <p>생일 : 1995년 9월 22일</p>
        <p>국적 : 대한민국</p>
        <p>트와이스 리더</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>다현</strong></p><br>
      <a href="#demo3" data-toggle="collapse" data-target="#demo3">
        <img src="<%=root %>/menu/images/다현.jpg" class="img-circle person">
      </a>
      <div id="demo3" class="collapse">
        <p>생일 : 1998년 5월 28일</p>
        <p>국적 : 대한민국</p>
        <p>트와이스 흥부자</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>미나</strong></p><br>
      <a href="#demo4" data-toggle="collapse" data-target="#demo4">
        <img src="<%=root %>/menu/images/미나.jpg" class="img-circle person">
      </a>
      <div id="demo4" class="collapse">
        <p>생일 : 1997년 3월 24일</p>
        <p>국적 : 일본</p>
        <p>잘모르겠음....</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>사나</strong></p><br>
      <a href="#demo5" data-toggle="collapse" data-target="#demo5">
        <img src="<%=root %>/menu/images/사나.jpg" class="img-circle person">
      </a>
      <div id="demo5" class="collapse">
        <p>생일 : 1996년 12월 29일</p>
        <p>국적 : 일본</p>
        <p>트와이스 샤샤샤</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>정연</strong></p><br>
      <a href="#demo6" data-toggle="collapse" data-target="#demo6">
        <img src="<%=root %>/menu/images/정연.jpg" class="img-circle person">
      </a>
      <div id="demo6" class="collapse">
        <p>생일 : 1996년 11월 1일</p>
        <p>국적 : 대한민국</p>
        <p>공승연동생....아버지 셰프...</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>지효</strong></p><br>
      <a href="#demo7" data-toggle="collapse" data-target="#demo7">
        <img src="<%=root %>/menu/images/지효.jpg" class="img-circle person">
      </a>
      <div id="demo7" class="collapse">
        <p>생일 : 1997년 2월 1일</p>
        <p>국적 : 대한민국</p>
        <p>잘모르겠음....</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>쯔위</strong></p><br>
      <a href="#demo8" data-toggle="collapse" data-target="#demo8">
        <img src="<%=root %>/menu/images/쯔위.jpg" class="img-circle person">
      </a>
      <div id="demo8" class="collapse">
        <p>생일 : 1999년 6월 14일</p>
        <p>국적 : 대만</p>
        <p>트와이스.....</p>
      </div>
    </div>
    <div class="col-sm-4">
      <p class="text-center"><strong>채영</strong></p><br>
      <a href="#demo9" data-toggle="collapse" data-target="#demo9">
        <img src="<%=root %>/menu/images/채영.jpg" class="img-circle person">
      </a>
      <div id="demo9" class="collapse">
        <p>생일 : 1999년 4월 23일</p>
        <p>국적 : 대한민국</p>
        <p>트와이스 아기맹수</p>
      </div>
    </div>
  </div>
</div>
</div>
</div>
<jsp:include page="./menu/bottom.jsp"/>
</body> 
</html> 