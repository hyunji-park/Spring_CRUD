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
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		$("#oldTxt").val($("#searchTxt").val());
		
		reloadList();
	});
	
	$("#pagingWrap").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		$("#searchTxt").val($("#oldTxt").val());
		
		reloadList();
	});
	
	$("#addBtn").on("click", function() {
		$("#searchTxt").val($("#oldTxt").val());
		$("#actionForm").attr("action", "testAMAdd");
		$("#actionForm").submit();
	});
	
	$("tbody").on("click", "tr", function() {
		$("#m_no").val($(this).attr("m_no"));
		$("#searchTxt").val($("#oldTxt").val());
		$("#actionForm").attr("action", "testAMDtl");
		$("#actionForm").submit();
	});

});

//데이터 취득
function reloadList() {
	var params = $("#actionForm").serialize(); //form의 데이터를 문자열로 반환
	//console.log(params);
	$.ajax({ //jquery의 ajax함수 호출
		url: "testAMListAjax", //접속 주소
		type: "post", //전송 방식
		dataType: "json", //받아올 데이터 형태
		data: params, //보낼 데이터(문자열 형태)
		success: function(res) { //성공(ajax통신 성공) 시 다음 함수 실행
			//console.log(res);
			drawList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error) { //실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list) {
		html += "<tr m_no=\"" + data.M_NO + "\"> ";
		html += "<td>" + data.M_NO + "</td>		";
		html += "<td>" + data.M_ID + "</td>		";
		html += "<td>" + data.M_NM + "</td>		";
		html += "<td>" + data.M_PHONE + "</td>	";
		html += "</tr>						";
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
		
		$("#pagingWrap").html(html);
}
</script>
</head>
<body>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="m_no" id="m_no" />
	<input type="hidden" name="page" id="page" value="${page}" />
	<select id="searchGbn" name="searchGbn">
		<option value="0">이름</option>
		<option value="1">아이디</option>
	</select>
	<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" />
	<input type="hidden" name="oldTxt" id="oldTxt" value="${param.searchTxt}"/>
	<input type="button" value="검색" id="searchBtn" />
	<input type="button" value="등록" id="addBtn" />
</form>
<table>
	<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>전화번호</th>
		</tr>
	</thead>
	<tbody></tbody>
</table>
<div id="pagingWrap"></div>
</body>
</html>