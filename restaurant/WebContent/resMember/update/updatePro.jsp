<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String number = request.getParameter("number");
String pass2 = request.getParameter("pass2");
resDTO dto = new resDTO();
resDAO dao = new resDAO();
dto.setId(id);
dto.setPass(pass);
dto.setPass2(pass2);
dto.setHnumber(number);

int count = dao.updateRes(dto);

switch(count) {
	case 0 : 
		%>
		<script type="text/javascript">
		alert("없는 아이디 입니다.")
		history.back();
		</script>
		<%
		break;
	case 1 :
		%>
		<script type="text/javascript">
		alert("정보가 수정 되었습니다")
		location.href="../main/home.jsp";
		</script>
		<%
		break;
	case -1 :
		%>
		<script type="text/javascript">
		alert("동일한 비밀번호는 사용할 수 없습니다.")
		history.back();
		</script>
		<%
		break;
	case -2 :
		%>
		<script type="text/javascript">
		alert("비밀번호가 틀렸습니다.")
		history.back();
		</script>
		<%
		break;
}
%>

</body>
</html>