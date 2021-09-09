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
		if(checkVal("#item_name")) {
			alert("상품명을 입력하세요.");
			$("#item_name").focus();
		} else if(checkVal("#count")) {
			alert("개수를 입력하세요.");
			$("#count").focus();
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
<form action="Adds" id="addForm" method="post">
상품명 <input type="text" id="item_name" name="item_name" /><br>
개수 <input type="text" id="count" name="count" /><br>
</form>
<input type="button" value="저장" id="addBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>