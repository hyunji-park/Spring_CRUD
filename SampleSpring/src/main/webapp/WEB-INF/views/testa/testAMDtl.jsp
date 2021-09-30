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
		$("#actionForm").attr("action", "testAMList");
		$("#actionForm").submit();
	});
	
	$("#updateBtn").on("click", function() {
		$("#actionForm").attr("action", "testAMUpdate");
		$("#actionForm").submit();
	});
	
	$("#deleteBtn").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			//Ajax
			var params = $("#actionForm").serialize();
			
			$.ajax({ 
				url: "testAMCUDAjax", 
				type: "post",
				dataType: "json", 
				data: params,
				success: function(res) {
					if(res.result == "success") {
						location.href = "testAMList";
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
	<input type="hidden" name="m_no" value="${param.m_no}" />
	<input type="hidden" name="searchGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" value="${param.searchTxt}" />
	<input type="hidden" name="page" value="${param.page}"/>
</form>
회원번호 : ${data.M_NO}<br/>
아이디 : ${data.M_ID}<br/>
이름 : ${data.M_NM}<br/>
전화번호 : ${data.M_PHONE}<br/>
가입일 : ${data.M_JOIN}<br/>
<input type="button" value="목록으로" id="listBtn" />
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="삭제" id="deleteBtn" />
</body>
</html>