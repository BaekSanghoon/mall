<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
</head>
<body>
<%
	int categoryId = Integer.parseInt(request.getParameter("categoryId"));
	ProductDao productDao = new ProductDao();
	ArrayList<Product> productList = productDao.selectProductListByCategoryId(categoryId);
	
	CategoryDao categoryDao = new CategoryDao();
	// 전체 카테고리 목록
	ArrayList<Category> categoryList1 = categoryDao.selectCategoryList();
%>
<div class="container">
<div class="row"  style="margin : 10px;"> <!-- 헤더 goodee shop / 검색바 -->
		<div class="col-sm-4 font-weight-bold"><h2><a class="text-dark"  style="text-decoration : none;" href="<%=request.getContextPath()%>/index.jsp">Goodee Shop</a></h2></div>
		<div class="col">
			<form method="post" action="<%=request.getContextPath()%>/product/searchProduct.jsp">
				<table>
					<tr>
						<td width="400px">
							<input class="form-control" type="text" name="productName">
						</td>
						<td width="100px">
							<button class="btn btn-info" type="submit">검색</button>	
						</td>
					</tr>
				</table>	
			</form>
		</div>
		<div class="col-sm-3">
		<%
			if(session.getAttribute("loginMemberEmail") == null){ //로그인 상태가 아닐 경우 아이콘을 누르면 로그인 페이지로 넘어가기
		%>
				<a class="text-dark" href="<%=request.getContextPath()%>/member/login.jsp"><i class='fas fa-user' style='font-size: 36px'></i></a>	
		<%
			}else{ // 로그인 상태라면 주문내역으로 넘어가기
		%>
				<a class="text-dark" href="<%=request.getContextPath()%>/orders/myOrdersList.jsp"><i class='fas fa-user' style='font-size: 36px'></i></a>	
		<%
			}
		%>			
		</div>
	</div>
	
	<div> <!-- 로그인/회원가입 메뉴바 -->
		<nav class="navbar navbar-expand-sm bg-dark">
			<ul class="navbar-nav mr-auto"></ul>
		<% 
			if(session.getAttribute("loginMemberEmail") == null){
		%>
				<!-- 로그아웃 상태 -->
				<ul class="navbar-nav mr-right">
					<li class="nav-iten"><a class="nav-link btn btn-primary brn-sm" href="<%=request.getContextPath()%>/member/login.jsp">로그인</a></li>
					&nbsp;
					<li class="nav-iten"><a class="nav-link btn btn-light btn-sm" href="<%=request.getContextPath()%>/member/signup.jsp">회원가입</a></li>
				</ul>
		<%
			}else{
		%>
				<!-- 로그인 상태 -->
				<ul class="navbar-nav mr-right">
					<li class="nav-iten"><a class="nav-link btn btn-danger btn-sm" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a></li>
					&nbsp;
					<li class="nav-iten"><a class="nav-link btn btn-light btn-sm" href="<%=request.getContextPath()%>/member/memberOne.jsp">회원정보</a></li>
				</ul>
		<%
			}
		
		%>
	</div>
	
	<div class="jumbotron">
	<h1>상품 목록</h1>
	</div>
	<!-- 카테고리별 상품목록 출력(카드css 사용) -->
	<div class="container">
	<div class="row">
	<table width="100%">
			<tr>		
		<%
			for(Category c : categoryList1){
		%>

				<td>
					<a href="<%=request.getContextPath()%>/product/productList.jsp?categoryId=<%=c.getCategoryId()%>" class="btn btn-secondary nav-link"><%=c.getCategoryName()%></a>
				</td>
				<td>&nbsp;</td>
		<%
			}
		%>
			</tr>		
	</table>
	</div>
	<div style="margin: 10px;"></div>
	<table class="table table-border">
		<tr>
			<%
				int i = 0;
				for(Product p : productList){
					i=i+1;
			%>
					<td>
						<div class="card" style="width:300px">
	  						<img class="card-img-top" src="/mall-admin/image/<%=p.getProductPic()%>" alt="Card image">
	  						<div class="card-body">
								<h5 class="card-title font-weight-bold">
									<a class="text-dark" href="<%=request.getContextPath()%>/product/productOne.jsp?productId=<%=p.getProductId()%>"><%=p.getProductName()%></a>
								</h5>
								<p class="card-text font-weitght-bold"><%=p.getProductPrice()%></p>
					 		</div>
						</div>
					</td>
			<%
					if(i%3==0){
			%>
						</tr><tr>
			<%
					}
				}
			%>
		</tr>
	</table>
	</div>
</div>
</body>
</html>