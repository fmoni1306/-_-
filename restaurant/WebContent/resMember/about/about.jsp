<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="resBoard.boardDTO"%>
<%@page import="resBoard.boardDAO"%>
<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
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
<div class="clear">
<jsp:include page="../main/top.jsp"></jsp:include>
<%
boardDAO bdao = new boardDAO();
boardDTO bdto = new boardDTO();
String id = (String)session.getAttribute("id");
List<boardDTO> list = new ArrayList<boardDTO>();

int maxNum = 0;
// 한페이지 보여줄 글개수 설정
int pageSize=20;

// 현페이지 번호 가져오기
String pageNum = request.getParameter("pageNum");
// pageNum 파라미터값이 없으면 1페이지
if(pageNum==null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
// 페이지번호 currentPage 한화면 보여줄 글 개수 pageSize => 시작하는 행번호
//        1                     10					1
//        2                     10					11
//        3                     10					21

// 시작하는 행번호 구하기 - 알고리즘
int startRow = (currentPage*pageSize)-(pageSize-1);
// 마지막 행번호 구하기 - 알고리즘
int endRow=currentPage*pageSize;

list = bdao.imageBoardList(startRow, pageSize);
int count = 0;

%>
<table id="">
	
<tr>

<%
for(boardDTO board : list){
	if(count%4==0){
		%>
		</tr><tr>
		<%
	}
	String time = board.getTime().toString();
	String date = time.substring(0,time.indexOf(' '));
	maxNum=board.getMaxNum();
	%>
	<td>
	<%
	if(board.getImage() == null){
		%>
		<img src="../../image/sm_noimg.gif" onclick="location.href='../content/imageContent.jsp?num=<%=board.getNum()%>'">
		<%
	}else{
		%>
		<img src="../../image/sm_<%=board.getImage()%>" onclick="location.href='../content/imageContent.jsp?num=<%=board.getNum()%>'"> 
		<%
	}
	%>
	
<%-- 	<br>[<%=board.getNum()%>]  --%>
	<br>작성자 : <%=board.getId()+"<br>"%>
	<a href="../content/imageContent.jsp?num=<%=board.getNum()%>"> 글제목 : <%=board.getSubject()+"<br>"%></a>
	조회수 : <%=board.getReadcount()+"<br>"%> 작성일 : <%=date%>
	</td>
	<%
	count++;
}
%>
</tr>
</table>
<%


// SELECT* from board order by num desc limit 시작행-1, 개수
// list = bdao.boardList(startRow, pageSize);
// 전체 페이지 수 구하기
int pageCount = maxNum/pageSize+(maxNum%pageSize>0 ? 1 : 0);
// 한화면에 보여지는 페이지개수
int pageBlock=10;
// 시작하는 페이지 번호 구하기
// 현페이지번호 currentPage 한화면페이지개수pageBlock   시작하는 페이지 =>
//   1~10                   10                    1
//   11~20                  10                    11
//   21~30                  10                    21
int startPage = (currentPage-1)/pageBlock*pageBlock+1;  
// 끝나는 페이지번호 구하기
int endPage =  startPage + pageBlock -1;
// 끝나는 페이지 10 전체 페이지 5 일경우 5까지만 보이게
if(endPage > pageCount){
	endPage = pageCount;
}
%>
<div id="menuButton">
<%
if(startPage>pageBlock){
	%>
	<button onclick="location.href='about.jsp?pageNum=<%=startPage-1%>'">이전</button>
	<%
}

for(int i = startPage ; i<=endPage; i++){
	%>
	<button onclick="location.href='about.jsp?pageNum=<%=i%>'"><%=i %></button>
	<%
}
if(endPage < pageCount){
	%>
	<button onclick="location.href='about.jsp?pageNum=<%=startPage+11%>'">다음</button><br>
	<%
}
%>

<%if(id!=null){
if(id.equals("fmoni")){ %>
<button onclick="location.href='imageForm.jsp'">글쓰기</button><%} }%>
<jsp:include page="../main/bottom.jsp"></jsp:include>
</div>
</div>
</div>
</body>
</html>