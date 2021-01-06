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