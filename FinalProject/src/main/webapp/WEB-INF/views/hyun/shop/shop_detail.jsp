<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<style>
h5 {
	padding-top: 10px;
	font-weight:medium;
}

.container .nav {
	margin-top: 80px;
	font-size: 20px;
}

.recommendation {
	margin-top: 1%;
	margin-left: 14%;
}

.section1 {
	text-align: center;
}

.section1> span {
	font-size: 20px;
	font-weight: medium;
	margin-right:48%;
}

.section1 .button {
	font-size: 20px;
	font-weight: medium;
	color: gray;
}

.recommendation .products {
	margin-top: 2%;
	margin-bottom: 2%;
	margin-right: 15%;
}

.recommendation .products card-deck .card {
	width: 300px;
	height: 250px;
}

.recommendation .products>card-img-top {
	height: 200px;
}


</style>
</head>
<body>
	<jsp:include page="shop_header.jsp" />

    <br><br><br>    	
    
	<!-- 굿즈 장터 내 네비게이션 바 -->
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="seed">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="soil">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="pesticide">살충제</a></li>
			<li class="nav-item"><a class="nav-link" href="tools">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="personacon">퍼스나콘</a></li>
			<li class="nav-item"><a class="nav-link" href="goods">굿즈</a></li>
		</ul>
	</div>

	<!-- 제품 카드 목록 리스트 -->
	<br>
	<br>
	<br>
	
	<div class="section1">
		</div>
		
		<div class="container">
		
		<div class="recommendation">
		 <c:forEach items="${productList}" var="product" varStatus="status">
		
		 <c:if test="${status.index % 4 == 0}">
		  <div class="products card-deck">
		 </c:if>
		 
			<div class="card" >
				<img class="card-img-top" style="height:300px"
					src="${pageContext.request.contextPath}/resources/image/hyun/${product.product_img}"
					alt="Card image" style="width:100%; height:300px">
				<div class="card-body">
					<h5 class="card-title">${product.product_name}</h5>
					<p class="card-text">${product.product_detail}</p>
					<a href="shop/shop_detail?product_code=${product.product_code}" class="btn btn-info">제품 보기</a>
				</div>
			</div>
			
		  <c:if test="${status.index % 4 == 3}">
		   </div>
		  </c:if>
		  
		  </c:forEach>
		</div>
		</div>
		
		
		<div class="section1">
			<span>제품 상세 > ${product.product_name}</span> 
		</div>
		<br><br>
		<div class="recommendation">
		
		
		<div class="products card-deck">
			<div class="card">
				<img class="card-img-top"
					src="${product.product_img}"
					alt="Card image" style="width: 100%; height:300px">
				<div class="card-body">
					<h5 class="card-title">${product.product_name}</h5>
					<p class="card-text">${product.product_detail}</p>
					<a href="#" class="btn btn-primary">장바구니 추가</a>
				</div>
			</div>			
		</div>
		<br>

	</div>


	<jsp:include page="../../main/footer.jsp" />
</body>
</html>
