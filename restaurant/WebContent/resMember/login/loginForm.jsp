<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 해주세요</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<form id="loginForm" action="loginPro.jsp" method="post">
<label>아이디  <input type="text" name="id"></label>
<label>비밀번호 <input type="password" name="password"></label>
<input type="submit" value="로그인" onclick="location.href='loginPro.jsp'">
</form>
</div>
<jsp:include page="../main/bottom.jsp"></jsp:include>
</div>
</body>
</html>