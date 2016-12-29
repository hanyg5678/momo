<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="address.AddressDTO"/>
<% 
	int no = Integer.parseInt(request.getParameter("no"));
	dto = adao.read(no);
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
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}
</script> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div>조회</div>
<table>
	<tr>
		<th>이름</th>
			<td><%=dto.getName()%></td>
	</tr>
	<tr>
		<th>전화번호</th>
			<td><%=dto.getPhone()%></td>
	</tr>
	<tr>
		<th>주소</th>
			<td>
				주소 : <%=dto.getAddress1()%><br>
				상세주소 : <%=dto.getAddress2()%><br>
				우편번호 : <%=dto.getZipcode()%>
			</td>
	</tr>
<tr></tr>
</table>
<div>
	<input type="button" value="생성" onclick="location.href = './createForm.jsp'">
	<input type="button" value="목록" onclick="alist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>