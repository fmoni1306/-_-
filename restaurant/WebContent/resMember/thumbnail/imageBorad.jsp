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
<form action="thumbnail.jsp" method="post" enctype="multipart/form-data">
첨부 : <input type="file" name="fileName">
<input type="submit" value="전송">
</form>
</div>
</div>

</body>
</html>