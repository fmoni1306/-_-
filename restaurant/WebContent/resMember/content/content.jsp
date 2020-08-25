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
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<div id="wrap">
		<jsp:include page="../main/top.jsp"></jsp:include>

		<%
			int num = Integer.parseInt(request.getParameter("num")); // 글 번호 받기
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		boardDTO dto = new boardDTO();
		boardDAO dao = new boardDAO();
		String id = (String) session.getAttribute("id"); // 아이디 세션값 받기 (조회수 증가를위해)
		String secret = "s";
		dto.setNum(num); // dto에 저장
		dto.setId(id); // dto에 저장

		List<boardDTO> list = new ArrayList<boardDTO>();

		list = dao.boardContent(dto);
		int i = 0;
		int o = 0;
		%>
		<div class="clear">
			<table border="1">
				<%
					for (boardDTO board : list) {
				%>
		<tr>
					<th width="200"><%=dto.getId()%></th>
					<th width="200"><%=dto.getTime()%></th>
					<th width="200">조회수 :<%=dto.getReadcount()%></th>
		</tr>
		<tr>
					<th colspan="3"><%=dto.getSubject()%></th>
		</tr>
		<tr>
		<td colspan="3" width="200" height="200"><%=dto.getContent()%></td>
				</tr>
				<%
					}
				%>
			</table> <br>
			<%
				List<boardDTO> list2 = new ArrayList<boardDTO>();
			list2 = dao.commentList(num);
			%>
	
		<table border="1">
		<tr><th width="100">이름</th><th width="200">내용</th><th width="100">등록날짜</th><th width="100">삭제</th><th width="100">답글</th></tr>
	
		<%
		for (boardDTO com : list2) {
		i++;
	String time = com.getTime().toString();
	String time2 = time.substring(0, time.lastIndexOf("."));
	if (com.getSecret().equals("s")) {
		%>
		<tr id="secret<%=i%>"><th colspan="4">숨겨진 댓글입니다.</th><th><%
		if(id!=null){
			if (id.equals("fmoni") || id.equals(com.getId())) {
				%>
				 <input class = "btn" type="button" id="showS<%=i %>" value="비밀댓글보기">
				<%
			}
		}%></th></tr>
		<tr id="se<%=i%>">
<!-- 		<form  action="../comment/cofcPro.jsp" method="post"> -->
		<td id ="re-id<%=i %>" width="100"><%=com.getId() %></td>
		<td width="200"><%=com.getComment() %></td>
		<td width="100"><%=time2%></td>
		<td width="100"><%if(com.getId().equals(id)){%><input class="btn" type="button" value="삭제" onclick="location.href='../comment/commentCheck.jsp?num=<%=com.getNum()%>&comment=<%=com.getComment()%>'"><%} %></td>
		<td style="display:none;" id="comNum<%=i%>"><%=com.getComNum()%></td>
		<td>
			<input class="btn" id="reply<%=i%>" type="button" value="답글보기">
			</td>
		</tr>
		<%
		List<boardDTO> list3 = new ArrayList<boardDTO>();
		list3 = dao.cofcList(com.getComNum(), num);
		for(boardDTO bdto : list3){
			o ++;
			String time3 = bdto.getTime().toString();
			String time4 = time3.substring(0, time.lastIndexOf("."));
			%>
			<tr style="color: orange" id="re<%=o%>">
			<td width="100"><b style="font-size: 3em;">☞</b><%=bdto.getId() %></td>
			<td width="200"><%=bdto.getComment() %></td>
			<td width="100"><%=time4 %></td>
			<td width="100"><%if(bdto.getId().equals(id)){%><input class="btn" type="button" value="삭제" onclick="location.href='../comment/commentCheck.jsp?num=<%=bdto.getNum()%>&comment=<%=bdto.getComment()%>&comNum=<%=bdto.getComNum()%>'"><%} %></td>
<!-- 			<form style="width: 100px;" action="" method="post"> -->
<!-- 			</form> -->
			</tr>
			
			<script type="text/javascript">
			$('#re<%=o%>').hide();
			
			$(document).on('click', '#reply<%=i%>', function(){
				$('#re<%=o%>').toggle();
			});
			
			</script>
			
			<%
		}
		%>
		
		<tr  id="tx<%=i %>"><td colspan="4">
		
		<textarea id ="comment<%=i %>" style="float: left;" rows="2" cols="40" name="comment"></textarea>
		<input class="btn" type="submit" id="anw<%=i%>" value="미구현">
<!-- 		</form> -->
		<input  id="close<%=i %>" type="hidden" value="close">
		</td></tr>
		<%
		} else{
			%>
		<tr id="se">
<!-- 		<form action="../comment/cofcPro.jsp" method="post"> -->
		<td width="100"><%=com.getId() %></td>
		<td width="200"><%=com.getComment() %></td>
		<td width="100"><%=time2%></td>
		<td width="100"><%if(com.getId().equals(id)){%><input class="btn" type="button" value="삭제" onclick="location.href='../comment/commentCheck.jsp?num=<%=com.getNum()%>&comment=<%=com.getComment()%>'"><%} %></td>
		<td style="display:none;" id="comNum<%=i%>"><%=com.getComNum()%></td>
		<td>
		<input class="btn" type="button" id="reply<%=i%>" value="답글보기">
		
<!-- 		</form> -->
			</td>
			</tr>
		
		<%
		List<boardDTO> list3 = new ArrayList<boardDTO>();
		list3 = dao.cofcList(com.getComNum(), num);
		for(boardDTO bdto : list3){
			o ++;
			String time3 = bdto.getTime().toString();
			String time4 = time3.substring(0, time.lastIndexOf("."));
			%>
			<tr style="color: orange" id="re<%=o%>">
			<td width="100"><b style="font-size: 3em;">☞</b><%=bdto.getId() %></td>
			<td width="200"><%=bdto.getComment() %></td>
			<td width="100"><%=time4 %></td>
			<td width="100"><%if(bdto.getId().equals(id)){%><input class="btn" type="button" value="삭제" onclick="location.href='../comment/commentCheck.jsp?num=<%=bdto.getNum()%>&comment=<%=bdto.getComment()%>&comNum=<%=bdto.getComNum()%>'"><%} %></td>
<!-- 			<form style="width: 100px;" action="" method="post"> -->
<!-- 			</form> -->
			</tr>
			
			<script type="text/javascript">
			$('#re<%=o%>').hide();
			
			$(document).on('click', '#reply<%=i%>', function(){
				$('#re<%=o%>').toggle();
			});
			
			</script>
			
			<%
		}
		%>
		
		<tr  id="tx<%=i %>">
		<td colspan="4">
		<textarea id ="comment<%=i %>" style="float: left;" rows="2" cols="40" name="comment"></textarea>
		<input class="btn" type="submit" id="anw<%=i%>" value="답글달기">
<!-- 		</form> -->
		<input id="door<%=i %>" type="hidden" value="close">
		</td></tr>
			<%
		}
	
	%>
	<script type="text/javascript">
	$('#tx<%=i%>').hide();
	$('#anw<%=i%>').hide();
	$('#se<%=i%>').hide();
	
	$(document).on('click', '#showS<%=i%>', function(){
		$('#se<%=i%>').toggle();
		$('#secret<%=i%>').toggle();
		$('#showS<%=i%>').val('비밀댓글닫기');
	});
	$(document).on('click', '#reply<%=i%>', function(){
		$('#tx<%=i%>').toggle();
		$('#anw<%=i%>').toggle();
		
	});
	$(document).on('click', '#anw<%=i%>', function(){
		var num = '<%=num%>';
		var pageNum = '<%=pageNum%>';
<%-- 		alert($('#comNum<%=i%>').text()); --%>

		location.href = "../comment/cofcPro.jsp?comNum="+$('#comNum<%=i%>').text() + "&&comment=" +
		$('#comment<%=i%>').val() + "&&re_id=" +
		$('#re_id<%=i%>').text() + "&&num=" + num +"&&pageNum=" +pageNum;
		
	});
	</script>
	
	
	<%
	}
%>
</table>
<table>
				<tr>
	<td width="400">
<%
	if (id != null) {
%>
<form action="../comment/comment.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>" method="post">
<div>
								<textarea style="width: 600px;" rows="4" cols="40"
									name="comment"></textarea>
								<input type="checkbox" name="secret" value="<%=secret%>">
								비밀댓글
								<div id="btn" style="text-align: center;">
									<input type="submit" id="cm" value="댓글등록"
										onclick="location.href='../comment/comment?secret=<%=secret%>.jsp'">
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
				<input class="btn" type="button" value="이전글"
					onclick="location.href='contentList.jsp?num=<%=dto.getNum() - 1%>&pageNum=<%=pageNum%>'">
				<input class="btn" type="button" value="글목록"
					onclick="location.href='../menu/menu.jsp?pageNum=<%=pageNum%>'">
				<input class="btn" type="button" value="다음글"
					onclick="location.href='contentList.jsp?num=<%=dto.getNum() + 1%>&pageNum=<%=pageNum%>'">
				<%
					if (dto.getId() != null) {
					if (dto.getId().equals(id)) {
				%>
				<input class="btn" type="button" value="글삭제"
					onclick="location.href='contentCheck.jsp?id=<%=id%>&num=<%=num%>'">
				<%
					}

				}
				%>
				<jsp:include page="../main/bottom.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>