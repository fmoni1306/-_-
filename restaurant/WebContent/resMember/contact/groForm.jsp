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
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
if(id==null){
	%>
	<script type="text/javascript">
	alert("로그인을 해주세요");
	history.back();
	</script>
	<%
}else {
	if(!id.equals("fmoni")){
		%>
		<script type="text/javascript">
		alert("접근 권한이 없습니다.");
		history.back();
		</script>
		<%
	}
}

%>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
<jsp:include page="../main/bottom.jsp"></jsp:include>
<form action="groPro.jsp" method="post" enctype="multipart/form-data">
<table border="1">
<tr><td>상품이름</td><td><input type="text" name="name" ></td></tr>
<tr><td>가격</td><td><input type="text" name="price"></td></tr>
<tr><td>상품설명</td>
	<td><textarea style="overflow-x:hidden;overflow-y:auto" rows="30" cols="50"  name="content" ></textarea></td></tr>
<tr><td>첨부 </td><td> <input type="file" name="fileName"></td></tr>
<tr><td colspan="2"><input type="submit" value="올리기"></td></tr>
</table>

</form>
</div>
</div>
</body>
</html>