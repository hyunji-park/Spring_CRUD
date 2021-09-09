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
		if(checkVal("#item_name")) {
			alert("상품명을 입력하세요.");
			$("#item_name").focus();
		} else if(checkVal("#count")) {
			alert("개수를 입력하세요.");
			$("#count").focus();
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
<input type="hidden" name="sell_no" value="${data.SELL_NO}" />
번호 : ${data.SELL_NO}<br>
상품명 : <input type="text" id="item_name" name="item_name" value="${data.ITEM_NAME}" /><br>
개수 : <input type="text" id="count" name="count" value="${data.COUNT}" /><br>
작성일 : <input type="date" id="sell_dt" name="sell_dt" value="${data.SELL_DT}" /><br>
</form>
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>