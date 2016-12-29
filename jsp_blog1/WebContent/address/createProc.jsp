<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="address.AddressDTO"/>
<jsp:setProperty property="*" name="dto"/>
<% 
	boolean flag = adao.create(dto);
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
<script type="text/javascript">
function alist() {
	var url = "list.jsp";
	
	location.href=url;
}
</script> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div>
	<%
		if(flag) {
			out.print("사용자 등록에 성공하였습니다.");
		} else {
			out.print("사용자 등록에 실패하였습니다.");
		}	
	%>
	<br>
	<input type="button" value="계속 등록" onclick="location.href='./teamFormtest02.html'">
	<input type="button" value="목록" onclick="alist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>