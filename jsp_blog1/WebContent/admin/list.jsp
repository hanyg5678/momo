<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	// 검색관련
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")) {
		word = "";
	}
	
	// 페이징 관련
	int nowPage = 1;
	int recordPerPage = 5;
	if(request.getParameter("nowPage")!=null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	// DB에서 가져올 순번
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage * recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = dao.total(col, word);
	List<MemberDTO> list = dao.list(map);
	Iterator<MemberDTO> iter = list.iterator();
	
	String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(id) {
	var url = "<%=root %>/member/read.jsp";
	url += "?id=" + id;
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
/* 검색 폼 */
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
 
<DIV class="title">회원목록</DIV>
<div class="search"> 
<FORM name='frm' method='POST' action='./list.jsp'>
<select name="col">
	<option value="mname" 
	<%if(col.equals("mname")) out.print("selected='selected'"); %>
	 >성명</option>
	<option value="email"
	<%if(col.equals("email")) out.print("selected='selected'"); %>
	>이메일</option>
	<option value="id"
	<%if(col.equals("id")) out.print("selected='selected'"); %>
	>ID</option>
	<option value="total">전체출력</option>
</select>
<input type="text" name="word" value='<%=word %>'>
<input type="submit" value="검색">
<input type="button" value="회원가입" onclick="location.href='./agreement.jsp'">
</FORM> 
</div>

<%
while(iter.hasNext()) {
	MemberDTO dto = iter.next();
%>
  <TABLE style="width: 80%;">
    <TR>
      <TD rowspan="5" width="30%">
      <img src='<%=root %>/member/storage/<%=dto.getFname() %>' style= "width:250px; height:200px;">
      </TD>
      <th width="20%">아이디</th>
      <TD width="50%">
      <a href="javascript:read('<%=dto.getId() %>')"><%=dto.getId() %></a></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <TR>
      <TH >전화번호</TH>
      <TD><%=dto.getTel() %></TD>
    </TR>
    <TR>
      <TH>이메일</TH>
      <TD><%=dto.getEmail() %></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD><%=dto.getAddress1() %>
      <%=Utility.checkNull(dto.getAddress2()) %></TD>
    </TR>
  </TABLE>
<% } %>
  <DIV class='bottom'>
    <%=paging %>
  </DIV>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>