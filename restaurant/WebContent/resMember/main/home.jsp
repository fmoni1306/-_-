
<%@page import="java.util.List"%>
<%@page import="resBoard.boardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resBoard.boardDAO"%>
<%@page import="menu.menuDTO"%>
<%@page import="menu.menuDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="../js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.brown').click(function(){
		$('#cart').toggle();
	});
	
	$('#cart').hide();
	
	$('.brown').on('click',function(){
		
		$.getJSON('cart.jsp',function(data){
			$.each(data,function(index,item){
				$('#cart').append("<tr><td><img src=../../image/"+item.img+"></td><td>"+item.name+"</td></tr>");
				
			});
		});
		$('.brown').unbind();
	});
	
});
</script>
<link href="../css/main.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<div class="clear">
<jsp:include page="top.jsp"></jsp:include>
<div id="plate"><img src="../images/main.jpg" width="900" height="400"></div>
<%

menuDAO dao = new menuDAO();

menuDTO dto = dao.getMenu();

boardDTO bdto = new boardDTO();
boardDAO bdao = new boardDAO();
List<boardDTO> list = new ArrayList<boardDTO>();
int maxNum = 0;
//한페이지 보여줄 글개수 설정
int pageSize=5;

//현페이지 번호 가져오기
String pageNum = request.getParameter("pageNum");
//pageNum 파라미터값이 없으면 1페이지
if(pageNum==null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
//페이지번호 currentPage 한화면 보여줄 글 개수 pageSize => 시작하는 행번호
//     1                     10					1
//     2                     10					11
//     3                     10					21

//시작하는 행번호 구하기 - 알고리즘
int startRow = (currentPage*pageSize)-(pageSize-1);
//마지막 행번호 구하기 - 알고리즘
int endRow=currentPage*pageSize;

list = bdao.boardList(startRow, pageSize);
%>
<table id="cart" style="color:green; clear:both; border: 1px solid skyblue;" border="1">
</table>

<table style="color:green;  float: right; border: 1px solid skyblue;" border="1">
<tr><th colspan="3" width="50%">BOARD 최근글&nbsp;&nbsp;&nbsp; <a href="../menu/menu.jsp">more+</a></th></tr>
<tr><th>글번호</th><th>글쓴이</th><th>제목</th></tr>
<%
for(boardDTO bdto2 : list){
%>	
	<tr><td><%=bdto2.getNum() %></td><td><%=bdto2.getId() %></td><td><a href="../content/content.jsp?num=<%=bdto2.getNum()%>&pageNum=<%=pageNum%>"><%=bdto2.getSubject() %></a></td></tr>
	
	<%
}
list = bdao.imageBoardList(startRow, pageSize);
%>
</table>
<table style="color:skyblue;  float: left; border: 1px solid green;" border="1">
<tr><th colspan="3" width="50%">ABOUT 최근글&nbsp;&nbsp;&nbsp; <a href="../about/about.jsp">more+</a></th></tr>
<tr><th>글번호</th><th>글쓴이</th><th>제목</th></tr>
<%
for(boardDTO bdto2 : list){
%>	
	<tr><td><%=bdto2.getNum() %></td><td><%=bdto2.getId() %></td><td><a href="../content/imageContent.jsp?num=<%=bdto2.getNum()%>&pageNum=<%=pageNum%>"><%=bdto2.getSubject() %></a></td></tr>
	
	<%
}
%>
</table>
</div>
<div style ="float:none; clear: both;" id="download">
<img src="../images/menu1.png" onclick="location.href ='../upload/download.jsp?fileName=<%=dto.getFileName1()%>'">
<img src="../images/menu2.png" onclick="location.href ='../upload/download.jsp?fileName=<%=dto.getFileName2()%>'">
</div>
<input type="button" class="brown" value="물품목록">
<jsp:include page="bottom.jsp"></jsp:include>
</div>	
</body>
</html>