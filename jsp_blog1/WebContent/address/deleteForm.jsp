<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String col = request.getParameter("col");
	String word = request.getParameter("word"); 
	String nowPage = request.getParameter("nowPage"); 
	int no = Integer.parseInt(request.getParameter("no"));
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
  font-size: 20px; 
}
</style>
<script type="text/javascript">
function alist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<form method="post" action="deleteProc.jsp">
<input type="hidden" name="memono" value="<%=no%>">
<input type="hidden" name="col" value="<%=col%>">
<input type="hidden" name="word" value="<%=word%>">
<input type="hidden" name="nowPage" value="<%=nowPage%>">
<div>
삭제를 하면 복구 될 수 없습니다.<br><br>
삭제하시려면 삭제버튼을 클릭하세요<br><br>
취소는 '목록'버튼을 누르세요
<br><br>
<input type="submit" value="삭제처리">
<input type="button" value="목록" onclick="alist()">
</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 