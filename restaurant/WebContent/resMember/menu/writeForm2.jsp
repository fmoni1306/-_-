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
int num = Integer.parseInt(request.getParameter("num"));
int re_ref = Integer.parseInt(request.getParameter("re_ref"));
int re_lev = Integer.parseInt(request.getParameter("re_lev"));
int re_seq = Integer.parseInt(request.getParameter("re_seq"));


%>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
</div>
<form style="width: 500px;" action="reWritePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="re_ref" value="<%=re_ref%>">
<input type="hidden" name="re_lev" value="<%=re_lev%>">
<input type="hidden" name="re_seq" value="<%=re_seq%>">
<table border="1">

<tr><td>글쓴이</td><td><input type="text" value="<%=id %>"  name="id"></td></tr>
<tr><td>제목</td><td><input type="text" value="[답글]" name="subject"></td></tr>
<tr><td>내용</td>
	<td><textarea style="overflow-x:hidden;overflow-y:auto" rows="20" cols="50" name="content" ></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>
<jsp:include page="../main/bottom.jsp"></jsp:include>

</form>
</body>
</html>