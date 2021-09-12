<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#cancelBtn").on("click", function(){
		history.back();
	});
	
	$("#updateBtn").on("click", function(){
		if(checkVal("#m_id")) {
			alert("아이디를 입력하세요.")	
			$("#m_id").focus();
		} else if(checkVal("#m_pw")) {
			alert("비밀번호를 입력하세요.")
			$("#m_pw").focus();
		} else if(checkVal("#m_nm")) {
			alert("이름을 입력하세요.")
			$("#m_nm").focus();
		} else if(checkVal("#m_phone")) {
			alert("전화번호을 입력하세요.")
			$("#m_phone").focus();
		} else {
			$("#updateForm").submit();
		}
	});
});

function checkVal(sel) {
	if($.trim($(sel).val()) == "") {
		return true;
	} else {
		return false;
	}
}
</script>
</head>
<body>
<form action="Updates" id="updateForm" method="post">
<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
<input type="hidden" name="page" value="${param.page}"/>
<input type="hidden" name="m_no" value="${data.m_no}" />
회원번호 : ${data.M_NO}<br>
아이디 : <input type="text" id="m_id" name="m_id" value="${data.M_ID}" /><br/>
비밀번호 : <input type="text" id="m_pw" name="m_pw" value="${data.M_PW}" /><br/>
이름 : <input type="text" id="m_nm" name="m_nm" value="${data.M_NM}" /><br/>
전화번호 : <input type="number" id="m_phone" name="m_phone" value="${data.M_PHONE}" /><br/>
</form>
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>