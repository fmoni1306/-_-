<%@page import="grocery.groceryDAO"%>
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
String filename =request.getParameter("filename");
String id = request.getParameter("id");
groceryDAO dao = new groceryDAO();

int count = dao.cartDelete(filename, id);
if(count > 0){
	%>
	<script type="text/javascript">
	alert("장바구니에서 제거 되었습니다");
	location.href="cartList.jsp";
	</script>
	<%
}
%>
</body>
</html>