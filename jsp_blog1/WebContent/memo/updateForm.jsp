<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String nowPage = request.getParameter("nowPage");
	int memono = Integer.parseInt(request.getParameter("memono"));
	MemoDTO dto = mdao.read(memono);
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
</script>
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
<div>수정</div>
<form name="frm" method="post" 
action="./updateProc.jsp" 
onsubmit="return input(this)">
<input type="hidden" name="memono" value="<%=memono %>">
<input type="hidden" name="col" value="<%=request.getParameter("col") %>">
<input type="hidden" name="word" value="<%=request.getParameter("word") %>">
<input type="hidden" name="nowPage" value="<%=nowPage %>">
<table>
<tr>
	<th>제목</th>
	<td><input type="text" name="title" size="30" value="<%=dto.getTitle() %>"></td>
</tr>
<tr>
	<th>내용</th>
	<td>
	<textarea rows="10" cols="30" name="content"><%=dto.getContent()%></textarea></td>
</tr>
</table>
<div><input type='submit' value='수정'>
</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>