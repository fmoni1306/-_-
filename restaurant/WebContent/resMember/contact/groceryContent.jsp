<%@page import="grocery.groceryDAO"%>
<%@page import="grocery.groceryDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<jsp:include page="../main/top.jsp"></jsp:include>
</div>
	<%
		int num = Integer.parseInt(request.getParameter("num")); // 글 번호 받기
	groceryDTO dto = new groceryDTO();
	groceryDAO dao = new groceryDAO();
	String id = (String) session.getAttribute("id"); // 아이디 세션값 받기 (조회수 증가를위해)

	dto.setNum(num); // dto에 저장
	

	List<groceryDTO> list = new ArrayList<groceryDTO>();

	list = dao.groList(dto);
	%>
	<div class="clear">
		<table border="1">
			<%
				for (groceryDTO board : list) {
			%>
			<tr>
				<th width="100"><%=dto.getName()%></th>
				<th width="200"><%=dto.getDate()%></th>
				<th width="100">조회수 :<%=dto.getReadcount()%></th>

			</tr>
			<tr>
				<td colspan="3" width="200" height="200">
				<img src="../../image/<%=dto.getFileName()%>">
				<p> <%=dto.getContent()%></p>
				</td>

			</tr>
			<%
				}
			%>
		</table>
		
			<input type="button" value="글목록"
				onclick="location.href='../contact/contact.jsp'">
			
			<%
				if (id != null) {
					%><input type="button" value="장바구니 추가" onclick="location.href='../contact/cart.jsp?num=<%=num %>&fileName=<%=dto.getFileName()%>'"><%
				if (id.equals("fmoni")) {
			%>
			<input type="button" value="글삭제"
				onclick="location.href='groceryCheck.jsp?id=<%=id%>&num=<%=num%>'">
			<%
				}

			}
			%>
			<jsp:include page="../main/bottom.jsp"></jsp:include>
		</div>
</body>