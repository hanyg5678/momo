<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="memo.MemoDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	boolean flag = mdao.create(dto);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
}
</style> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div>
<%
	if(flag) {
		out.print("메모를 등록 했습니다.");
	} else {
		out.print("메모등록이 실패했습니다.");
	}
%>
<br>
<input type="button" value="계속 등록" onclick="location.href='./createForm.jsp'">
<input type="button" value="목록" onclick="location.href='./list.jsp'">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>