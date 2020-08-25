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
		String id = request.getParameter("id");
	resDTO dto = new resDTO();
	resDAO dao = new resDAO(); 
	
	dto.setId(id);
	int duplicate = dao.duplicate(dto);

	if (duplicate == 0) {
	%>
	<script type="text/javascript">
		alert("사용할 수 없는 아이디 입니다.")
		close();
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("사용 할 수 있는 아이디입니다.")
		close();
	</script>


	<%
		}
	%>

</body>
</html>