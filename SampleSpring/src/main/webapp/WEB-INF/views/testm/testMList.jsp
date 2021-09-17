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
	if("${param.searchGbn}" != "") {
		$("#searchGbn").val("${param.searchGbn}");
	}
	
	reloadList();
	
	$("#addBtn").on("click", function() {
		$("#searchTxt").val($("#oldTxt").val());
		$("#actionForm").attr("action", "testMAdd");
		$("#actionForm").submit();
	});
	
	//로그인
	$("#loginBtn").on("click", function() {
		location.href = "Login";
	});
	
	//로그아웃
	$("#logoutBtn").on("click", function() {
		location.href = "Logout";
	});

	$("#searchBtn").on("click", function() {
		$("#oldTxt").val($("#searchTxt").val()); 
		$("#page").val("1");
		reloadList();
	});
	$("#searchTxt").on("keypress", function() {
		if(event.keycode == 13) { //13=엔터키
			$("#searchBtn").click();
			return false;
		}
	});
	
	
	$(".paging_wrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		$("#searchTxt").val($("#oldTxt").val());
		reloadList();
	});
	
	$("tbody").on("click", "tr", function() {
		$("#no").val($(this).attr("no"));
		
		$("#actionForm").attr("action", "testMDtl");
		$("#actionForm").submit();
	});
});

function reloadList() {
	var params = $("#actionForm").serialize();
	$.ajax({ 
		url: "testMLists",
		type: "post",
		dataType: "json", 
		data: params, 
		success: function(res) { 
			drawList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawList(list) {
	var html ="";
	
	for (var data of list) {
		html += "<tr no=\""+ data.M_NO + "\">		";
	    html += "<td>" + data.M_NO + "</td>		";
	    html += "<td>" + data.M_ID + "</td>		";
	    html += "<td>" + data.M_NM + "</td>		";
	    html += "<td>" + data.M_PHONE + "</td>		";
	    html += "</tr>         ";

	}
	
	$("tbody").html(html);
}

function drawPaging(pb) {
	var html ="";
	
		html += "<span page=\"1\">처음</span>			";
		
		if($("#page").val() == "1") {
			html += "<span page=\"1\">이전</span>    ";
		} else {
			html += "<span page=\"" +($("#page").val() * 1 - 1) + "\">이전</span>    ";
		}
		
		for(var i = pb.startPcount; i <= pb.endPcount; i++) {
			if($("#page").val() == i) {
				html += "<span page=\"" + i + "\"><b>" + i + "</b></span>    ";
			} else {
				html += "<span page=\"" + i + "\">" + i + "</span>    ";
			}
		}
		
		if($("#page").val() == pb.maxPcount) {
			html += "<span page=\"" + pb.maxPcount + "\">다음</span>    ";
		} else {
			html += "<span page=\"" +($("#page").val() * 1 + 1) + "\">다음</span>    ";
		}
		
		html += "<span page=\"" + pb.maxPcount + "\">마지막</span>    ";
		
		$(".paging_wrap").html(html);
}
</script>
</head>
<body>
<div>
	<c:choose>
		<c:when test="${empty sMNo}">
			<input type="button" value="로그인" id="loginBtn" />
		</c:when>
		<c:otherwise>
			${sMNm}님 어서오세요.<input type="button" value="로그아웃" id="logoutBtn" />
		</c:otherwise>
	</c:choose>
</div>
<div>
	<form action="#" id="actionForm" method="post">
		<select name="searchGbn" id=searchGbn>
			<option value="0">이름</option>
			<option value="1">아이디</option>
		</select>
			<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}"/>
			<input type="hidden" id="oldTxt" value="${param.searchTxt}"/>
			<input type="hidden" name="page" id="page" value="${page}"/>
			<input type="hidden" name="no" id="no" />
			<input type="button" value="검색" id="searchBtn" />
			<c:if test="${!empty sMNo}">
				<input type="button" value="작성" id="addBtn" />
			</c:if>
	</form>
</div>
<div>
	<table>
		<thead>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<div class="paging_wrap"></div>
</body>
</html>