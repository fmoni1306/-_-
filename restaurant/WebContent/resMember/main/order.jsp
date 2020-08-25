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
String[] check = request.getParameterValues("check");
String oList = "";

for(int i = 0; i<check.length; i++) {
	oList += check[i]+"/";
}
groceryDAO dao = new groceryDAO();
int count = dao.order(oList, id);
if(count>0) {
	%>
	<script type="text/javascript">
	alert("주문 되었습니다.");
	history.back();
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("주문 실패");
	history.back();
	</script>
	<%
}
%>

</div>
</div>
</body>
</html>