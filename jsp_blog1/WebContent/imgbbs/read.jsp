<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	
	int no = Integer.parseInt(request.getParameter("no"));
	idao.upViewcnt(no);
	ImgbbsDTO dto = idao.read(no);
	String content = dto.getContent();
	content = content.replaceAll("\r\n", "<br>");
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script type="text/javascript">
function blist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function bupdate() {
	var url = "updateForm.jsp";
	url += "?no=<%=no%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function bdelete() {
	var url = "deleteForm.jsp";
	url += "?no=<%=no%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	url += "&oldfile=<%=dto.getFilename()%>";
	location.href = url;
}
function breply() {
	var url = "replyForm.jsp";
	url += "?no=<%=no%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function down(filename) {
	var url = "<%=root %>/download";
	url += "?dir=/imgbbs/storage";
	url += "&filename=" + filename;
	
	location.href = url;
}
function readGo(no){
	var url = "./read.jsp";
	url = url +"?no="+no;
	
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
 <DIV class="title">게시판 목록</DIV>
  
<FORM name='frm' method='POST' action='./list.jsp'>
  <TABLE>
  <tr>
  	<td colspan="2">
  	<img src="./storage/<%=dto.getFilename() %>">
  	</td>
  </tr>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=dto.getContent() %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getName() %></TD>
    </TR>
    <TR>
      <TH>조회수</TH>
      <TD><%=dto.getViewcnt() %></TD>
    </TR>
    <TR>
      <TH>등록일</TH>
      <TD><%=dto.getWdate().substring(0, 10) %></TD>
    </TR>
    <TR>
      <TH>파일</TH>
      <TD>
      <%if(dto.getFilename()==null) {
    	  out.print("파일 없음");
      } else {%>
      <%=dto.getFilename() %>
      <a href="javascript:down('<%=dto.getFilename()%>')">
      <span class='glyphicon glyphicon-download-alt'></span></a>
      <% } %>
      </TD>
    </TR>
  </TABLE>
  
  <TABLE style="width: 50%">
  <TR>
  <%
  	List list = idao.imgRead(no);
    String[] files = (String[])list.get(0);
    int[] noArr = (int[])list.get(1);
    for(int i=0;i<5;i++){
    	if(files[i]==null){  
  %>
  <td><img src="./storage/default.jpg" width="100%"><td>
  <%
    	}else{
    		if(noArr[i]==no){
  %> 	
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="curImg" src="./storage/<%=files[i] %>" width="100%" border="0">
  </a></td>
  <%		
    		}else{
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img src="./storage/<%=files[i] %>" width="100%" border="0">
  </a></td>
  			
  <%
    		}
    	 }   		
      }
  %>
  </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록' onclick="location.href='./createForm.jsp'">
    <input type='button' value='목록' onclick="blist()">
    <input type='button' value='수정' onclick="bupdate()">
    <input type='button' value='삭제' onclick="bdelete()">
    <input type='button' value='답변' onclick="breply()">
  </DIV>
</FORM>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>