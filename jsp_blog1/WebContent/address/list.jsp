<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")) word="";
	
	// 페이징 관련
	int nowPage = 1;		// 현재 페이지, 변경가능
	if(request.getParameter("nowPage")!=null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;		// 한페이지당 보여줄 레코드 갯수
		
	// DB가져올 순번 생성
	int sno = ((nowPage - 1) * recordPerPage + 1);
	int eno = nowPage * recordPerPage;
		
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
		
	int total = adao.total(col, word);
	List<AddressDTO> list = adao.list(map);
	Iterator<AddressDTO> iter = list.iterator();
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
function read(no) {
	var url = "read.jsp";
	url += "?no=" + no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
function update(no) {
	var url = "updateForm.jsp";
	url += "?no=" + no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function del(no) {
	if(confirm("정말 삭제 하시겠습니까?")) {
		var url = "deleteProc.jsp";
		url += "?no=" + no;
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		location.href = url;
	}
}
</script>
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div>회원목록</div>
<div class="search">
	<form method="post" action="./list.jsp">
		<select name="col">
			<option value="name"
			<%if(col.equals("name")) out.print("selected='selected'"); %>
			>이름</option>
			<option value="phone"
			<%if(col.equals("phone")) out.print("selected='selected'"); %>
			>전화번호</option>
			<option value="zipcode"
			<%if(col.equals("zipcode")) out.print("selected='selected'"); %>
			>우편번호</option>
			<option value="total">전체출력</option>
		</select>
		<input type="text" name="word" value="<%=word %>">
		<input type="submit" value="검색">
		<input type="button" value="등록" onclick="location.href='./createForm.jsp'">
	</form>
</div>
<table>
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>등록날짜</th>
		<th>우편번호</th>
		<th>수정/삭제</th>
	</tr>
<%if(list.size()==0) { %>
	<tr>
		<td colspan="5">등록된 회원정보가 없습니다.</td>
	</tr>
<%} else {
		while(iter.hasNext()) {
			AddressDTO dto = iter.next();
%>
	<tr>
		<td><%=dto.getNo()%></td>
		<td><a href ="javascript:read('<%=dto.getNo()%>')"><%=dto.getName()%></a></td>
		<td><%=dto.getPhone()%></td>
		<td><%=dto.getWdate()%></td>
		<td><%=dto.getZipcode() %></td>
		<td><a href="javascript:update('<%=dto.getNo()%>')">수정</a>/
		<a href="javascript:del('<%=dto.getNo()%>')">삭제</a></td>
	</tr>
<%} 
}%>
</table>
<div>
	<%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>