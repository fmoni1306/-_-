<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<header>
		<%
			String id = (String) session.getAttribute("id");
		if (id == null) {
		%>
		<div id="login">
			<a href="../login/loginForm.jsp">로그인</a> | <a
				href="../insert/insertForm.jsp">회원가입</a>
		</div>
		<%
			} else {
		%>
		<div id="login">
		<ul id="ul">
			<a  href="../login/logout.jsp">로그아웃</a>
			<li id="myPage"><a href="../main/myPage.jsp">마이페이지</a></li>
			<li id="update"><a  href="../update/updateForm.jsp">회원정보수정</a></li>
			<li id="delete"><a  href="../delete/deleteForm.jsp">회원탈퇴</a></li>
			<%
				if (id.equals("fmoni")) {
			%>
			<li id="mChange"><a href="../upload/menuUploadForm.jsp">메뉴수정</a></li>
			<li id="mChange"><a href="../contact/groForm.jsp">식품</a></li>
			<%
				}
			%>
			
			</ul>
		</div>
		<%
			}
		%>
		<div id="logo">
			<img src="../images/logo.png" width="250" height="200">
		</div>
		<nav id="top_menu">
			<ul>
				<li><a href="../main/home.jsp">HOME</a></li>
				<li><a href="../about/about.jsp">MENU</a></li>
				<li><a href="../menu/menu.jsp">BOARD</a></li>
				<li><a href="../reservation/reservation.jsp">RESERVATION</a></li>
				<li><a href="../contact/contact.jsp">CONTACT</a></li>
			</ul>
		</nav>
	</header>
</body>
</html>