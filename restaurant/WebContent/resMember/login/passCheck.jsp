<%@page import="java.util.regex.Pattern"%>
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
// DAO 를통한 비밀번호 체크
String pass = request.getParameter("pass");

resDTO dto = new resDTO(); 
resDAO dao = new resDAO();
dto.setPass(pass);
int count = dao.passcheck(dto);

if(count == 4){
	%>
	<script type="text/javascript">
	alert("안전한 비밀번호");
	</script>
	<%
}else if(count == 3){
	%>
	<script type="text/javascript">
	alert("보통의 비밀번호");
	close()
	</script>
	<%
}else if(count == 2){
	%>
	<script type="text/javascript">
	alert("추천하지않는 비밀번호");
	close()
	</script>
	<%
}else if(count == 1){
	%>
	<script type="text/javascript">
	alert("사용하지 못하는 비밀번호");
	close()
	</script>
	<%
}else if(count == -1){
	%>
	<script type="text/javascript">
	alert("한글은 쓸수 없습니다");
	close()
	</script>
	<%
}else if(count == 0){
	%>
	<script type="text/javascript">
	alert("비밀번호는 8 ~ 15자리를 입력 해주세요");
	close()
	</script>
	<%
	
}
// response.sendRedirect("insertForm");


%>
	

</body>
</html>