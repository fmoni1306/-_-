<%@page import="java.sql.Timestamp"%>
<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
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
	String id = (String)session.getAttribute("id");
	String comment = request.getParameter("comment");
	String secret = request.getParameter("secret");
	if(secret == null) {
		secret = "p";
	}
	
	
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	Timestamp time = new Timestamp(System.currentTimeMillis());
	boardDTO dto = new boardDTO();
	boardDAO dao = new boardDAO();
	
	dto.setId(id);
	dto.setComment(comment);
	dto.setTime(time);
	dto.setNum(num);
	
	if (comment.length() < 2) { %>
	<script type="text/javascript">
	alert("내용이 너무 짧습니다");
	history.back();
	</script>
	<%
		} else {

		int count = dao.boardComment(dto, secret);

		if (count > 0) {
	%>
	<script type="text/javascript">
		alert("댓글 등록 완료")
		location.href="../content/content.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
	</script>
	<%
		} else if(count == -1){
			%>
			<script type="text/javascript">
				alert("같은글에 댓글은 3개까지만 가능합니다")
				history.back();
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

</body>
</html>