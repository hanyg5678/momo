<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>
<% 
	String upDir = application.getRealPath("/bbs/storage");
	String tempDir = application.getRealPath("/bbs/temp");

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	// 페이징과 검색을 위한 값
	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");
	// 답변을 위한 부모의 값
	dto.setGrpno(Integer.parseInt(upload.getParameter("grpno")));
	dto.setIndent(Integer.parseInt(upload.getParameter("indent")));
	dto.setAnsnum(Integer.parseInt(upload.getParameter("ansnum")));
	// 부모글 삭제를 제한하기 위해서
	dto.setNo(Integer.parseInt(upload.getParameter("no")));
	// form의 입력된 값 가져오기
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	// filename 가져오기
	FileItem fileItem = upload.getFileItem("filename");
	int filesize = (int)fileItem.getSize();
	String filename = null;
	if(filesize > 0) {
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	
	dto.setFilename(filename);
	dto.setFilesize(filesize);
	
	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());
	bdao.upAnsnum(map);
	boolean flag = idao.createReply(dto);
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
function bre(bbsno) {
	var url = "replyForm.jsp";
	url += "?bbsno=" + bbsno;
	url += "&col=<%=col%>";
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
<div class="title">처리결과</div>
<DIV class="content">
<%
	if(flag) {
		out.print("답변글이 등록되었습니다.");
	} else {
		out.print("답변글 등록이 실패했습니다.");
	}
%>
</DIV>
<div class="bottom">
<input type="button" value="계속 등록" onclick="location.href='./createForm.jsp'">
<input type="button" value="답변추가" onclick="bre('<%=dto.getNo()%>')">
<input type="button" value="목록" onclick="blist()">
</div>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
</html>