<%@page import="resMember.resDTO"%>
<%@page import="resMember.resDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<%
String id = (String)session.getAttribute("id");
String pass = request.getParameter("pass");
resDAO dao = new resDAO();

boolean result = dao.memDelete(id,pass);
if(result) {
	session.invalidate();
	%>
	<script type="text/javascript">
	alert("회원탈퇴 성공")
	location.href = "../main/home.jsp"
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("아이디 또는 비밀번호 확인 해주세요.")
	history.back();
	</script>
	<%
}

%>
</div>
</div>
</body>
</html>