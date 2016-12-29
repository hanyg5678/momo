<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="address.AddressDTO"/>
<jsp:setProperty property="*" name="dto"/>
<% 
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	int no = Integer.parseInt(request.getParameter("no"));
	boolean flag = adao.delete(no);
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
<div>
<%
	if(flag) {
		out.print("정보를 삭제했습니다.");
	} else {
		out.print("정보 삭제를 실패했습니다.");
	}
%>
<br>
<input type="button" value="목록" onclick="alist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>