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
	int num = Integer.parseInt(request.getParameter("num"));
	Timestamp time = new Timestamp(System.currentTimeMillis());
	boardDTO dto = new boardDTO();
	boardDAO dao = new boardDAO();
	
	dto.setId(id);
	dto.setComment(comment);
	dto.setTime(time);
	dto.setNum(num);
	
	
	if (comment.length() < 5) { %>
	<script type="text/javascript">
	alert("내용이 너무 짧습니다");
	history.back();
	</script>
	<%
		} else {

		int count = dao.imageComment(dto);

		if (count > 0) {
	%>
	<script type="text/javascript">
		alert("댓글 등록 완료")
		location.href="../content/imageContent.jsp?num=<%=num%>"
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