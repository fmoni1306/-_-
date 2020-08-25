<%@page import="org.omg.CORBA.Current"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="grocery.groceryDTO"%>
<%@page import="grocery.groceryDAO"%>
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
	String imagePath = context.getRealPath("image");
	String imageName = request.getParameter("fileName");
	int size = 1 * 1024 * 1024;
	String fileName = "";
	MultipartRequest multi = new MultipartRequest(request, imagePath, size, "utf-8", new DefaultFileRenamePolicy());
	groceryDAO dao = new groceryDAO();
	groceryDTO dto = new groceryDTO();

	try {
		Enumeration files = multi.getFileNames();
		String file = (String) files.nextElement();
		fileName = multi.getFilesystemName(file);
	} catch (Exception e) {
		e.printStackTrace();
	}
	if (fileName != null) {
		ParameterBlock pb = new ParameterBlock();
		pb.add(imagePath + "/" + fileName);
		RenderedOp rOp = JAI.create("fileload", pb);

		BufferedImage bi = rOp.getAsBufferedImage();
		BufferedImage thumb = new BufferedImage(200, 200, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = thumb.createGraphics();
		g.drawImage(bi, 0, 0, 200, 200, null);
		File file = new File(imagePath + "/sm_" + fileName);
		ImageIO.write(thumb, "jpg", file);
	}

	String regPrice = "^[0-9]{1,}$";
	String price2 = multi.getParameter("price");
	if (!Pattern.matches(regPrice, price2)) {
	%>
	<script type="text/javascript">
		alert("가격에는 숫자만");
		history.back();
	</script>
	<%
		} else {
		String name = multi.getParameter("name");
		int price = Integer.parseInt(multi.getParameter("price"));
		Timestamp date = new Timestamp(System.currentTimeMillis());
		String content = multi.getParameter("content");
		dto.setName(name);
		dto.setPrice(price);
		dto.setContent(content);
		dto.setFileName(fileName);
		dto.setSmName("sm_" + fileName);
		dto.setDate(date);
		dto.setPath(imagePath);

		int count = dao.insertGrocery(dto);
	%>
	<%
		if (count > 0) {
	%>
	<script type="text/javascript">
		alert("글쓰기 완료");
		location.href = "../main/home.jsp"
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("글쓰기 실패");
		history.back();
	</script>
	<%
		}
	}
	%>

</body>
</html>