<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>
<% 
	//--------------------검색관련---------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) {
		word = "";
	}
	
	// 페이지 관련-----------------------------------------------------
	int nowPage = 1;		// 현재 보고있는 페이지
	if(request.getParameter("nowPage")!=null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;		// 한페이지당 보여줄 레코드 개수
	
	// DB에서 가져올 순번---------------------------------------
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = idao.total(col, word);
	List<ImgbbsDTO> list = idao.list(map);
	Iterator<ImgbbsDTO> iter = list.iterator();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function down(filename) {
	var url = "<%=root %>/download";
	url += "?dir=/bbs/storage";
	url += "&filename=" + filename;
	
	location.href = url;
}
function read(no) {
	var url = "read.jsp";
	url += "?no=" + no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px;
} 
.search {
	width: 80%;
	text-align: center;
	margin: 1px auto;
}
</style> 
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
  
<DIV class="title">게시판 목록</DIV>
 <div class="search">
 	<form method="POST" action="./list.jsp">
 		<select name="col">	<!-- 검색할 컬럼 -->
 			<option value="wname"
 			<% if(col.equals("wname")) out.print("selected='selected'"); %>
 			>이름</option>
 			<option value="title"
 			<% if(col.equals("title")) out.print("selected='selected'"); %>
 			>제목</option>
 			<option value="content"
 			<% if(col.equals("content")) out.print("selected='selected'"); %>
 			>내용</option>
 			<option value="total">전체출력</option>
 		</select>
 		<input type="text" name="word" value="<%=word %>"> <!-- 검색어 -->
 		<input type="submit" value="검색">
 		<input type='button' value='등록' onclick="location.href='./createForm.jsp'">
 	</form>
 </div>
  <TABLE>
    <TR>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>성명</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>사진</TH>
      <TH>파일다운로드</TH>
    </TR>
<% if(list.size()==0) { %>
	<tr>
		<td colspan="8">등록된 글이 없습니다.</td>
	</tr>
<% } else { 
			while(iter.hasNext()) {
				dto = iter.next();
%>    
    <tr>
    	<td><%=dto.getNo() %></td>
    	<td>
    	<%
    		for(int i = 0; i < dto.getIndent(); i++) {
    			out.print("&nbsp;");
    		}   	
    		if(dto.getIndent() > 0) { %>
    		<img src="images/reply.JPG" >
    	<% } %><a href="javascript:read('<%=dto.getNo() %>')"><%=dto.getTitle() %></a>
    	<%if(Utility.compareDay(dto.getWdate().substring(0, 10))) { %>
    	<img src="images/new.gif">
    	<% } %>
    	</td>
    	<td><%=dto.getName() %></td>
    	<td><%=dto.getViewcnt() %></td>
    	<td><%=dto.getWdate().substring(0, 10) %></td>
    	<td>
  	<img src="./storage/<%=dto.getFilename() %>">
    	<td>
    	<%if(dto.getFilename()==null) {
    			out.print("파일 없음");
    		} else { %>
    			<a href="javascript:down('<%=dto.getFilename() %>')">
    			<span class='glyphicon glyphicon-download-alt'></span></a>
    	<% }%>    	  	
    	</td>
    </tr>
<% } // while - end
}	// if - end %> 
   
  </TABLE>
  
  <DIV class='bottom'>
    <%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
  </DIV>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
</html>