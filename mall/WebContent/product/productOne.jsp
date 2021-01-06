<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productOne</title>
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
	int productId = Integer.parseInt(request.getParameter("productId"));
	ProductDao productDao = new ProductDao();
	Product product = productDao.selectProductOne(productId);
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
<div class="container">
	<h1>상품 상세보기</h1>
	<form method="post" action="<%=request.getContextPath()%>/orders/addOrdersAction.jsp">
		<input type="hidden" value="<%=product.getProductId()%>" name="productId">
		<input type="hidden" value="<%=product.getProductPrice()%>" name="productPrice"> 
		<div>
			수량 : 
			<select name="ordersAmount">
				<%
					for(int i=1; i<11; i+=1) {
				%>
						<option value="<%=i%>"><%=i%></option>
				<%		
					}
				%>
			</select>개
		</div>
		<div>
			배송주소 :
			<input type="text" name="ordersAddr">
		</div>
		<div><button type="submit">주문</button></div>
	</form>
	<table class="table">
		<tr>
			<td>product_id</td>
			<td><%=product.getProductId()%></td>
		</tr>
		<tr>
			<td>product_pic</td>
			<td><img src="<%=request.getContextPath()%>/images/<%=product.getProductPic()%>"></td>
		</tr>
		<tr>
			<td>product_name</td>
			<td><%=product.getProductName() %></td>
		</tr>
		<tr>
			<td>product_content</td>
			<td><%=product.getProductContent() %></td>
		</tr>
		<tr>
			<td>product_price</td>
			<td><%=product.getProductPrice() %></td>
		</tr>
		<tr>
			<td>product_soldout</td>
			<td><%=product.getProductSoldout() %></td>
		</tr>
	</table>
</div>
</body>
</html>
