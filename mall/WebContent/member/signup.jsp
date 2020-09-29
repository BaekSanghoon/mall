<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<h1>회원 가입</h1>
<form action="<%=request.getContextPath()%>/member/signupAction.jsp">
	<table class="table">
		<tr>
			<td>member_email</td>
			<td><input type="text"name="memberEmail"></td>
		</tr>
		<tr>
			<td>member_pw</td>
			<td><input type="password"name="memberPw"></td>
		</tr>
		<tr>
			<td>member_name</td>
			<td><input type="text"name="memberName"></td>
		</tr>
	</table>
	<button type="submit">회원가입</button>
</form>
</div>
</body>
</html>