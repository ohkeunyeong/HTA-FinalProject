<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="resources/css/hyun/shop.css"></link>
</head>
<body>
	<jsp:include page="shop_header.jsp" />

    <br><br><br>    	
    <div class="slidebox">
	<input type="radio" name="slide" id="slide01" checked>
	<input type="radio" name="slide" id="slide02">
	<input type="radio" name="slide" id="slide03">
	<input type="radio" name="slide" id="slide04">
	<ul class="slidelist">
		<li class="slideitem">
			<div>
				<label for="slide04" class="left"></label>
				<label for="slide02" class="right"></label>
				<a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg01.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide01" class="left"></label>
				<label for="slide03" class="right"></label>
				<a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg02.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide02" class="left"></label>
				<label for="slide04" class="right"></label>
				<a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg03.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide03" class="left"></label>
				<label for="slide01" class="right"></label>
				<a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg04.jpg"></a>
			</div>
		</li>
	</ul>
	</div>
	
	
	<!-- 굿즈 장터 내 네비게이션 바 -->
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=100">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=200">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=300">살충제</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=400">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=500">퍼스나콘</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=600">굿즈</a></li>
		</ul>
	</div>

	<!-- 추천 제품 출력 코드  --> <!-- 여기부터 진행 !  -->
	<%-- 	<ul>
	 <c:forEach items="${productList}" var="product">
	 <li>
	  <div class="productsThumb">
	   <img src="${product.product_img}"> <!-- ${productlist}로 가져온 목록을 var product에 하나씩 담아서 product.~~의 ~~에 맞는 값을 가져다 쓰는 것 . -->
	  </div> 
	  <div class="goodsName">
	   <a href="/shop/view?n=${product.product_code}">${product.product_name}</a>
	  </div>
	 </li>
	 </c:forEach>
	</ul> --%>
	
	
	<!-- 제품 카드 목록 리스트 -->
	<br>
	<br>
	
		<div class="section1">
			<span>주말농장에서 추천하는 제품!</span> <a href="#" class="button">더보기</a>
		</div>
		
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
					<a href="shop_detail.jsp" class="btn btn-info">제품 보기</a>
				</div>
			</div>
			
		  <c:if test="${status.index % 4 == 3}">
		   </div>
		  </c:if>
		  </c:forEach>
		</div>
	
	<!-- 이모티콘 카드 목록 리스트 -->		

	<br>
	<br>
	<div container="personacon" style="background:lightgray; padding-top:60px; padding-bottom:60px">
		<div class="section2">
			<p id="p1" style="margin-bottom: -8px;">따끈따끈한 </p><p id="p2"> 퍼스나콘</p>
			<p>더욱 즐거운 대화를 위해<br>지금 사용해 보세요</p> 
			<a href="#" class="button">더보기</a>
		</div>
		
		<div class="personacon">
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
					<a href="shop_detail.jsp" class="btn btn-info">제품 보기</a>
				</div>
			</div>
			
		  <c:if test="${status.index % 4 == 3}">
		   </div>
		  </c:if>
		  </c:forEach>
		</div>
	</div>
	

	<jsp:include page="../../main/footer.jsp" />
</body>
</html>