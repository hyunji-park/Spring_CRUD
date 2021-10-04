<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
img {
	width: 20%;
	height: 20%;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#listBtn").on("click", function() {
		$("#actionForm").attr("action", "M1List");
		$("#actionForm").submit();
	});

	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "M1Update");
		$("#actionForm").submit();
	});

	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			var params = $("#actionForm").serialize();

			$.ajax({
				url: "M1CUDAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res) {
					if(res.result == "success") {
						location.href = "M1List";
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
	<input type="hidden" name="gbn" value="d" />
	<input type="hidden" name="serachGbn" value="${param.searchGbn}">
	<input type="hidden" name="serachTxt" value="${param.searchTxt}">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="m_no" value="${param.m_no}">
</form>
회원번호 : ${data.M_NO}<br/>
아이디 : ${data.M_ID}<br/>
이름 : ${data.M_NM}<br/>
전화번호 : ${data.M_PHONE}<br/>
가입일 : ${data.M_JOIN}<br/>
<c:if test="${!empty data.M_IMG}">
<div>
	<c:set var="len" value="${fn:length(data.M_IMG)}"></c:set>
	첨부파일 :
	<a href="resources/upload/${fn:replace(fn:replace(data.M_IMG, '[', '%5B'), ']', '%5D')}"
		download="${fn:substring(data.M_IMG, 20, len)}">
	${fn:substring(data.M_IMG, 20, len)}
	</a><br>
	<img id="img" src="resources/upload/${data.M_IMG}"/>
</div>
</c:if>
<input type="button" value="목록으로" id="listBtn" />
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="삭제" id="deleteBtn" />
</body>
</html>