<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
td img {
	width: 15px;
}
</style>
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	if("${param.searchGbn}" != "") {
		$("#searchGbn").val("${param.searchGbn}");
	}

	reloadList();

	//글작성
	$("#addBtn").on("click", function() {
		$("#searchTxt").val($("#oldTxt").val());
		$("#actionForm").attr("action", "testABAdd");
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
		$("#oldTxt").val($("#searchTxt").val()); //검색어 유지
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

		$("#actionForm").attr("action", "testAB");
		$("#actionForm").submit();
	});
});

//데이터 취득
function reloadList() {
	var params = $("#actionForm").serialize(); //form의 데이터를 문자열로 반환
	//console.log(params);
	$.ajax({ //jquery의 ajax함수 호출
		url: "testABLists", //접속 주소
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

//목록그리기
function drawList(list) {
	var html ="";

	for (var data of list) {
		html += "<tr no=\""+ data.B_NO + "\">		";
	    html += "<td>" + data.B_NO + "</td>		";
	    html += "<td>";
	    html += data.B_TITLE;
	    if(data.B_FILE != null) {
	    	html += "<img src=\"resources/images/attach_icon.png\" />";
	    }
	    html += "</td>";
	    html += "<td>" + data.M_NM + "</td>		";
	    html += "<td>" + data.B_DT + "</td>		";
	    html += "<td>" + data.B_HIT + "</td>		";	
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
			<option value="0">제목</option>
			<option value="1">작성자</option>
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
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<div class="paging_wrap"></div>
</body>
</html>