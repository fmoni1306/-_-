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
<jsp:include page="../main/bottom.jsp"></jsp:include>
<%
String id = (String)session.getAttribute("id");
request.setCharacterEncoding("utf-8");
if(id==null){
	%>
	<script type="text/javascript">
	alert("로그인을 해주세요");
	history.back();
	</script>
	<%
}

%>
<form action="imagePro.jsp" method="post" enctype="multipart/form-data">
<table border="1">
<tr><td>글쓴이</td><td><input type="text" value="<%=id %>" readonly="readonly"  name="id"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" ></td></tr>
<tr><td>내용</td>
	<td><textarea style="overflow-x:hidden;overflow-y:auto" rows="50" cols="50"  name="content" ></textarea></td></tr>
<tr><td>첨부 </td><td> <input type="file" name="fileName"></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>
</form>
</div>
</div>
</body>
</html>