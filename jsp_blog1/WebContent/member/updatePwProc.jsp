<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	boolean flag = dao.updatePw(id, passwd);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
 
<DIV class="title">패스워드 수정 처리</DIV>
<div class="content">
<%
	if(flag) {
		out.print("패스워드를 변경 했습니다.<br>");
		out.print("로그인을 해보세요.<br>");		
	} else {
		out.print("패스워드 변경을 실패했습니다.");
	}
%>
</div>
  <DIV class='bottom'>
  <%if(flag) { %>
    <input type='button' value='로그인' onclick="location.href='./loginFor.jsp'">
    <% } else { %>
    <input type='button' value='다시시도' onclick="history.back()">
    <% } %>    
    <input type='button' value='홈' onclick="location.href='../index.jsp'">
  </DIV>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>