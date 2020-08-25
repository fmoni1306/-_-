<%@page import="org.omg.CORBA.Current"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
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
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String mail = request.getParameter("mail");
String birth = request.getParameter("birth");
String hnumber = request.getParameter("hnumber");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String extraAddress = request.getParameter("extraAddress");
String detailAddress = request.getParameter("detailAddress");
StringBuffer totalAddress = new StringBuffer();
String total = totalAddress.append(address).append(extraAddress).append(detailAddress).toString();
Timestamp time = new Timestamp(System.currentTimeMillis());
resDAO dao = new resDAO();
resDTO dto = new resDTO(); 


dto.setName(name);
dto.setBirth(birth);
dto.setId(id);
dto.setPass(pass);
dto.setMail(mail);
dto.setHnumber(hnumber);
dto.setAddress(total);
dto.setReg_date(time);
dto.setPostcode(postcode);


int insert = dao.insertRes(dto);

if(insert > 0){
	%>
	<script type="text/javascript">
	alert("회원가입이 되셨습니다")
	location.href = "../main/home.jsp";
	</script>
	<%
}else {
	%>
	<script type="text/javascript">
	alert("회원가입을 다시 시도해주세요")
	location.href = "insertForm.jsp"
	</script>
	<%
}


%>

</body>
</html>