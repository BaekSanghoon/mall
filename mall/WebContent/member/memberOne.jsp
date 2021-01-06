<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	if (session.getAttribute("loginMemberEmail") == null) {
		response.sendRedirect(request.getContextPath()+"/member/login.jsp?loginRequired=true");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOne</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#searchProductSubmit").click(function() {
					console.log("started search product");
					
					if ($("#ProductName").val() == "") {
						alert("검색어를 입력하세요.");
						
						$("#ProductName").focus();
						return;
					}
					
					$("#searchProductForm").submit();
				});
			});
		</script>
</head>
<body>
<%
	String memberEmail = request.getParameter("memberEmail");

	Member paramMember = new Member();
	paramMember.setMemberEmail((String)(session.getAttribute("loginMemberEmail")));
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(paramMember);

%>
		<div class="container-lg mt-5 mb-4">

			<br>
			
			<form method="post" action="<%=request.getContextPath()%>/product/searchProduct.jsp" id="searchProductForm">
				<div class="row">
					<div class="col text-left align-middle">
						<h1 class="font-weight-bolder">
							<a class="text-reset text-decoration-none" href="<%=request.getContextPath()%>/index.jsp">Goodee Shop</a>
						</h1>
					</div>
					<div class="col d-flex align-items-center">
						<input class="form-control" type="text" name="productName" placeholder="이름으로 상품 검색" id="ProductName ">
					</div>
					<div class="col d-flex">
						<div class="row flex-fill">
							<div class="col-4 d-flex align-items-center">
								<button class="btn btn-info" type="submit" id="searchProductSubmit" >검색</button>	
							</div>
							
							<div class="col-8 text-right align-middle">
								<a class="btn" href="<%=request.getContextPath()%>/member/memberOne.jsp"><i class='fas fa-user-alt' style='font-size:36px'></i></a>
								<a class="btn" href="<%=request.getContextPath()%>/notice/noticeList.jsp"><i class='fas fas fa-file-alt' style='font-size:36px'></i></a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<!-- 네비게이션 표시 부분 -->
		<div class="container-fluid bg-dark py-2">
			<div class="container-lg text-right align-middle">
				<a class="text-light text-decoration-none ml-1" href="<%=request.getContextPath()%>/member/memberOne.jsp"><%=member.getMemberName() %>님</a>
				<a class="btn btn-sm btn-primary ml-1" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
			</div>
		</div>
		
		<!-- 네비게이션 아래 (컨텐츠) 표시 부분 -->
		<div class="container-lg mt-4 mb-5">
			<div class="container-lg mt-4 mb-5">
				<h2 class="font-weight-bolder">회원 정보</h2>
				
				<hr>
				
				<div class="d-inline-flex align-items-center">
					<h6><%=member.getMemberName() %> 님</h6>
					<a class="btn" href="<%=request.getContextPath()%>/member/editMemberName.jsp">
						<i class='fas fa-pen' style='font-size:20px'></i>
					</a>
				</div>
				
				<h6>가입일: <%=member.getMemberDate().replace(".0", "") %></h6>
				
				<div class="row mt-3">
					<div class="col">
						<a class="btn btn-primary btn-block p-5 mb-3" href="<%=request.getContextPath()%>/orders/myOrdersList.jsp">
							<i class='fas fa-file-invoice-dollar m-5' style='font-size:72px'></i><br><span style='font-size:18px'>내 주문목록</span>
						</a>
					</div>
					
					<div class="col">
						<a class="btn btn-warning btn-block p-5 mb-3" href="<%=request.getContextPath()%>/member/editMemberPw.jsp">
							<i class='fas fa-user-lock m-5' style='font-size:72px'></i><br><span style='font-size:18px'>비밀번호 변경</span>
						</a>
					</div>
					
					<div class="col">
						<a class="btn btn-danger btn-block p-5 mb-3" href="<%=request.getContextPath()%>/member/deleteMember.jsp">
							<i class='fas fa-user-slash m-5' style='font-size:72px'></i><br><span style='font-size:18px'>회원 탈퇴</span>
						</a>
					</div>
				</div>
			</div>
		</div>
</body>
</html>