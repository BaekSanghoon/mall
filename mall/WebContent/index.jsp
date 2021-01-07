<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="commons.*" %>
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
<%	request.setCharacterEncoding("UTF-8");

	Member paramMember = new Member();
	paramMember.setMemberEmail((String)(session.getAttribute("loginMemberEmail")));
	
	MemberDao memberDao = new MemberDao();
	Member member = memberDao.selectMemberOne(paramMember);
	
	ListPage categoryListPage = new ListPage();
	categoryListPage.setCurrentPage(1);
	categoryListPage.setRowPerPage(5);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList1 = categoryDao.selectCategoryList(categoryListPage);	//카테고리 이름 리스트
	ArrayList<Category> categoryList2 = categoryDao.selectCategoryCkList();	//카테고리 이미지 리스트

	ProductDao productDao = new ProductDao();
	ArrayList<Product> productList = productDao.selectProductList();
	
	int searchCategoryId = -1;
	if (request.getParameter("searchCategoryId") != null) {
		searchCategoryId = Integer.parseInt(request.getParameter("searchCategoryId"));
	}

%>
<body>
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
	<div class="row mt-3 mb-5"><!-- 전체카테고리 / 이미지 베너 -->
		<div class="col-3">
			<div class="d-flex flex-column">
				<%
				  for(Category c : categoryList1) {
				%>
				  <a class="btn btn-primary btn-lg btn-block m-2" href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>" ><%=c.getCategoryName() %></a>
				<%		
				  }
				%>
			</div>
		</div>
				
		<div class="col-1"></div>
				
			<!-- 추천 카테고리 이미지 링크 -->
		<span class="col-8 d-flex align-items-center text-reset text-decoration-none">
			<img class="img-fluid border" src="<%=request.getContextPath() %>/image/sh1.jpg">
		</span>
	</div>
	
	
	<%
		Calendar today = Calendar.getInstance();
	%>
	
	
	<!-- 카테고리별 추천상품 -->
	<div>
		<h3> 카테고리별 추천상품<span class="badge badge-primary"><%=today.get(Calendar.YEAR)%>.<%=today.get(Calendar.MONTH)+1%>.<%=today.get(Calendar.DAY_OF_MONTH)%></span> </h3>
	</div>
	<div class="row mt-4 mb-5">
			<%
		  		for(Category c : categoryList1) {
		  	%>
		  		<div class="col text-center align-middle">
		  			<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>"title="<%=c.getCategoryName()%>">
		  				<img class="img-fluid rounded-circle border w-100" src="/mall-admin/image/<%=c.getCategoryPic()%>">
		  			</a>
		  		</div>	
		  	<%		
		  		}
		  	%>
	</div>
	
	
	<div class="row">
		<div class="col my-2">
			<%
				String categoryClasses = "";
				if (searchCategoryId == -1) {
					categoryClasses = "btn btn-primary btn-block";
				} else {
					categoryClasses = "btn btn-secondary btn-block";
				}
			%>
			<a class="<%=categoryClasses%>" href="<%=request.getContextPath()%>/index.jsp">전체</a>
		</div>
		<%
			for (Category c : categoryList1) {
				categoryClasses = "";
				if (searchCategoryId == c.getCategoryId()) {
					categoryClasses = "btn btn-primary btn-block";
				} else {
					categoryClasses = "btn btn-secondary btn-block";
				}
		%>
				<!-- 혹여나 카테고리가 많아서 다음줄로 넘어간다 하더라도 세로 마진을 줌으로써 버튼이 따닥따닥 붙는 현상을 줄이려고 했습니다 -->
				<div class="col my-2">
					<a class="<%=categoryClasses%>" href="<%=request.getContextPath()%>/index.jsp?searchCategoryId=<%=c.getCategoryId()%>"><%=c.getCategoryName() %></a>
				</div>
		<%
			}
		%>
	</div>
	
	
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
		
			<div class="container-lg">
				<div class="d-flex">
					<div class="mr-4">
						<h6 class="font-weight-bolder">공지사항</h6>
					</div>
					
					<div class="mr-4 small font-weight-lighter">
						<ul>
							<%
								for (Notice n : noticeList) {
							%>
									<li><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeId=<%=n.getNoticeId()%>"><h4><%=n.getNoticeTitle() %></h4></a></li>
							<%
								}
							%>
							<li><a href="<%=request.getContextPath()%>/notice/noticeListAll.jsp" class="btn btn-info" role="button">[공지사항 전체보기]</a></li>
						</ul>
					</div>
				</div>
			</div>
			
		
	</div>
	</div>
</body>
</html>