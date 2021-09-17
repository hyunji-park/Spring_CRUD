<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		$("#actionForm").attr("action", "testMList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "testMUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			var params = $("#actionForm").serialize();
			
			$.ajax({ 
				url: "testMDeletes", 
				type: "post",
				dataType: "json", 
				data: params,
				success: function(res) {
					if(res.result == "success") {
						location.href = "testMList";
					} else if(res.result == "failed") {
						alert("탈퇴에 실패하였습니다.");
					} else {
						alert("탈퇴 중 문제가 발생하였습니다.");
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
	회원번호 : ${data.M_NO} 
</div>
<div>
	아이디 : ${data.M_ID} 
</div>
<div>
	이름 : ${data.M_NM} 
</div>
<div>
	전화번호 : ${data.M_PHONE} 
</div>
<c:if test="${data.M_NO eq sMNo}">
	<input type="button" value="수정" id="updateBtn">
	<input type="button" value="삭제" id="deleteBtn">
</c:if>
<input type="button" value="목록" id="listBtn">
</body>
</html>