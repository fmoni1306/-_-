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
<form action="menuUploadPro.jsp" method="post" enctype="multipart/form-data">
런치 메뉴<input type="file" name="파일1">
디너 메뉴<input type="file" name="파일2">
<input type="submit" value="업로드">
</form>

</body>
</html>