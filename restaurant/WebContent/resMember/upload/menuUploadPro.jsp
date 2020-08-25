<%@page import="menu.menuDAO"%>
<%@page import="menu.menuDTO"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
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
		request.setCharacterEncoding("utf-8");
	Timestamp time = new Timestamp(System.currentTimeMillis());
	ServletContext context = request.getServletContext();
	String uploadPath = context.getRealPath("upload");
	String imageName = request.getParameter("fileName");
	int size = 10 * 1024 * 1024;
	String fileName1 = "";
	String fileName2 = "";
	MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
	menuDTO dto = new menuDTO();
	menuDAO dao = new menuDAO();

	try {
		Enumeration files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		fileName1 = multi.getFilesystemName(file1);
		String file2 = (String) files.nextElement();
		fileName2 = multi.getFilesystemName(file2);
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	dto.setFileName1(fileName1);
	dto.setFileName2(fileName2);

	int count = dao.menuUpload(dto);
	%>
	<%
		if (count > 0) {
	%>
	<script type="text/javascript">
		alert("업로드 완료");
		location.href = "../main/home.jsp"
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("업로드 실패");
		history.back();
	</script>
	<%
		}
	%>

</body>
</html>