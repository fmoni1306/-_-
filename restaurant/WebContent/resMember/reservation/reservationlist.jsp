<%@page import="reservation.rvDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="reservation.rvDAO"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<%
LocalDate date= LocalDate.now();
rvDAO dao = new rvDAO();
List<rvDTO> list = new ArrayList<rvDTO>();
list = dao.getReserveList();
%>
<table border="1">
<tr><th>이름</th><th>연락처</th><th>주의사항</th><th>예약날짜</th><th>인원수</th></tr>
<%
for(rvDTO dto : list){
	String day = dto.getDate().substring(0, dto.getDate().lastIndexOf('-'));
	if(day.equals(date.toString())){
		%>
		<tr><th><%=dto.getName() %></th><th><%=dto.getNumber() %></th><th><%=dto.getCaution() %></th><th><%=dto.getDate() %></th><th><%=dto.getPerson() %></th></tr>		
		<%
	}
}
%>
</table>
</div></div>
</body>
</html>