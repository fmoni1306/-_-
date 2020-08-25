<%@page import="grocery.groceryDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="grocery.groceryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet">
</head>
<body>
<div id="wrap">
<jsp:include page="top.jsp"></jsp:include>
<div class="clear">
<%
String id = (String)session.getAttribute("id");
groceryDAO dao = new groceryDAO();
List<groceryDTO> list = new ArrayList<groceryDTO>();
list = dao.cartList(id);

for(groceryDTO dto : list){
	%>
	
	<form action="order.jsp" method="post">
	<table>
	<tr>
	<td><input type="checkbox" name="check" value="<%=dto.getNum()%>"></td>
	<td><img src="../../image/<%=dto.getSmName()%>" onclick="location.href='../contact/groceryContent.jsp?num=<%=dto.getNum()%>'"></td>
	<td><%=dto.getName() %></td><td><%=dto.getPrice()+"원"%></td><td><input type="button" value="장바구니 제거" onclick="location.href='cartDelete.jsp?id=<%=id%>&filename=<%=dto.getFileName()%>'"></td></tr>
	</table>
		
	<%
}%>
<input type="submit" value="주문하기">
</form>
</div>
</div>
</body>
</html>