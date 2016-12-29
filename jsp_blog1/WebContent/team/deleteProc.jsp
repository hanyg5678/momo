<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	  int no = Integer.parseInt(request.getParameter("no"));
	  String oldfile = request.getParameter("oldfile");
	  boolean flag = tdao.delete(no);
	  
	  
	  if(flag) {
		  String upDir = application.getRealPath("/team/storage");
		  UploadSave.deleteFile(upDir, oldfile);
	  }
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function tlist() {
	var url = "list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	
	location.href = url;
}
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
<div>
<%
	if(flag) {
		out.print("메모를 삭제했습니다.");
	} else {
		out.print("메모 삭제를 실패했습니다.");
	}
%>
<br>
<input type="button" value="목록" onclick="tlist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 