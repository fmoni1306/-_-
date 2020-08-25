<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
			<div>
	<form action="sendMail.jsp" method="post">
		<table border="1">
<tr><td><label>받는사람 <input type="text" name="to" readonly="readonly" value="fmoni1306@gmail.com"></label></td></tr>
<!-- <tr><td><label>보내는사람</label></td></tr> -->
<input type="hidden" value="fmoni1306@gmail.com" name="from">
<tr><td><label>제목 <input type="text" name="subject"></label></td></tr>		
<tr><td><label>이름 <input type="text" name="name"></label></td></tr>
<tr><td><label>번호 <input type="text" name="number" maxlength="11"></label></td></tr>
<tr><td><label>예약날짜<input type="date" name="date" ></label></td></tr> 
<tr><td><label>예약시간 <input type="time" name="time"></label></td></tr>
<tr><td><label>추가사항<input type="text" name="caution"></label></td></tr>
<tr><td><label>인원수 <select size="1" name="person">
		<option>1</option>
		<option>2</option>
		<option>3</option>
		<option>4</option>
		</select></label></td>
<tr><td><input type="submit" value="작성"></td></tr>
		</table>
	</form>
</div>
</div>
</div>
</body>
</html>