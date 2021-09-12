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
$(document).ready(function(){
   $("#loginBtn").on("click", function() {
      if(checkVal("#m_id")) {
         alert("아이디를 입력해 주세요.");
         $("#m_id").focus();
      } else if(checkVal("#m_pw")) {
         alert("비밀번호를 입력해 주세요.");
         $("#m_pw").focus();
      } else {
         $("#loginForm").submit();
      }
   });
});
function checkVal(sel) { 
   if($.trim($(sel).val())=="") { 
      return true;
   } else {
      return false;
   }
}
</script>
</head>
<body>
<form action="Logins" id="loginForm" method="post">
아이디<input type="text" id="m_id" name="m_id" /></br/>
비밀번호<input type="password" id="m_pw" name="m_pw" />
</form>
<input type="button" value="로그인" id="loginBtn" />
</body>
</html>