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
	$("#listBtn").on("click", function() {
	//$('#listBtn').on("click", function() { --""랑 '' 뭔 차이?
		$("#actionForm").attr("action", "testList");
		$("#actionForm").submit();
	});
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "testUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			$("#actionForm").attr("action", "testDelete");
			$("#actionForm").submit();
		}
	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="no" value="${param.no}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
	<input type="hidden" name="page" value="${param.page}"/>
</form>
번호 : ${data.NO}<br/>
제목 : ${data.TITLE}<br/>
작성자 : ${data.WRITER}<br/>
작성일 : ${data.DT}<br/>
내용<br/>
${data.CON}<br/>
<input type="button" value="목록으로" id="listBtn" />
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="삭제" id="deleteBtn" />
</body>
</html>