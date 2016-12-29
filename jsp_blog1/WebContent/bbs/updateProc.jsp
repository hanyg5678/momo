<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<% 

	String upDir = "/bbs/storage";
	String tempDir = "/bbs/temp";
	
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileItem = upload.getFileItem("filename");
	int filesize = (int)fileItem.getSize();
	String filename = null;
	if(filesize > 0) {		// 새로운 파일을 업로드 했다.
		UploadSave.deleteFile(upDir, oldfile);	// 기존파일을 삭제.
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	dto.setFilesize(filesize);
	dto.setFilename(filename);
			
	Map map = new HashMap();
	map.put("bbsno", dto.getBbsno());
	map.put("passwd", dto.getPasswd());
	boolean pflag = bdao.passCheck(map);
	
	boolean flag = false;
	if(pflag) {
		flag = bdao.update(dto);
	}
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function blist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
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
 
<DIV class="title">처리 결과</DIV>
<DIV class='content'>
<%
	if(pflag==false) {
		out.print("패스워드가 일치하지 않습니다.");
	} else if(flag){
		out.print("글을 변경하였습니다.");
	} else {
		out.print("글 변경을 실패했습니다.");
	}
%>
</div>
<%
	if(pflag==false) { %>
	<div class='bottom'>
    <input type='submit' value='다시 시도' onclick="history.back()">
    <input type='button' value='목록' onclick="blist()">
</DIV>
<% } else {%>
<div class='bottom'>
    <input type='submit' value='다시등록' onclick="history.back()">
    <input type='button' value='목록' onclick="blist()">
</DIV>
<% } %>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>