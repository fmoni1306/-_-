<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");
	if (id != null) {
		session.invalidate();
	%>
	<script type="text/javascript">
		alert("로그아웃되셨습니다.")
		location.href = "../main/home.jsp"
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("로그인해주세요");
		location.href="loginForm.jsp"
	</script>
	<%
		}
	%>

</body>
</html>