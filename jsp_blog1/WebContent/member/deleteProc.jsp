<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String upDir = application.getRealPath("/member/storage");
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
	
	boolean flag = dao.delete(id);
	if(flag) {
		UploadSave.deleteFile(upDir, oldfile);
		session.invalidate();
	}
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
 
<DIV class="title">회원탈퇴</DIV>
<div class="content">
<%
	if(flag) {
		out.print("탈퇴 되었습니다. 자동 로그아웃 됩니다.");
	} else {
		out.print("탈퇴가 실패되었습니다.");
	}
%>
</div>
   <DIV class='bottom'>
    <input type='button' value='홈' onclick="location.href='../index.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>