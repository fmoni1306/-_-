<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
<%@page import="java.sql.Timestamp"%>
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
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
String re_id = request.getParameter("re-id");
int comNum = Integer.parseInt(request.getParameter("comNum"));
String comment = request.getParameter("comment");
String secret = request.getParameter("secret");
if(secret == null) {secret = "p";}
int pageNum = Integer.parseInt(request.getParameter("pageNum"));
int num = Integer.parseInt(request.getParameter("num"));
Timestamp time = new Timestamp(System.currentTimeMillis());
boardDTO dto = new boardDTO();
boardDAO dao = new boardDAO();

dto.setId(id);
dto.setComment(comment);
dto.setTime(time);
dto.setNum(comNum);


if (comment.length() < 2) { %>
<script type="text/javascript">
alert("내용이 너무 짧습니다");
alert("<%=comment%>");
history.back();
</script>
<%
	} else {

	int count = dao.cofcInsert(dto, num);

	if (count > 0) {
%>
<script type="text/javascript">
	alert("댓글 등록 완료")
	location.href="../content/content.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
</script>
<%
	}else if(count <=0){
%>
<script type="text/javascript">
	alert("로그인 하세요")
	history.back();
</script>
<%
	}
}
%>

</div>
</div>
</body>
</html>