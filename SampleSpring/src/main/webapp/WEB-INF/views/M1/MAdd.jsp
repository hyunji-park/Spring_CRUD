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

	$("#addBtn").on("click", function(){
		if(checkVal("#m_id")) {
			alert("아이디를 입력하세요.")	
			$("#m_id").focus();
		} else if(checkVal("#m_pw")) {
			alert("비밀번호를 입력하세요.")
			$("#m_pw").focus();
		}else if(checkVal("#pwch")) {
			alert("비밀번호확인을 입력하세요.")
			$("#pwch").focus();
		} else if($("#pw").val() != $("#pwch").val()) {
			alert("비밀번호가 일치하지 않습니다.")
			$("#pw").val("");
			$("#pwch").val("");
			$("#pw").focus();
		} else if(checkVal("#m_nm")) {
			alert("이름을 입력하세요.")
			$("#m_nm").focus();
		} else if(checkVal("#m_phone")) {
			alert("전화번호을 입력하세요.")
			$("#m_phone").focus();
		} else {
			$("#addForm").submit();
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
<form action="MAdds" id="addForm" method="post">
아이디 <input type="text" id="m_id" name="m_id" /><br>
비밀번호 <input type="password" id="m_pw" name="m_pw" /><br>
비밀번호확인 <input type="password" id="pwch"/>
이름 <input type="text" id="m_nm" name="m_nm" /><br>
전화번호 <input type="text" id="m_phone" name="m_phone" /><br>
</form>
<input type="button" value="등록" id="addBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>