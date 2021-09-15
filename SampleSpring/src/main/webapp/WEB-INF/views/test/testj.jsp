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
var num = 1;
$(document).ready(function() {

	$("#add1Btn").on("click", function() {
		num++;
		
		var html = "";
		//"" : 문자열이 시작된다는 의미 -> 글자로 인식안됨 => 홑따옴표로 바꾸던지, 글자로 인식시키던지
		html += "<div>" + num + "<input type=\"button\" value=\"삭제\" class=\"delBtn\" /></div>";
		
		//append : 엔티티 뒷부분에 해당 내용을 추가한다.
		$(".wrap").append(html);
		
		//이 방법은 팝업 같은 경우에 사용함 
		/* $(".delBtn").off("click"); //기존 이벤트를 제거
		$(".delBtn").on("click", function() {
			$(this).parent().remove();
		}); */
	});
	
	$("#add2Btn").on("click", function() {
		num++;
		
		var html = "";
		
		html += "<div>" + num + "<input type=\"button\" value=\"삭제\" class=\"delBtn\" /></div>";
		
		//prepend : 엔티티 앞부분에 해당 내용을 추가한다.
		$(".wrap").prepend(html);
	});
	
	$("#changeBtn").on("click", function() {
		num++;
		
		var html = "";
		
		html += "<div>" + num + "<input type=\"button\" value=\"삭제\" class=\"delBtn\" /></div>";
		
		//html : 엔티티를 가져오거나 교체
		//html() : 엔티티를 가져옴
		//html(값) : 엔티티를 값으로 교체
		$(".wrap").html(html); //ex)게시판 내에서 일부 게시판 페이지 이동할 때 씀
		console.log($(".wrap").html());
	});
	
	/* $(".delBtn").on("click", function() { //div 한 개에만 delBtn할당해서 처음 한 번만 삭제되고 그 이후로 안됨 => 이벤트 주체를 항상 살아있는거로 준다.
		$(this).parent().remove();
	}); */
	
	//게시판에서 일반적인 이벤트 방법
	$(".wrap").on("click", ".delBtn", function() {
		$(this).parent().remove();
	});
	
	$("#resetBtn").on("click", function() {
		num = 0;
		//empty : 엔티티(부모, 자식요소 등)를 비운다
		$(".wrap").empty();
	});
});
</script>
</head>
<body>
<input type="button" value="추가1" id="add1Btn" />
<input type="button" value="추가2" id="add2Btn" />
<input type="button" value="교체" id="changeBtn" />
<input type="button" value="초기화" id="resetBtn" />
<div class="wrap">
	<div>1<input type="button" value="삭제" class="delBtn" /></div>
</div>
</body>
</html>