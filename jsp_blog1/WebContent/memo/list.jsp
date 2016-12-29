<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
//--------------------검색관련---------------------------
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("total")) {
		word = "";
	}
	
	// 페이지 관련
	int nowPage = 1;		// 현재 페이지(변경가능해야 함)
	if(request.getParameter("nowPage")!=null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;
	
	// DB에서 읽어올 시작순번과 글순번 생성
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	List<MemoDTO> list = mdao.list(map);
	Iterator<MemoDTO> iter = list.iterator();
	int total = mdao.total(col, word);
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
	font-family: gulim; 
	font-size: 24px; 
} 
</style> 
<script type="text/javascript">
function read(memono) {
	var url = "read.jsp";
	url += "?memono=" + memono;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>
<meta charset="utf-8">
  <link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="container">
 	<form method="POST" action="./list.jsp">
 		<select name="col">	<!-- 검색할 컬럼 -->
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
 	<h2><span class="glyphicon glyphicon-th-list"></span> 메모 목록</h2>
<table class="table table-hover">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>
	<%	if(list.size()==0) {	%>
		<tr>
			<td colspan="4">등록된 메모가 없습니다.</td>
	</tr>
	<%} else {
			for(int i = 0; i < list.size(); i++) {
			MemoDTO dto = list.get(i);
			%>
		<tr>
			<td><%=dto.getMemono()%></td>
			<td><a href ="javascript:read('<%=dto.getMemono() %>')"><%=dto.getTitle()%></a></td>
			<td><%=dto.getWdate()%></td>
			<td><%=dto.getViewcnt()%></td>
		</tr>
	<% } // for-end
		} // if-end %>
</table>
</div>
<div>
<%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>