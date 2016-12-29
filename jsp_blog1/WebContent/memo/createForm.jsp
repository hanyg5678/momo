<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
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
<script type="text/javascript">
function input(frm) {
	if(frm.title.value=="") {
		alert("제목을 입력하시오");
		frm.title.focus();
		return false;
	}
	
	if(frm.content.value=="") {
		alert("내용을 입력하시오");
		frm.content.focus();
		return false;
	}
	
}
</script> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div>등록</div>
<form name="frm" method="post" action="./createProc.jsp" onsubmit="return input(this)">
<table>
<tr>
	<th>제목</th>
	<td><input type="text" name="title" size="30" value=""></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="10" cols="30" name="content"></textarea></td>
</tr>
</table>
<div><input type='submit' value='전송'>
</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 