<%@page import="mail.SendMail"%>
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
String mail =request.getParameter("mail");
int num = SendMail.gmailSend(mail);
%>

<script type="text/javascript">
function check() {
	var num = form1.code_check.value;
	var num2 = form1.code.value;
	if(num==num2){
		document.getElementById("checkCode").style.color ="blue";
		document.getElementById("checkCode").innerHTML ="인증되었습니다";
		makeReal();
	}
	if(num!=num2){
		document.getElementById("checkCode").style.color ="red";
		document.getElementById("checkCode").innerHTML ="인증번호가 틀렸습니다";
		makeNull();
	}
}

function makeReal() {
	var hi = document.getElementById("hi");
	hi.type ="submit";
}
function makeNull() {
	var hi = document.getElementById("hi");
	hi.type ="hidden";
}
function confirm() {
	var mail = document.getElementById("mail").value;
	alert("인증 완료 되셨습니다.");
	window.opener.fr.mail.value = mail;
	window.opener.fr.mail.readOnly =true;
	window.opener.fr.mailChecker.value = "checked"
	window.close();
}
</script>
<form id= "form1" action="mailcheck.jsp" method="post">
<input type="text" name = "code" maxlength="5" placeholder="인증번호를 입력하세요" onkeyup="check()">
<input type="hidden" name = "code_check" readonly value="<%=num%>">
<input type="hidden" id = "mail" value="<%=mail%>">
<div id="checkCode"></div>
<input id="hi" type="hidden" value="인증하기" onclick="confirm()">
</form>
</body>
</html>