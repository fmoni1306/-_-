<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="resMember.resDTO"%>
<%@page import="resMember.resDAO"%>
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
request.setCharacterEncoding("utf-8");
resDAO dao = new resDAO();
resDTO dto = new resDTO();
String id = (String)session.getAttribute("id");

dto = dao.myPage(id); 
String day = dto.getReg_date().toString().substring(0, 10);
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
Date day2 = sdf1.parse(day);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd(EEEE)");
String date = sdf2.format(day2);
%>
<table border="1">
<tr><th>이름</th><td><%=dto.getName() %></td></tr>
<tr><th>아이디</th><td><%=dto.getId() %></td></tr>
<tr><th>생일</th><td><%=dto.getBirth() %></td></tr>
<tr><th>메일</th><td><%=dto.getMail() %></td></tr>
<tr><th>번호</th><td><%=dto.getHnumber() %></td></tr>
<tr><th>우편번호</th><td><%=dto.getPostcode() %></td></tr>
<tr><th>주소</th><td><%=dto.getAddress() %></td></tr>
<tr><th>가입날짜</th><td><%=date %></td></tr>
</table><br>
<button onclick="location.href='cartList.jsp'">장바구니</button>
</div>
</div>
</body>
</html>