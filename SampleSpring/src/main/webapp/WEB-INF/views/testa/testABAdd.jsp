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
<script type="text/javascript"
		src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	CKEDITOR.replace("con", {
		resize_enabled : false, //resize_enabled : 마우스로 크기 조절하는거
		language : "ko",
		enterMode : "2" //enterMode : 엔터를 줄바꿈으로 쓰겠다.
	});

	//취소버튼
	$("#cancelBtn").on("click", function() {
		$("#backForm").submit();
	});

	//엔터키 폼 실행 차단
	$("#addForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) { //엔터키가 눌렸을 때
			return false; // form 실행 이벤트를 하지 않음
		}
	});

	//첨부파일버튼
	$("#fileBtn").on("click", function() {
		$("#att").click();
	});

	//첨부파일 선택 시
	$("#att").on("change", function() {
		//마지막 \에서 다음 글자부터 자르겠다 => 파일명만 나옴
		$("#filename").html($(this).val().substring($(this).val().lastIndexOf("\\") + 1));
	});


	//저장 버튼
	$("#addBtn").on("click", function() {
		//ck데이터 중에 con과 관련된 객체에서 데이터를 취득하여 textarea인 con에 값을 넣는다.
		$("#con").val(CKEDITOR.instances['con'].getData());

		if(checkVal("#title")) {
			alert("제목을 입력해주세요.");
			$("#title").focus();
		} else if(checkVal("#con")) {
			alert("내용을 입력해주세요.");
		} else {
			//위에서 필터처리 먼저 한 후 success, error처리
			var fileForm = $("#fileForm");

			fileForm.ajaxForm({
				success : function(res) {
					if(res.result == "SUCCESS") {
						//업로드 파일명 적용
						if(res.fileName.length > 0) { //업로드한 파일이 있는 경우
							$("#bFile").val(res.fileName[0]);
						}
						//글 저장
						var params = $("#addForm").serialize();

						$.ajax({
							url: "testABAdds",
							type: "post",
							dataType: "json",
							data: params,
							success: function(res) {
								if(res.result == "success") {
									location.href = "testABList";
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
<!-- 파일폼은 따로 만드는 걸 권장 -->
<form id="fileForm" name="fileForm" action="fileUploadAjax" method="post" enctype="multipart/form-data">
	<input type="file" name="att" id="att">
</form>
<form action="testABList" id="backForm" method="post">
	<input type="hidden" name="serachGbn" value="${param.searchGbn}">
	<input type="hidden" name="serachTxt" value="${param.searchTxt}">
	<input type="hidden" name="page" value="${param.page}">
</form>
<form action="#" id="addForm" method="post">
	제목<input type="text" id="title" name="title" /><br/>
	작성자 : ${sMNm}<input type="hidden" name="mno" value="${sMNo}" /><br/>
	<textarea rows="5" cols="5" id="con" name="con"></textarea><br/>
	첨부파일 : <input type="button" value="첨부파일선택" id="fileBtn" />
	<sapn id="filename"></sapn>
	<input type="hidden" name="bFile" id="bFile" /><!-- DB저장용 -->
</form>
<input type="button" value="저장" id="addBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>