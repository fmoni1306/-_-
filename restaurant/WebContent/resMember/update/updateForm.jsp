<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
var idRe = /^[0-9a-zA-Z]{0,15}$/;
var nameRe = /^[가-힣]{0,5}$/;
var hpRe = /^(010|011)\d{3,4}\d{4}$/;
var mailRe = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
var UpperReg = /[A-Z]/;
var LowerReg = /[a-z]/; 
var numReg = /[0-9]/;
var charReg = /[!@#$%]/;
var lengthReg = /^[A-Za-z0-9!@#$%]{8,15}$/;

function passCheck2(val) {

	
	if(val.length <8){
		document.getElementById('passCheck').innerHTML = "8 ~ 15 자리를 입력해주세요";
		document.getElementById('passCheck').style.color = "pink";
	}
	
	
	var a = 0;
	
	if(UpperReg.exec(val) !=null ){
		a+=1;
	}
	if(LowerReg.exec(val) !=null) {
		a+=1;
	}
	if(numReg.exec(val) !=null) {
		a+=1;
	}
	if(charReg.exec(val) !=null) {
		a+=1;
	}
	
	
	if(a==0 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 사용불가";
		document.getElementById('passCheck').style.color = "red";
		document.fr.passChecker.value = "notCheck";
	}
	if(a==1 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 미흡";
		document.getElementById('passCheck').style.color ="red";
		document.fr.passChecker.value = "checked";
	}
	if(a==2 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 보통";
		document.getElementById('passCheck').style.color ="orange";
		document.fr.passChecker.value = "checked";
	}
	if(a==3 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 높음";
		document.getElementById('passCheck').style.color ="blue";
		document.fr.passChecker.value = "checked";
	}
	if(a==4 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 매우높음";
		document.getElementById('passCheck').style.color ="green";
		document.fr.passChecker.value = "checked";
	}
}
function 전송2() {
	if(document.fr.passChecker.value!="checked"){
		alert("비밀번호를 확인 해주세요")
		return;
	}
	
	if(document.fr.pass2.value == "" || !(lengthReg.test(document.fr.pass2.value))) {
		alert("비밀번호를 확인해주세요")
		document.fr.pass2.focus();
		return ;
	}
	if(document.fr.pass2.value.length < 8 || document.fr.pass2.value.length > 15) {
		alert("비밀번호는 8~15자리로 입력 해주세요")
		document.fr.pass2.focus();
		return ;
	}
	
	if(isNaN(document.fr.number.value)){
		alert("연락처는 숫자만 입력 가능합니다.")
		return;
	}
	if(document.fr.number.value == "" || !(hpRe.test(document.fr.number.value))) {
		alert("연락처를 확인해주세요")
		document.fr.number.focus();
		return ;
	}
	document.fr.submit();
}
</script>
</head>
<body>

<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../main/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
</div>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

if(id==null){
	%>
	<script type="text/javascript">
	alert("비정상적인 접근"); // 실행안됨 jsp 코드가 먼저 실행되기때문
	location.href="home.jsp"
	</script>
	
	<%
}
resDTO dto = new resDTO();
resDAO dao = new resDAO();

dto = dao.updateCheck(id);
%>
<div class="clear">
<fieldset>
<form name="fr" action="updatePro.jsp" method="post">
<label>이름 <br> <input type="text" name="name" value="<%=dto.getName()%>" readonly></label> <br>
<label>아이디 <br> <input type="text" name="id" value= "<%=dto.getId()%>"readonly></label> <br>
<label>현재비밀번호<br><input type="password" name="pass" maxlength="15" style="ime-mode: disable;"></label> <br>
<label>새로운비밀번호<br><input type="password" name="pass2" maxlength="15" placeholder="8~15자리 입력" onkeydown="passCheck2(this.value)" > </label><br>
<div class ="check_font" id="passCheck"></div>
<input type="hidden" name="passChecker" value="notCheck">
<label>이메일 <br><input type="text" name="mail" value="<%=dto.getMail() %>" readonly></label> <br>
<label>연락처 <br><input type="text" name="number" value="<%=dto.getHnumber()%>"></label> <br><br>
<input type="button" value="회원정보수정" onclick="전송2()">
<input type="button" value="뒤로가기" onclick="location.href='home.jsp'">
</form>
</fieldset>
</div>
</body>
</html>