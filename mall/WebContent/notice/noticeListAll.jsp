<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticeListAll</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<h1>공지사항 전체보기</h1>
<%
		request.setCharacterEncoding("utf-8");
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice>list = noticeDao.selectNoticeListAll();
%>
	<table class="table">
		<thead>
			<tr>
				<th>notice_id</th>
				<th>notice_title</th>
				<th>notice_content</th>
				<th>notice_date</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Notice n : list) {
		%>
			<tr>
				<td><%=n.getNoticeId() %></td>
				<td><a href= "<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId() %>" ><%=n.getNoticeTitle() %></a></td>
				<td><%=n.getNoticeContent() %></td>
				<td><%=n.getNoticeDate() %></td>
			</tr>
		<%
			}
		%>	
		</tbody>
	</table>

<div>

</div>
</div>

</body>
</html>