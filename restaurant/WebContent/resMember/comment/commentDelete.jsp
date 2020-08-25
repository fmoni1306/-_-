<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
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
boardDTO dto = new boardDTO();
boardDAO dao = new boardDAO();

String id = request.getParameter("id");
String pass = request.getParameter("pass");
int num = Integer.parseInt(request.getParameter("num"));
String comment = request.getParameter("comment");
String pkNum = request.getParameter("comNum"); // 대댓글 삭제용 파라미터
if(pkNum!="0"){ //대댓글에서만 comNum 이 넘어옴
int comNum = Integer.parseInt(pkNum);
dto.setComNum(comNum);
}
dto.setId(id);
dto.setPass(pass);
dto.setComment(comment);
dto.setNum(num);




int count = dao.commentDelete(dto);

if(count >0 ){
	%>
	<script type="text/javascript">
	alert("댓글이 삭제 되었습니다.");
	location.href="../menu/menu.jsp?num=<%=num%>";
	</script>
	<%
} else if(count <0){
	%>
	<script type="text/javascript">
	alert("비밀번호를 확인해주세요");
	history.back();
	</script>
	<%
} else if(count ==-1){
	%>
	<script type="text/javascript">
	alert("아이디를 확인해주세요");
	history.back();
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("오류발생");
	history.back();
	</script>
	<%
}

%>
</body>
</html>