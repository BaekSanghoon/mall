<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>productOne.jsp</title>
</head>
<body>
	<div class="container">
	
	<%
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		System.out.println(noticeId+ "<--noticeId");
		NoticeDao noticeDao = new NoticeDao();
	  	Notice notice = noticeDao.selectNoticeOne(noticeId);
	%>
		<h1>공지사항 상세보기</h1>
		<table class="table">
			<tr>
				<td>notice_id</td>
				<td><%=notice.getNoticeId() %></td>
			</tr>
			<tr>
				<td>notice_title</td>
				<td><%=notice.getNoticeTitle() %></td>
			</tr>
			<tr>	
				<td>notice_content</td>
				<td><%=notice.getNoticeContent() %></td>
			</tr>
			<tr>
				<td>notice_date</td>
				<td><%=notice.getNoticeDate() %></td>
			</tr>			
			<tr>
				<td><a href ="<%=request.getContextPath()%>/index.jsp">[홈으로]</a></td>
				<td><a href ="<%=request.getContextPath()%>/notice/noticeListAll.jsp">[공지사항 전체보기]</a></td>
			</tr>
			
		</table>
	
	</div>
</body>
</html>