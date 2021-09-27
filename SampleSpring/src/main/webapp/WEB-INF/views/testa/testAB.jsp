<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		$("#actionForm").attr("action", "testABList");
		$("#actionForm").submit();
	});

	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "testABUpdate");
		$("#actionForm").submit();
	});

	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			var params = $("#actionForm").serialize();

			$.ajax({
				url: "testABDeletes",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res) {
					if(res.result == "success") {
						location.href = "testABList";
					} else if(res.result == "failed") {
						alert("삭제에 실패하였습니다.");
					} else {
						alert("삭제 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
		}

	});
});
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="serachGbn" value="${param.searchGbn}">
	<input type="hidden" name="serachTxt" value="${param.searchTxt}">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="no" value="${param.no}">
</form>
<div>
	번호 : ${data.B_NO}
</div>
<div>
	제목 : ${data.B_TITLE}
</div>
<div>
	작성자 : ${data.M_NM}
</div>
<div>
	작성일 : ${data.B_DT}
</div>
<div>
	조회수 : ${data.B_HIT}
</div>
<div>
	내용<br/>
	${data.B_CON}
</div>
<c:if test="${!empty data.B_FILE}">
<div>
	<!-- c:set => 변수 선언 -->
	<!-- c:fn:length(값) => 문자열 : 문자열 길이, 리스트나 배열 : 개수 -->
	<c:set var="len" value="${fn:length(data.B_FILE)}"></c:set>
	첨부파일 :
	<!-- fn:substring(값, 숫자1, 숫자2) => 인덱스 숫자1번째부터 숫자2미만까지 자름 -->
	<!-- a의 download : href의 파일을 다운로드 하겠다. 만약 download에 값이 있는 경우 해당이름으로 다운로드 하겠다. -->
	<!-- replace가 core태그에 있는거라 한 번에 한 종류만 변경되서 두 번 씀. 정규식으로 쓰면 다름 -->
	<a href="resources/upload/${fn:replace(fn:replace(data.B_FILE, '[', '%5B'), ']', '%5D')}"
		download="${fn:substring(data.B_FILE, 20, len)}">
	${fn:substring(data.B_FILE, 20, len)}
	</a>
</div>
</c:if>
<c:if test="${data.M_NO eq sMNo}">
	<input type="button" value="수정" id="updateBtn">
	<input type="button" value="삭제" id="deleteBtn">
</c:if>
<input type="button" value="목록" id="listBtn">
</body>
</html>