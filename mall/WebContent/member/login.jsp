<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#loginSubmit").click(function(){ // 폼 유효성 검사
			//console.log("버튼클릭");
		if($("#memberEmail").val().length<1) {
			alert("이메일을 입력해주세요");
			
			$("#memberEmail").focus();
			return;
		}else if($("#memberPw").val().length<1) {
			alert("pw를  확인해 주세요.");
			
			$("#memberPw").focus();
			return;
		}
		$("LoginForm").submit();
	});
});
</script>
</head>
<body>
<%
	if(session.getAttribute("loginMemberEmail")!=null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
%>
<div class="container" >
	<h2>로그인</h2>
	<form method="post" id="LoginForm" action="<%=request.getContextPath()%>/member/loginAction.jsp">
		<table class="table table-striped"	>
			<tr>
				<td>memberEmail</td>
				<td><input type="text"name="memberEmail"id="memberEmail"></td>
			</tr>
			<tr>
				<td>memberPw</td>
				<td><input type="text"name="memberPw"id="memberPw"></td>
			</tr>	
		</table>
		<button class="btn btn-info" type="submit" id="loginSubmit">로그인</button>
	</form>
</div>

</body>
</html>