<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
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
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
Timestamp time = new Timestamp(System.currentTimeMillis());

boardDAO dao = new boardDAO();
boardDTO dto = new boardDTO();

dto.setId(id);
dto.setSubject(subject);
dto.setContent(content);
dto.setTime(time);

int count = dao.boardInsert(dto);

if(count >0){
	%>
	<script type="text/javascript">
	alert("글쓰기 완료");
	location.href="menu.jsp"
	</script>
	<%
} else{
	%>
	<script type="text/javascript">
	alert("글쓰기 실패");
	history.back();
	</script>
	<%
}

%>

</body>
</html>