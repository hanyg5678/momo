<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String upDir = application.getRealPath("/team/storage");
	String tempDir = application.getRealPath("/team/temp");
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	
	String nowPage = upload.getParameter("nowPage");
	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	int no = Integer.parseInt(upload.getParameter("no"));
	
	// 수정할 사진 받기
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size > 0) {
		UploadSave.deleteFile(upDir, oldfile);
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	
	Map map = new HashMap();
	map.put("no", no);
	map.put("filename", filename);
	boolean flag = tdao.updateFile(map);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function tread() {
	var url = "read.jsp";
	url += "?no=<%=no %>";
	url += "&nowPage=<%=nowPage %>";
	url += "&col=<%=col %>";
	url += "&word=<%=word %>";
	
	location.href = url;
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
 
<DIV class="title">사진변경</DIV>
<div class="content">
<%
	if(flag) {
		out.print("사진을 변경했습니다.");	
	} else {
		out.print("사진변경을 실패했습니다.");
	}
%>
</div>

  <DIV class='bottom'>
    <input type='submit' value='조회' onclick="tread()">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>