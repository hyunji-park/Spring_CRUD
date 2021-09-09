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
		if(checkVal("#title")) {
			alert("제목을 입력하세요.");
			$("#title").focus();
		} else if(checkVal("#writer")) {
			alert("작성자를 입력하세요.");
			$("#writer").focus();
		} else if(checkVal("#con")) {
			alert("내용을 입력하세요.");
			$("#con").focus();
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
<form action="testUpdates" id="updateForm" method="post">
<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
<input type="hidden" name="page" value="${param.page}"/>
<input type="hidden" name="no" value="${data.NO}" />
번호 : ${data.NO}<br>
제목 <input type="text" id="title" name="title" value="${data.TITLE}" /><br>
작성자 <input type="text" id="writer" name="writer" value="${data.WRITER}" /><br>
내용 <br/>
<textarea rows="8" cols="40" id="con" name="con">${data.CON}</textarea>
</form>
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>