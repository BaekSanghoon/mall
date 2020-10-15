<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchProduct</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn").click(function(){
		if($("#productName").val() == "") {
			alert("productName 입력")
			return;
		}
		$("#search").submit();
		});
	});
</script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String productName = request.getParameter("productName");
	ProductDao productDao = new ProductDao();
	ArrayList<Product> list = productDao.searchProductList(productName);
%>
<div class="container">
<div class="row"  style="margin : 10px;"> <!-- 헤더 goodee shop / 검색바 -->
	<div class="col-sm-4 font-weight-bold"><h2><a class="text-dark"  style="text-decoration : none;" href="<%=request.getContextPath()%>/index.jsp">Goodee Shop</a></h2></div>
	<div class="col">
		<form method="post" action="<%=request.getContextPath()%>/product/searchProduct.jsp" id="search">
			<table>
				<tr>
					<td width="400px">
						<input class="form-control" type="text" name="productName" id="productName"value=<%=productName%>>
					</td>
					<td width="100px">
						<button class="btn btn-info" type="button" id="btn">검색</button>	
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

	<div style="margin : 10px;"></div>
	<h1>검색 결과</h1>
	<div class="container">
	<div style="margin: 10px;"></div>
	<table class="table table-border">
		<tr>
			<%
				int i = 0;
				for(Product p : list){
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