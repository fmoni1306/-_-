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
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<%
int num = Integer.parseInt(request.getParameter("num"));
String id = request.getParameter("id");
%>
<form action="imageDelete.jsp?num=<%=num %>&id=<%=id %>" method="post">
<label id= "id">아이디 <input type="text" id="id" name="id"></label>
<label id= "pa">패스워드 <input type="password" id="pa" name="pass"></label>
<input type="submit" value="삭제">
</form>
<jsp:include page="../main/bottom.jsp"></jsp:include>
</div>
</div>
</body>
</html>