<%@page import="grocery.groceryDAO"%>
<%@page import="grocery.groceryDTO"%>
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
String fileName = request.getParameter("fileName");
String id = (String) session.getAttribute("id");
int num = Integer.parseInt(request.getParameter("num"));
groceryDTO dto = new groceryDTO();
groceryDAO dao = new groceryDAO();

int count = dao.cart(fileName, id, num);
if(count>0) {
	%>
	<script type="text/javascript">
	alert("장바구니에 추가 되었습니다.");
	history.back();
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("이미 존재 하는 물품 입니다.");
	history.back();
	</script>
	<%
}
%>
</body>
</html>