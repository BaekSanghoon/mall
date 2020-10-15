<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
		if($("#memberEmail").val() == "") {
			alert("memberEmail 입력")
			return;
		}else if($("#memberPw").val() == ""){
			alert("memberPw 입력")
			return;			
		}else if($("#memberName").val() == ""){
			alert("memberName 입력")
			return;			
		}
		//submit to action
		$("#signupForm").submit();
		});
	});
</script>
</head>
<body>
<div class="container">
<h1>회원 가입</h1>
<form action="<%=request.getContextPath()%>/member/signupAction.jsp" id="signupForm">
	<table class="table">
		<tr>
			<td>member_email</td>
			<td><input type="text"name="memberEmail" id="memberEmail"></td>
		</tr>
		<tr>
			<td>member_pw</td>
			<td><input type="password"name="memberPw" id="memberPw"></td>
		</tr>
		<tr>
			<td>member_name</td>
			<td><input type="text"name="memberName" id="memberName"></td>
		</tr>
	</table>
	<button type="button" id="btn">회원가입</button>
</form>
</div>
</body>
</html>