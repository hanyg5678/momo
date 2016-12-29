<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 

	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");

	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsDTO dto = bdao.read(bbsno);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function incheck(f) {
	if(f.wname.value=="") {
		alert("이름을 입력하세요");
		f.wname.focus();
		return false;
	}
	
	if(f.title.value=="") {
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	if(f.content.value=="") {
		alert("내용을 입력하세요");
		f.content.focus();
		return false;
	}
	if(f.passwd.value=="") {
		alert("패스워드를 입력하세요");
		f.passwd.focus();
		return false;
	}
	if(f.filename.value=="") {
		alert("이미지를 변경해주세요.");
		f.filename.focus();
		return false;
	}
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
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	method='POST' 
	action='./updateProc.jsp' 
	onsubmit="return incheck(this)"
	enctype="multipart/form-data"
	>
<input name="bbsno" value="<%=bbsno %>" type="hidden">
<input name="col" value="<%=col %>" type="hidden">
<input name="word" value="<%=word %>" type="hidden">
<input name="nowPage" value="<%=nowPage %>" type="hidden">
<input name="oldfile" value="<%=dto.getFilename() %>" type="hidden">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="wname" value="<%=dto.getWname() %>"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle() %>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"><%=dto.getContent() %></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="filename">(<%=Utility.checkNull(dto.getFilename()) %>)</TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
</html>  