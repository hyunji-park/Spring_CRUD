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
	$('#listBtn').on("click", function() {
		$("#actionForm").attr("action", "List");
		$("#actionForm").submit();
	});
	
	$('#updateBtn').on("click", function() {
		$("#actionForm").attr("action", "Update");
		$("#actionForm").submit();
	});
	
	$('#deleteBtn').on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			$("#actionForm").attr("action", "Delete");
			$("#actionForm").submit();
		}
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="sell_no" value="${param.sell_no}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
	<input type="hidden" name="page" value="${param.page}"/>
</form>
번호 : ${data.SELL_NO}<br/>
상품명 : ${data.ITEM_NAME}<br/>
개수 : ${data.COUNT}<br/>
작성일 : ${data.SELL_DT}<br/>
<input type="button" value="목록으로" id="listBtn" />
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="삭제" id="deleteBtn" />
</body>
</html>