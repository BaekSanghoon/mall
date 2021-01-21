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
		$("#signupSubmit").click(function(){
		if($("#memberEmail").val() == "") {
			alert("memberEmail을 입력해주세요.");
			
			$("#memberEmail").focus();
			return;
		}else if($("#memberPw").val() == ""){
			alert("memberPw 입력해 주세요.");
			
			$("#memberPw").focus();
			return;			
		}else if($("#memberName").val() == ""){
			alert("memberName 입력해 주세요.");
			
			$("#memberName").focus();
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
<h2>회원 가입</h2>
<form  method="post" action="<%=request.getContextPath()%>/member/signupAction.jsp" id="signupForm">
	<table class="table table-striped">
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
	<button class="btn btn-info" type="submit" id="signupSubmit">회원가입</button>
</form>
</div>
</body>
</html>