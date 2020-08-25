<%@page import="mail.SendMail"%>
<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
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
		String mail = request.getParameter("mail");
	
	resDTO dto = new resDTO();
	resDAO dao = new resDAO();  
	
	dto.setMail(mail);
	int duplicate = dao.mailChecker(dto);

	if (duplicate == 0) {
	%>
	<script type="text/javascript">
		alert("이미 사용중인 이메일입니다.")
		close();
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("사용가능한 이메일.")
	</script>
	<input type="submit" value="인증번호 보내기" onclick="location.href='sendMail.jsp?mail=<%=mail%>'">
	<%
		}
	%>
</body>
</html>