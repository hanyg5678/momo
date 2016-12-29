<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	int no = Integer.parseInt(request.getParameter("no"));
	ImgbbsDTO dto = idao.readReply(no);
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
function incheck(f) {
  if(f.name.value==""){
    alert("이름을 입력하세요");
    f.name.focus();
    return false;
  }
  if(f.title.value==""){
    alert("제목을 입력하세요");
    f.title.focus();
    return false;
  }
  if(f.content.value==""){
    alert("내용을 입력하세요");
    f.content.focus();
    return false;
  }
  if(f.passwd.value==""){
    alert("비밀번호을 입력하세요");
    f.passwd.focus();
    return false;
  }
  if(f.filename.value==""){
		alert("이미지를 저장하세요");
		f.filename.focus();
		return false;
	}
}
</script>
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
 
<DIV class="title">답변</DIV>
 
<FORM name='frm' 
		method='POST' 
		action='./replyProc.jsp'
		enctype="multipart/form-data"
		>
<!-- 답변을 등록하기 위해서 -->
<input type="hidden" name="grpno" value="<%=dto.getGrpno() %>">
<input type="hidden" name="indent" value="<%=dto.getIndent() %>">
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>">
<!-- 페이지와 검색 유지를 위해서 -->
<input name="col" value="<%=col %>" type="hidden">
<input name="word" value="<%=word %>" type="hidden">
<input name="nowPage" value="<%=nowPage %>" type="hidden">
<!-- 부모글 삭제를 막기위해서 -->
<input name="no" value="<%=no %>" type="hidden">
  <TABLE>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="name"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle() %>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="10" cols="45" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD><input type="file" name="filename"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
</html>  