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
<title>Insert title here</title>
</head>
<%
	CategoryDao categoryDao = new CategoryDao();
	//카테고리 이름 리스트
	ArrayList<Category> categoryList1 = categoryDao.selectCategoryList();
	//카테고리 이미지 리스트
	ArrayList<Category> categoryList2 = categoryDao.selectCategoryCkList();
%>
<body>
<div class="container">
	<div> <!-- 타이틀과 검색바 -->
		
		<div Class="row"> <!-- 타이틀 -->
			<dic class="col">
				<h2><a class="text"href="<%=request.getContextPath()%>/index.jsp">Goodee Shop</a></h2>
			</dic>
			<dic class="col" method="post" action="<%=request.getContextPath()%>/product/searchProduct.jsp" ><!-- 검색창 -->
				<form method="post" action="<%=request.getContextPath()%>/product/searchProduct.jsp">
					<input type="text" name="productName" >
					<button type="submit">검색</button>
				</form>
			</dic>
			<dic class="col"><!-- 아이콘 -->
			<%
				if(session.getAttribute("loginMemberEmail") == null){
			%>
					<a class="text-dark" href="<%=request.getContextPath()%>/member/login.jsp"><i class='fas fa-user-alt' style='font-size:40px;'></i></a>	
			<%
				}else{
			%>
					<a class="text-dark" href="<%=request.getContextPath()%>/orders/myOrdersList.jsp"><i class='fas fa-user-alt' style='font-size:40px;'></i></a>	
			<%
				}
			%>	
			
				<i class='fas fa-shopping-cart' style='font-size:40px;'></i>					
		</div>

	</div>
	<div> <!-- 로그인 회원가입 메뉴바 -->
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		  <%
		  	if(session.getAttribute("loginMemberEmail") == null) {
		  %>
		  <!-- Links -->
			 <ul class="navbar-nav">
			    <!-- 로그인이 되지 않았을때 보여짐(로그 아웃 상태) -->
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/login.jsp">로그인</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/signup.jsp">회원가입</a>
			    </li>
	  		</ul>
	  		<%
		  	} else {
	  		%>
	  		<ul class="navbar-nav">
			    <li class="nav-item">
			    <!-- 로그인 상태 -->
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/logoutAction.jsp">로그아웃</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="<%=request.getContextPath()%>/member/logoutAction.jsp">회원정보</a>
			    </li>
	  		</ul>
	  		<%
		  		}
	  		%>
		</nav>
	</div>
	 
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