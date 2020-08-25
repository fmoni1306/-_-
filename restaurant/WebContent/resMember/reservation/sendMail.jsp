<%@page import="reservation.rvDAO"%>
<%@page import="reservation.rvDTO"%>
<%@page import="mail.SMTPAuthenticatior"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
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
request.setCharacterEncoding("utf-8");
 
String from = request.getParameter("from");
String to = request.getParameter("to");
String subject = request.getParameter("subject");
request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");
String number = request.getParameter("number");
int person = Integer.parseInt(request.getParameter("person"));
String date = request.getParameter("date") +"-"+request.getParameter("time");
String caution = request.getParameter("caution");
// 입력값 받음
 
Properties p = new Properties(); // 정보를 담을 객체
 
p.put("mail.smtp.host","smtp.gmail.com"); // SMTP
 
p.put("mail.smtp.port", "465"); // 또는 587
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465"); //또는 587
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
// SMTP 서버에 접속하기 위한 정보들
try{
 
	
    Authenticator auth = new SMTPAuthenticatior();
    Session ses = Session.getInstance(p, auth);
    ses.setDebug(true);
    
     
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
    msg.setSubject(subject); // 제목
    
    Address fromAddr = new InternetAddress(from);
    msg.setFrom(fromAddr); // 보내는 사람
    Address toAddr = new InternetAddress(to);
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
   
    msg.setContent(date+"예약이 있습니다", "text/html;charset=UTF-8"); // 내용과 인코딩
     
    Transport.send(msg); // 전송
} catch(Exception e){
    e.printStackTrace();
    out.println("<script>alert('Send Mail Failed..');history.back();</script>");
    // 오류 발생시 뒤로 돌아가도록
    return;
}
 
rvDTO dto = new rvDTO();
rvDAO dao = new rvDAO();

dto.setName(name);
dto.setNumber(number);
dto.setPerson(person);
dto.setCaution(caution);
dto.setDate(date);

int count =dao.reserveWrite(dto);
if(count >0){
	%>
	<script type="text/javascript">
	alert("예약완료")
	location.href="reservation.jsp"
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("예약실패")
	location.href="reservation.jsp"
	</script>
	<%
}
// 성공 시
%>

</body>
</html>