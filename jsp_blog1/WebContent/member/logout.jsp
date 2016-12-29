<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	session.invalidate();
	
	response.sendRedirect("../index.jsp");
%> 