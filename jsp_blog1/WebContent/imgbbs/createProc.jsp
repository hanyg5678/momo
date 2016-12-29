<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>
<% 
	//--업로드용 변수 선언(폴더명) 실제 폴더 존재해야 함
	String upDir = "/imgbbs/storage";
	String tempDir = "/imgbbs/temp";
	// 절대 경로 생성	  
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);  
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size > 0) {
		filename = UploadSave.saveFile(fileItem, upDir);
	}	
	
	dto.setFilesize(size);
	dto.setFilename(filename);
	
	boolean flag = idao.create(dto);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function blist() {
	var url = "list.jsp";
	
	location.href=url;
}
</script>
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
<div class="title">처리결과</div>
<DIV class="content">
<%
	if(flag) {
		out.print("글이 등록되었습니다.");
	} else {
		out.print("글 등록이 실패했습니다.");
	}
%>
</DIV>
<div class="bottom">
<input type="button" value="계속 등록" onclick="location.href='./createForm.jsp'">
<input type="button" value="목록" onclick="blist()">
</div>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
</html>