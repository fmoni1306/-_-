<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet">
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
String comment = request.getParameter("comment");
%>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<form id="loginForm" action="imageCommentDelete.jsp?num=<%=num %>&comment=<%=comment %>" method="post">
<label>아이디 <input type="text"  name="id"></label>
<label>패스워드 <input type="password"  name="pass"></label>
<input type="submit" value="삭제">
</form>
</div>
</div>
</body>
</html>