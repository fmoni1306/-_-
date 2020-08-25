<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
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
int num=Integer.parseInt(request.getParameter("num")); // 글 번호 받기
boardDTO dto = new boardDTO();
boardDAO dao = new boardDAO();

int last = dao.imageNum(num);
if(last == 0){
	%>
	<script type="text/javascript">
	alert("글이 없습니다.");
	history.back();
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	location.href="imageContent.jsp?num=<%=num%>";
	</script>
	<%
}
%>
</body>
</html>