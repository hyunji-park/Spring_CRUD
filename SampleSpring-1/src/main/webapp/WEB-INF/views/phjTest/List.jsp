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
	
	if("${page}" > "${pb.maxPcount}") {
		$("#page").val("${pb.maxPcount}");
		$("#searchForm").submit();
	}
	
	$("tbody").on("click","tr",function(){
	      $("#sell_no").val($(this).attr("sell_no"));
	      $("#dtlForm").submit();
	});
	
	$("#searchBtn").on("click", function() {
		$("#page").val("1");
		$("#searchForm").submit();
	});
	
	$("#addBtn").on("click", function() {
		location.href = "Add";
	});
	
	$("#pagingWrap").on("click", "span", function() {
		$("#searchTxt").val($("#oldTxt").val());
		$("#page").val($(this).attr("page"));
		$("#searchForm").submit();
	});
});
</script>
</head>
<body>
<form action="Dtl" id="dtlForm" method="post">
	<input type="hidden" name="sell_no" id="sell_no" />
	<input type="hidden" name="searchGbn" id="dtlGbn" value="${param.searchGbn}" />
	<input type="hidden" name="searchTxt" id="dtlTxt" value="${param.searchTxt}" />
	<input type="hidden" name="page" value="${param.page}" />
</form>
<form action="List" id="searchForm" method="post">
	<input type="hidden" name="page" id="page" value="${page}" />
	<select id="searchGbn" name="searchGbn">
		<option value="0">상품명</option>
		<option value="1">개수</option>
	</select>
	<input type="text" name="searchTxt" id="searchTxt" value="${param.searchTxt}" />
	<input type="hidden" name="oldTxt" id="oldTxt" value="${param.searchTxt}" />
	<input type="button" value="검색" id="searchBtn" />
	<input type="button" value="작성" id="addBtn" />
</form>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>개수</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr sell_no="${data.SELL_NO}">
				<td>${data.SELL_NO}</td>
				<td>${data.ITEM_NAME}</td>
				<td>${data.COUNT}</td>
				<td>${data.SELL_DT}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="pagingWrap">
	<span page="1">처음</span>
	<c:choose>
		<c:when test="${page eq 1}">
			<span page="1">이전</span>
		</c:when>
		<c:otherwise>
			<span page="${page - 1}">이전</span>
		</c:otherwise>
	</c:choose>
	<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
		<c:choose>
			<c:when test="${page eq i}">
				<span page="${i}"><b>${i}</b></span>
			</c:when>
			<c:otherwise>
				<span page="${i}">${i}</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>
		<c:when test="${page eq pb.maxPcount}">
			<span page="${pb.maxPcount}">다음</span>
		</c:when>
		<c:otherwise>
			<span page="${page + 1}">다음</span>
		</c:otherwise>
	</c:choose>
	<span page="${pb.maxPcount}">마지막</span>
</div>
</body>
</html>