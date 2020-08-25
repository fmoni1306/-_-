<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="resBoard.boardDAO"%>
<%@page import="resBoard.boardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/main.css" rel="stylesheet">
</head>
<body>
<div id="wrap">
<jsp:include page="../main/top.jsp"></jsp:include>
</div>
	<%
		int num = Integer.parseInt(request.getParameter("num")); // 글 번호 받기
	boardDTO dto = new boardDTO();
	boardDAO dao = new boardDAO();
	String id = (String) session.getAttribute("id"); // 아이디 세션값 받기 (조회수 증가를위해)

	dto.setNum(num); // dto에 저장
	dto.setId(id); // dto에 저장

	List<boardDTO> list = new ArrayList<boardDTO>();

	list = dao.imageContent(dto);
	%>
	<div class="clear">
		<table border="1">
			<%
				for (boardDTO board : list) {
			%>
			<tr>
				<th width="100"><%=dto.getId()%></th>
				<th width="200"><%=dto.getTime()%></th>
				<th width="100">조회수 :<%=dto.getReadcount()%></th>

			</tr>
			<tr>
				<th colspan="3"><%=dto.getSubject()%></th>
			</tr>
			<tr>
				<td colspan="3" width="200" height="200">
				<p> <%=dto.getContent()%></p>
				<img src="../../image/<%=dto.getImage()%>">
				</td>

			</tr>
			<%
				}
			%>
		</table>
		<%
			List<boardDTO> list2 = new ArrayList<boardDTO>();
		list2 = dao.imageCommentList(num);
		%>
		<table border="1">
			<tr>
				<th width="100">아이디</th>
				<th width="200">내용</th>
				<th width="200">등록날짜</th>
				<th>댓글 삭제</th>
			</tr>
			<%
				for (boardDTO com : list2) {
				String time = com.getTime().toString();
				String time2 = time.substring(0, time.lastIndexOf("."));
			%>
			<tr>
				<td><%=com.getId()%></td>
				<td><%=com.getComment()%></td>
				<td><%=time2%></td>
				<%
					if (id != null) {
					if (id.equals(com.getId())) {
				%>
				<td>
					<button type="button"
						onclick="location.href='../comment/imageCommentCheck.jsp?num=<%=num%>&comment=<%=com.getComment()%>'">댓글삭제</button>

				</td>
				<%
					}
				}
				%>
			</tr>
			<%
				}
			%>
		</table>
		<table border="1">
			<tr>
				<td width="400">
					<%
						if (id != null) {
					%>
					<form action="../comment/imageComment.jsp?num=<%=dto.getNum()%>"
						method="post">
						<div>
							<textarea rows="4" cols="40" name="comment"></textarea>
							<div id="btn" style="text-align: center;">
								<input type="submit" id="cm" value="댓글등록"
									onclick="location.href='../comment/imageComment.jsp'">
							</div>

							<%
								} else {
							%>
							<a href="../login/loginForm.jsp">로그인 해주세요</a>
							<%
								}
							%>
						</div>
					</form>
				</td>



			</tr>
		</table>
		<div id="button">
			<input type="button" value="이전글"
				onclick="location.href='imageContentList.jsp?num=<%=dto.getNum() - 1%>'">
			<input type="button" value="글목록"
				onclick="location.href='../about/about.jsp'"> <input
				type="button" value="다음글"
				onclick="location.href='imageContentList.jsp?num=<%=dto.getNum() + 1%>'">
			<%
				if (dto.getId() != null) {
				if (dto.getId().equals(id)) {
			%>
			<input type="button" value="글삭제"
				onclick="location.href='imageDeleteCheck.jsp?id=<%=id%>&num=<%=num%>'">
			<%
				}

			}
			%>
			<jsp:include page="../main/bottom.jsp"></jsp:include>
		</div>
	</div>
</body>