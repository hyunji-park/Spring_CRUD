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
	
	$("#cancelBtn").on("Click", function() {
		$("$backForm").submit();
	});
	
	$("#addForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) { 
			return false;
		}
	});
	
	$("#addBtn").on("click", function() {
		$("#con").val(CKEDITOR.instances['con'].getData());
		if(checkVal("#title")) {
			alert("제목을 입력해주세요.");
			$("#title").focus();
		} else if(checkVal("#con")) {
			alert("내용을 입력해주세요.");
		} else {
			var params = $("#addForm").serialize();
			
			$.ajax({ 
				url: "testMAdds",
				type: "post",
				dataType: "json", 
				data: params,
				success: function(res) {
					if(res.result == "success") {
						location.href = "testMList";
					} else if(res.result == "failed") {
						alert("작성에 실패하였습니다.");
					} else {
						alert("작성 중 문제가 발생하였습니다.");
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
<form action="testMList" id="backForm" method="post">
	<input type="hidden" name="serachGbn" value="${param.searchGbn}"> 
	<input type="hidden" name="serachTxt" value="${param.searchTxt}"> 
	<input type="hidden" name="page" value="${param.page}"> 
</form>
<form action="#" id="addForm" method="post">
	제목<input type="text" id="title" name="title" />
	작성자 : ${sMNm}<input type="hidden" name="mno" value="${sMNo}" /><br/>
	<textarea rows="5" cols="5" id="con" name="con"></textarea>
</form>
<input type="button" value="저장" id="addBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>