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

	$("#updateBtn").on("click", function() {
		if($("#m_pw").val() != "") { // 비밀번호를 변경할 경우
			if(checkVal("#ocpw")) { // 기존비밀번호 입력여부
				alert("기존 비밀번호를 입력해 주세요.");
				$("#ocpw").focus();
			} else if($("#opw").val() == $("#ocpw").val()) { // 실 비밀번호와 입력된 기존비밀번호 비교
				if(checkVal("#pwch")) {
					alert("비밀번호 확인을 입력해 주세요.");
					$("#pwch").focus();
				} else if($("#m_pw").val() != $("#pwch").val()) {
					alert("비밀번호 확인이 일치하지 않습니다.");
					$("#m_pw").val("");
					$("#pwch").val("");
					$("#m_pw").focus();
				} else if(checkVal("#m_nm")) {
					alert("이름을 입력해 주세요.");
					$("#m_nm").focus();
				} else {
					updateAjax();
				}
			} else { // 비교 결과 같지 않은 경우
				alert("기존 비밀번호가 일치하지 않습니다.");
				$("#ocpw").val("");
				$("#ocpw").focus();
			}
		} else if(checkVal("#m_nm")) {
				alert("이름을 입력해 주세요.");
				$("#m_nm").focus();
		} else {
			updateAjax();
		}	
	});
});

function updateAjax() {
	//Ajax
	var params = $("#updateForm").serialize();
	
	$.ajax({ 
		url: "testAMCUDAjax", 
		type: "post",
		dataType: "json", 
		data: params,
		success: function(res) {
			if(res.result == "success") {
				$("#updateForm").attr("action", "testAMDtl");
				$("#updateForm").submit();
			} else if(res.result == "failed") {
				alert("수정에 실패하였습니다.");
			} else {
				alert("수정 중 문제가 발생하였습니다.");
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

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
<form action="#" id="updateForm" method="post">
<input type="hidden" name="gbn" value="u" />
<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
<input type="hidden" name="page" value="${param.page}"/>
<input type="hidden" name="m_no" value="${param.m_no}" />
회원번호 : ${data.M_NO}<br>
아이디 : ${data.M_ID}<br>
<input type="hidden" id="opw" value="${data.M_PW}" /><br/>
기존 비밀번호 <input type="password" id="ocpw" /><br/>
비밀번호 <input type="password" id="m_pw" name="m_pw" /><br/>
비밀번호 확인 <input type="password" id="pwch" /><br/>
이름 <input type="text" id="m_nm" name="m_nm" value="${data.M_NM}"/><br/>
전화번호 <input type="text" id="m_phone" name="m_phone" value="${data.M_PHONE}"/> <br/>
</form>
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>