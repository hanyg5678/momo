<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	  String root = request.getContextPath();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<script type="text/javascript">
function inputCheck(f) {
	if(f.id.value=="") {
		alert("아이디를 입력하세요.");
		f.id.focus();
		return false;
	}
	if(f.passwd.value=="") {
		alert("패스워드를 입력하세요.");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value=="") {
		alert("패스워드 확인을 입력해주세요.");
		f.repasswd.focus();
		return false;
	}
	if(f.passwd.value!=f.repasswd.value) {
		alert("패스워드가 일치하지 않습니다. 다시 입력해주세요.");
		f.passwd.focus();
		return false;
	}
	if(f.mname.value=="") {
		alert("이름을 입력해주세요.");
		f.mname.focus();
		return false;
	}
	if(f.email.value=="") {
		alert("이메일을 입력해주세요.");
		f.email.focus();
		return false;
	}
	if(f.job.value=="0") {
		alert("직업을 선택해주세요.");
		f.job.focus();
		return false;
	}
}
function idCheck(id) {
	if(id=="") {
		alert("아이디를 입력 해주세요");
		document.frm.id.focus();
	} else {
		var url = "id_Proc.jsp";
		url += "?id=" + id;

		var wr = window.open(url, "아이디 중복 확인", "width=500, height=500");
		wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);
	}	
}
function emailCheck(email) {
	if(email=="") {
		alert("이메일을 입력 해주세요");
		document.frm.email.focus();
	} else {
		var url = "email_Proc.jsp";
		url += "?email=" + email;
		
		var wr = window.open(url, "이메일 중복 확인", "width=500, height=500");
		wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);
	}
}
</script>
<link href="<%=root %>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
 
<DIV class="title">회원가입</DIV>
 
<FORM name='frm' 
		method='POST' 
		action='./prcreateProc.jsp'
		enctype="multipart/form-data"
		onsubmit="return inputCheck(this)"
		>
  <TABLE>
    <TR>
      <TH>사진</TH>
      <TD><input type="file" name="fname" accept=".jpg, .png, .gif"></TD>
   		<td>사진은 JPG, PNG, GIF파일만 올려주세요.</td>
    </TR>
    <TR>
      <TH>*아이디</TH>
      <TD><input type="text" name="id" size="15">
      <input type="button" value="ID중복확인" onclick="idCheck(document.frm.id.value)"></TD>
      <td>아이디를 적어주세요.</td>
    </TR>
    <TR>
      <TH>*패스워드</TH>
      <TD><input type="password" name="passwd" size="15"></TD>
      <td>패스워드를 적어주세요.</td>
    </TR>
    <TR>
      <TH>*패스워드 확인</TH>
      <TD><input type="password" name="repasswd" size="15"></TD>
      <td>패스워드를 확인합니다.</td>
    </TR>
    <TR>
      <TH>*이름</TH>
      <TD><input type="text" name="mname" size="15"></TD>
      <td>고객 실명을 적어주세요.</td>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><input type="text" name="tel" size="15"></TD>
      <td></td>
    </TR>
    <TR>
      <TH>*이메일</TH>
      <TD><input type="text" name="email" size="25">
      <input type="button" value="Email중복확인" onclick="emailCheck(document.frm.email.value)"></TD>
      <td>이메일을 적어주세요.</td>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><input type="text" name="zipcode" size="7" id="sample6_postcode" placeholder="우편번호">
      <input type="button" value="우편번호검색" onclick="sample6_execDaumPostcode()"></TD>
      <td>이메일을 적어주세요.</td>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
      <input type="text" name="address1" size="40"  id="sample6_address" placeholder="주소">
      <input type="text" name="address2" size="40"  id="sample6_address2" placeholder="상세주소"></TD>
      <td></td>
    </TR>
    <TR>
      <TH>*직업</TH>
      <TD>
      	<select name="job" >
      		<option value="0" selected>선택하세요</option>
      		<option value="A01">회사원</option>
      		<option value="A02">전산관련직</option>
      		<option value="A03">연구전문직</option>
      		<option value="A04">학생</option>
      		<option value="A05">자영업</option>
      		<option value="A06">공무원</option>
      		<option value="A07">의료인</option>
      		<option value="A08">법조인</option>
      		<option value="A09">종교/언론/예술인</option>
      		<option value="A10">기타</option>
      		<option value="A11">모모</option>
      	</select>
      </TD>
      <td>직업을 선택하세요.</td>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='회원가입'>
    <input type='reset' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>