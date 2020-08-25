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
<script type="text/javascript">

</script>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
<div class="clear">
</div>
<%
resDTO dto = new resDTO();
resDAO dao = new resDAO();
boardDAO bdao = new boardDAO();
boardDTO bdto = new boardDTO();
String id = (String)session.getAttribute("id");
List<boardDTO> list = new ArrayList<boardDTO>();
int maxNum = 0;
// 한페이지 보여줄 글개수 설정
int pageSize=10;
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

// SELECT* from board order by num desc limit 시작행-1, 개수
list = bdao.boardList(startRow, pageSize);

%>
<div class="clear">
<table  id="boardlist" border="1">
<tr><th width="200">글번호</th><th width="200">글쓴이</th><th  width="300">글제목</th><th width="200">조회수</th><th width="200">등록일</th><th width="100">답글</th></tr>
<%
for(boardDTO board : list){
	String time = board.getTime().toString();
	String date = time.substring(0,time.indexOf(' '));
	maxNum=board.getMaxNum();
	%>
	<tr>
	<td><%=board.getNum()%></td>
	<td><%=board.getId()%></td>
	<td style="text-align: left;">
	<%
	int wid=0;
	if(board.getRe_lev()>0){
		wid = board.getRe_lev()*10;
		 %>
		 <img src="../images/level.gif" width="<%=wid%>" height="15">
		 <img src="../images/re.gif">
		 
		 <%
		}
		 %>
		
		<a href="../content/content.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>"><%=board.getSubject()%></a></td>
		<td><%=board.getReadcount()%></td>
		
	<td><%=date%></td>
	<%
// 	if(board.getRe_lev() ==0){
	%>
	<td><input class='btn' type="button" value="답글" onclick="location.href='writeForm2.jsp?num=<%=board.getNum()%>&pageNum=<%=pageNum%>&re_ref=<%=board.getRe_ref()%>&re_lev=<%=board.getRe_lev()%>&re_seq=<%=board.getRe_seq()%>'"></td>
	<%
// 	}
	%>
	</tr><%
}

%>
</table>
<%
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
	<button onclick="location.href='menu.jsp?pageNum=<%=startPage-1%>'">이전</button>
	<%
}

for(int i = startPage ; i<=endPage; i++){
	%>
	<button onclick="location.href='menu.jsp?pageNum=<%=i%>'"><%=i %></button>
	<%
}
if(endPage < pageCount){
	%>
	<button onclick="location.href='menu.jsp?pageNum=<%=startPage+11%>'">다음</button><br>
	<%
}
%>
<button onclick="location.href='writeForm.jsp'">글쓰기</button>
<form action="search.jsp" method="post">
<br><select name="search">
<option value="1">제목</option>
<option value="2">내용</option>
<option value="3">제목+내용</option>
<option value="4">글쓴이</option>
</select>
<input type="text" name="content">
<input type="submit" value="검색" onclick="location.href='search.jsp'">
</form>

</div>
<jsp:include page="../main/bottom.jsp"></jsp:include>
</div>
</div>
</body>
</html>