<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#att {
	display: none;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
		src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#cancelBtn").on("click", function() {
		$("#backForm").submit();
	});
	
	//이미지파일버튼
	$("#imgBtn").on("click", function() {
		$("#att").click();
	});
	
	$("#att").on("change", function() {
		$("#fileName").html($(this).val().substring($(this).val().lastIndexOf("\\") + 1));
	});
	
	$("#m_id").on("change", function() {
		//Ajax
		var params = $("#addForm").serialize();
		
		$.ajax({ 
			url: "M1IdCheckAjax",
			type: "post",
			dataType: "json", 
			data: params,
			success: function(res) {
				if(res.cnt > 0) {
					$("#check").html("중복된 아이디가 있습니다.");
					$("#check").css("color", "red");
					$("#checkId").val("false");
				} else {
					$("#check").html("사용 가능한 아이디 입니다.");					
					$("#check").css("color", "green");
					$("#checkId").val("true");
				}
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
	
	$("#addBtn").on("click", function(){
		if(checkVal("#m_id")) {
			alert("아이디를 입력하세요.");
			$("#m_id").focus();
		} else if($("#checkId").val() == "false") {
			alert("아이디 중복 체크를 해주세요");
			$("#m_id").focus();
		} else if(checkVal("#m_pw")) {
			alert("비밀번호를 입력하세요.");
			$("#m_pw").focus();
		} else if(checkVal("#pwch")) {
			alert("비밀번호확인을 입력하세요.");
			$("#pwch").focus();
		} else if($("#m_pw").val() != $("#pwch").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#m_pw").val("");
			$("#pwch").val("");
			$("#m_pw").focus();
		} else if(checkVal("#m_nm")) {
			alert("이름을 입력하세요.");
			$("#m_nm").focus();
		} else {
			var fileForm = $("#fileForm");
			
			fileForm.ajaxForm({
				success : function(res) {
					if(res.result == "SUCCESS") {
						//업로드 파일명 적용
						if(res.fileName.length > 0) { //업로드한 파일이 있는 경우
							$("#m_img").val(res.fileName[0]);
						}
						//Ajax
						var params = $("#addForm").serialize();
						
						$.ajax({ 
							url: "M1CUDAjax", 
							type: "post",
							dataType: "json", 
							data: params,
							success: function(res) {
								if(res.result == "success") {
									location.href = "M1List";
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
					} else {
						alert("파일 업로드에 실패하였습니다.");
					}
				},
				error : function(reg, status, error) {
					console.log(error);
					alert("파일 업로드 중 문제가 발생하였습니다.");					
				}
			});
			fileForm.submit();
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
<form id="fileForm" name="fileForm" action="fileUploadAjax" method="post" enctype="multipart/form-data">
	<input type="file" name="att" id="att">
</form>
<form action="M1List" method="post" id="backForm">
	<input type="hidden" name="searchGbn" value="${param.searchGbn}">
	<input type="hidden" name="searchTxt" value="${param.searchTxt}">
	<input type="hidden" name="page" value="${param.page}">
</form>
<form action="#" id="addForm" method="post">
<input type="hidden" name="gbn" value="c" />
<input type="hidden" id="checkId" value="false" />
<!-- 아이디 자동중복체크(다음 입력폼으로 넘어가면 자동으로 됨) -->
아이디 <input type="text" id="m_id" name="m_id" /><span id="check"></span><br>
비밀번호 <input type="password" id="m_pw" name="m_pw" /><br>
비밀번호확인 <input type="password" id="pwch"/><br>
이름 <input type="text" id="m_nm" name="m_nm" /><br>
전화번호 <input type="text" id="m_phone" name="m_phone" /><br>
이미지파일 : <input type="button" value="이미지파일선택" id="imgBtn" />
<span id="fileName"></span>
<!-- <img alt="" src=""> -->
<input type="hidden" name="m_img" id="m_img" />
</form>
<input type="button" value="등록" id="addBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>