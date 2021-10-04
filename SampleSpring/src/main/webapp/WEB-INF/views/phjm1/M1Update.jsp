<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#att {
	display: none;
}

.hide_btn {
	display: none;
}
#img {
	width: 20%;
	height: 20%;
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
	/* $("#btn1").attr("onclick", function(){
		"$(this).text('do not click');"
	}); */

	$("#cancelBtn").on("click", function() {
		history.back();
	});

	$("#imgBtn").on("click", function() {
		$("#att").click();
		//$("#img").attr("src");
	});

	$("#att").on("change", function() {
		$("#fileName").html($(this).val().substring($(this).val().lastIndexOf("\\") + 1));
			var fileForm = $("#fileForm");

			fileForm.ajaxForm({
				success : function(res) {
					if(res.result == "SUCCESS") {
						//업로드 파일명 적용
						if(res.fileName.length > 0) { //업로드한 파일이 있는 경우
							$("#m_img").val(res.fileName[0]);
						}
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
	});

	$("#imgDelBtn").on("click", function() {
		$("#fileName").html(""); //사용자에게 보여지는 파일명
		$("#m_img").val(""); //DB에 올라갈 파일명
		$("#img").attr("src", "");
		$("#imgBtn").attr("class", ""); //첨부파일 선택 버튼 보이기
		$(this).remove(); //첨부파일 삭제 버튼 제거
	});

	$("#updateBtn").on("click", function() {
		if($("#m_pw").val() != "") { // 비밀번호를 변경할 경우
			if(checkVal("#ocpw")) { // 기존비밀번호 입력여부
				alert("기존 비밀번호를 입력해 주세요.");
				$("#ocpw").focus();
			} else if($("#opw").val() == $("#ocpw").val()) { // 실 비밀번호와 입력된 기존비밀번호 비교
				if(checkVal("#pwch")) {
					alert("비밀번호 확인을 입력해 주세요.");
					$("#pwch").focus();
				} else if($("#m_pw").val() != $("#pwch").val()) {
					alert("비밀번호 확인이 일치하지 않습니다.");
					$("#m_pw").val("");
					$("#pwch").val("");
					$("#m_pw").focus();
				} else if(checkVal("#m_nm")) {
					alert("이름을 입력해 주세요.");
					$("#m_nm").focus();
				} else {
					updateAjax();
				}
			} else { // 비교 결과 같지 않은 경우
				alert("기존 비밀번호가 일치하지 않습니다.");
				$("#ocpw").val("");
				$("#ocpw").focus();
			}
		} else if(checkVal("#m_nm")) {
				alert("이름을 입력해 주세요.");
				$("#m_nm").focus();
		} else {
				updateAjax();
		}
	});
});

function updateAjax(){
	var params = $("#updateForm").serialize();

	$.ajax({
		url: "M1CUDAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(res) {
			if(res.result == "success") {
				$("#updateForm").attr("action", "M1Dtl");
				$("#updateForm").submit();
			} else if(res.result == "failed") {
				alert("수정에 실패하였습니다.");
			} else {
				console.log(res);
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

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
<!-- 수정 안됨 : 수정의 경우 회원번호를 제공하지 않기에 수정중에 문제가 발생합니다. -->
<form id="fileForm" name="fileForm" action="fileUploadAjax" method="post" enctype="multipart/form-data">
	<input type="file" name="att" id="att">
</form>

<form action="#" id="updateForm" method="post">
	<input type="hidden" name="gbn" value="u" />
	<input type="hidden" name="serachGbn" value="${param.searchGbn}">
	<input type="hidden" name="serachTxt" value="${param.searchTxt}">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="m_no" value="${param.m_no}">
	회원번호 : ${data.M_NO}<br>
	아이디 : ${data.M_ID}<br>
	<input type="hidden" id="opw" value="${data.M_PW}" />
	기존 비밀번호 <input type="password" id="ocpw" /><br/>
	비밀번호 <input type="password" id="m_pw" name="m_pw" /><br/>
	비밀번호 확인 <input type="password" id="pwch" /><br/>
	이름 <input type="text" id="m_nm" name="m_nm" value="${data.M_NM}"/><br/>
	전화번호 <input type="text" id="m_phone" name="m_phone" value="${data.M_PHONE}"/><br/>
	첨부파일 :
	<c:choose>
		<c:when test="${!empty data.M_IMG}">
		<!-- 첨부파일이 있는 경우 버튼을 숨긴다. -->
			<input type="button" value="이미지파일선택" id="imgBtn" class="hide_btn"/>
		</c:when>
		<c:otherwise>
			<input type="button" value="이미지파일선택" id="imgBtn" />
		</c:otherwise>
	</c:choose>
	<c:set var="len" value="${fn:length(data.M_IMG)}"></c:set>
	<span id="fileName">${fn:substring(data.M_IMG, 20, len)}</span><!-- 현재 등록되어있는 파일명 -->
	<c:if test="${!empty data.M_IMG}">
		<input type="button" value="이미지파일삭제" id="imgDelBtn" />
	</c:if>
	<input type="hidden" name="m_img" id="m_img" value="${data.M_IMG}" /><br>
	<img id="img" src="resources/upload/${data.M_IMG}"/>
</form>
<!-- <button id="btn1" onclick="alert('fsdfsdf!');" onchange="alert('chagned!')">click</button> -->
<input type="button" value="수정" id="updateBtn" />
<input type="button" value="취소" id="cancelBtn" />
</body>
</html>