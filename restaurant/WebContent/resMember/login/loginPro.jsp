<%@page import="resMember.resDTO"%>
<%@page import="resMember.resDAO"%>
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
String pass = request.getParameter("password");
resDAO dao = new resDAO(); 
resDTO dto = new resDTO();    

dto.setId(id);
dto.setPass(pass);
int check = 0;
check = dao.login(dto);

switch(check){
case 0 :  
	%>
	<script type="text/javascript">
	alert("비밀번호를 확인해주세요");
	history.back();
	</script>
	<%
	break;
case 1 :
	session.setAttribute("id", dto.getId());
	%>
	<script type="text/javascript">
	alert("<%=dto.getId()%>님 반갑습니다");
	location.href="../main/home.jsp";
	</script>
	<%
	break;
case -1 :  
	%>
	<script type="text/javascript">
	alert("없는 아이디 입니다");
	location.href="loginForm.jsp";
	</script>
	<%
}


%>

</body>
</html>