<%@page import="grocery.groceryDTO"%>
<%@page import="grocery.groceryDAO"%>
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
String id = request.getParameter("id");
String pass = request.getParameter("pass");
int num = Integer.parseInt(request.getParameter("num"));


groceryDAO dao = new groceryDAO();



int count = dao.groceryDelete(num, id,pass);

switch(count) {
case 1 : %>
<script type="text/javascript"> 
alert("글이 삭제 되었습니다.");
location.href ="../contact/contact.jsp"
</script>
<%
break;
case 0 : %>
<script type="text/javascript"> 
alert("비밀번호를 확인 해주세요.");
history.back();
</script>
<%
break;
case -1 : %>
<script type="text/javascript"> 
alert("아이디를 확인 해주세요.");
history.back();
</script>
<%
}

%>
</body>
</html>