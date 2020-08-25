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

<%
String id = (String)session.getAttribute("id");

if(id==null){
	%>
	<script type="text/javascript">
	alert("로그인을 해주세요");
	history.back();
	</script>
	<%
}

%>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
</div>
<form style="width: 500px;" action="writePro.jsp" method="post">
<table border="1">

<tr><td>글쓴이</td><td><input type="text" value="<%=id %>"  name="id"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>내용</td>
	<td><textarea style="overflow-x:hidden;overflow-y:auto" rows="20" cols="50" name="content" ></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>
<jsp:include page="../main/bottom.jsp"></jsp:include>

</form>
</body>
</html>