<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
			$(document).ready(function() {
				console.log("document ready");
				
				$("#searchProductSubmit").click(function() {
					console.log("started search product");
					
					if ($("#searchProductName").val() == "") {
						alert("검색어를 입력하세요.");
						
						$("#searchProductName").focus();
						return;
					}
					
					$("#searchProductForm").submit();
				});
			});
		</script>
</head>
<%	Member paramMember = new Member();
	paramMember.setMemberEmail((String)(session.getAttribute("loginMemberEmail")));
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(paramMember);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList1 = categoryDao.selectCategoryList();	//카테고리 이름 리스트
	ArrayList<Category> categoryList2 = categoryDao.selectCategoryCkList();	//카테고리 이미지 리스트
%>
<body>
		<div class="container-lg mt-5 mb-4">

			<br>
			
			<form method="post" action="<%=request.getContextPath()%>/product/productList.jsp" id="searchProductForm">
				<div class="row">
					<div class="col text-left align-middle">
						<h1 class="font-weight-bolder">
							<a class="text-reset text-decoration-none" href="<%=request.getContextPath()%>/index.jsp">Goodee Shop</a>
						</h1>
					</div>
					<div class="col d-flex align-items-center">
						<input class="form-control" type="text" name="searchProductName" placeholder="상품 검색" id="searchProductName">
					</div>
					<div class="col d-flex">
						<div class="row flex-fill">
							<div class="col-4 d-flex align-items-center">
								<button class="btn btn-dark btn-block" type="button" id="searchProductSubmit">검색</button>
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
		<div class="container-fluid bg-dark py-2"> <!-- 로그인 회원가입 메뉴바 -->
			<div class="container-lg text-right align-middle">
				<%
					if (session.getAttribute("loginMemberEmail") == null) {
				%>
						<a class="btn btn-sm btn-primary ml-1" href="<%=request.getContextPath()%>/member/login.jsp">로그인</a>
						<a class="btn btn-sm btn-light ml-1" href="<%=request.getContextPath()%>/member/signup.jsp">회원가입</a>
				<%
					} else {
				%>
						<a class="text-light text-decoration-none ml-1" href="<%=request.getContextPath()%>/member/memberOne.jsp"><%=member.getMemberName() %>님</a>
						<a class="btn btn-sm btn-primary ml-1" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
				<%
					}
				%>
			</div>
		</div>
<div class="container">

	 
	<div><!-- 전체카테고리 / 이미지 베너 -->
		<div class="row">
		  <div class="col-sm-3">
		  	<div class="btn-group-vertical">
		  	<%
		  		for(Category c : categoryList1) {
		  	%>
		  		<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>" style= " border-radius: 12px; width:285px; padding:10px ; " class="btn btn-primary btn-lg btn-block"><%=c.getCategoryName() %></a>
		  	<%		
		  		}
		  	%>
		  	</div>
		  </div>
		  <div class="col-sm-9">
		  	<img src="<%=request.getContextPath() %>/image/sh1.PNG">
		  </div>
		</div>
		
		<!-- 추천 카테고리 이미지 링크 -->
		<div>
			<%
		  		for(Category c : categoryList2) {
		  	%>
		  		<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>">
		  			<img class="rounded-circle" style="padding:15px;" src="<%=request.getContextPath()%>/image/<%=c.getCategoryPic()%>">		  			
		  		</a>
		  	<%		
		  		}
		  	%>
		</div>
	</div>
	<%
		Calendar today = Calendar.getInstance();
	%>
	<!-- 카테고리별 추천상품 -->
	<div>
		<h3> 카테고리별 추천상품<span class="badge badge-primary"><%=today.get(Calendar.YEAR)%>.<%=today.get(Calendar.MONTH)+1%>.<%=today.get(Calendar.DAY_OF_MONTH)%></span> </h3>
	</div>
	<div>
			<%
		  		for(Category c : categoryList1) {
		  	%>
		  		<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>"class="btn btn-primary"><%=c.getCategoryName() %></a>
		  	<%		
		  		}
		  	%>
	</div>
	<%
		ProductDao productDao = new ProductDao();
		ArrayList<Product> productList = productDao.selectProductList();
	%>
	<!-- 상품 목록 6 개 -->
	<table>
			<tr>
				<%
					int i = 0;
					for (Product p : productList) {
						i=i+1;
				%>
						<td>
							<div class="card" style="width: 400px">
								<img class="card-img-top" src="<%=request.getContextPath()%>/image/<%=p.getProductPic()%>">
								<div class="card-body">
									<h4 class="card-title"><a href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>"><%=p.getProductName()%></a></h4>
									<p class="card-text"><%=p.getProductPrice()%></p>
								</div>
							</div>
						</td>
				<%
						if(i%3==0) {
				%>
							</tr><tr>
				<%			
						}
					}
				%>
			</tr>
	</table>
	
	<!-- 최근 공지 2개 -->
	<div>
		<%
			NoticeDao noticeDao = new NoticeDao();
			ArrayList<Notice> noticeList = noticeDao.selectNoticeList();
		%>
		<div>
			<table class="table">
				<thead>
					<tr>
						<td>notice_id</td>
						<td>notice_title</td>
					</tr>
				</thead>
				<tbody>
					<%	
						for(Notice n : noticeList){
					%>	
					<tr>
						<td><%=n.getNoticeId() %></td>
						<td><a href= "<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId() %>" ><%=n.getNoticeTitle() %></a></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/notice/noticeListAll.jsp" class="btn btn-info" role="button">[공지사항 전체보기]</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	</div>
</body>
</html>