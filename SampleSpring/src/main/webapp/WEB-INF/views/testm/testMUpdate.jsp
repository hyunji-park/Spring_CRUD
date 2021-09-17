<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	CKEDITOR.replace("con", {
		resize_enabled : false,
		language : "ko",
		enterMode : "2" 
	});
	
	$("#cancelBtn").on("click", function() {
		$("#backForm").submit();
	});
	
	//엔터키 폼 실행 차단
	$("#updateForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) { //엔터키가 눌렸을 때
			return false; // form 실행 이벤트를 하지 않음
		}
	});
	
	$("#updateBtn").on("click", function() {
		$("#con").val(CKEDITOR.instances['con'].getData());
		if(checkVal("#title")) {
			alert("제목을 입력해주세요.");
			$("#title").focus();
		} else if(checkVal("#con")) {
			alert("내용을 입력해주세요.");
		} else {
			var params = $("#updateForm").serialize();
			
			$.ajax({ 
				url: "testMUpdates", 
				type: "post",
				dataType: "json", 
				data: params,
				success: function(res) {
					if(res.result == "success") {
						$("#backForm").submit();
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
<form action="testMDtl" id="backForm" method="post">
	<input type="hidden" name="serachGbn" value="${param.searchGbn}"> 
	<input type="hidden" name="serachTxt" value="${param.searchTxt}"> 
	<input type="hidden" name="page" value="${param.page}"> 
	<input type="hidden" name="no" value="${param.no}"> 
</form>
<form action="#" id="updateForm" method="post">
	회원번호 : ${data.M_NO}<br>
	아이디 : <input type="text" id="id" name="id" value="${data.M_ID}" /><br/>
	비밀번호 : <input type="text" id="pw" name="pw" value="${data.M_PW}" /><br/>
	이름 : <input type="text" id="nm" name="nm" value="${data.M_NM}" /><br/>
	전화번호 : <input type="number" id="phone" name="phone" value="${data.M_PHONE}" /><br/>
</form>
<input type="button" value="저장" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>