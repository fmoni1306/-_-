<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="grocery.groceryDTO"%>
<%@page import="grocery.groceryDAO"%>
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
<jsp:include page="../main/bottom.jsp"></jsp:include>
<%
groceryDAO dao = new groceryDAO();
groceryDTO dto = new groceryDTO();
String id = (String)session.getAttribute("id");
List<groceryDTO> list = new ArrayList<groceryDTO>();

int maxNum = 0;
// 한페이지 보여줄 글개수 설정
int pageSize=9;

// 현페이지 번호 가져오기
String pageNum = request.getParameter("pageNum");
String order = request.getParameter("order");
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
if(order==null){
	order="0";
}
int orderBy = Integer.parseInt(order);
%>
<a href="contact.jsp?order=1">낮은 가격순</a> | <a href="contact.jsp?order=2">높은 가격순</a> | <a href="contact.jsp?order=3">인기순</a>
<%

list = dao.getGlist(startRow, pageSize, orderBy);
int count = 0;
%>


<table id="" border="1">
	
<tr>

<%
for(groceryDTO board : list){
	if(count%3==0){
		%>
		</tr><tr>
		<%
	}
	String time = board.getDate().toString();
	String date = time.substring(0,time.indexOf(' '));
	int num = board.getPrice();
	DecimalFormat df = new DecimalFormat("￦#,###.#");
	maxNum=board.getMaxNum();
	
	%>
	<td>
	<%
	if(board.getFileName() == null){
		%>
		<img src="../../image/sm_noimg.gif" onclick="location.href='groceryContent.jsp?num=<%=board.getNum()%>'">
		<%
	}else{
		%>
		<img src="../../image/sm_<%=board.getFileName()%>" onclick="location.href='groceryContent.jsp?num=<%=board.getNum()%>'"> 
		<%
	}
	%>
	
<%-- 	<br>[<%=board.getNum()%>]  --%>
	<br>상품명 : <%=board.getName()+"<br>"%>
	가격 : <%=df.format(num) + "원 <br>" %> 
	<a href="../content/groceryContent.jsp?num=<%=board.getNum()%>"></a>
	조회수 : <%=board.getReadcount()+"<br>"%> 작성일 : <%=date%>
	</td>
	<%
	count++;
}

%>
</tr>
</table>

<%
//SELECT* from board order by num desc limit 시작행-1, 개수
//list = bdao.boardList(startRow, pageSize);
//전체 페이지 수 구하기
int pageCount = maxNum/pageSize+(maxNum%pageSize>0 ? 1 : 0);
//한화면에 보여지는 페이지개수
int pageBlock=10;
//시작하는 페이지 번호 구하기
//현페이지번호 currentPage 한화면페이지개수pageBlock   시작하는 페이지 =>
//1~10                   10                    1
//11~20                  10                    11
//21~30                  10                    21
int startPage = (currentPage-1)/pageBlock*pageBlock+1;  
//끝나는 페이지번호 구하기
int endPage =  startPage + pageBlock -1;
//끝나는 페이지 10 전체 페이지 5 일경우 5까지만 보이게
if(endPage > pageCount){
	endPage = pageCount;
}

if(startPage>pageBlock){
	%>
	<button onclick="location.href='contact.jsp?pageNum=<%=startPage-1%>'">이전</button>
	<%
}

for(int i = startPage ; i<=endPage; i++){
	%>
	<button onclick="location.href='contact.jsp?pageNum=<%=i%>'"><%=i %></button>
	<%
}
if(endPage < pageCount){
	%>
	<button onclick="location.href='contact.jsp?pageNum=<%=startPage+11%>'">다음</button><br>
	<%
}
%>
</div>
</div>
</body>
</html>