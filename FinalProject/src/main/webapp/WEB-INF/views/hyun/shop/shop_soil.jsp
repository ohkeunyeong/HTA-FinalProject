<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 | 비료/상토 </title>
<link href="${pageContext.request.contextPath}/resources/css/hyun/shop.css" type="text/css" rel ="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
h4{padding-top:30px;}
</style>
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
<div class="container nav">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=100">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=200">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=300">살충제</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=400">농기구</a></li>
			<%-- <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=500">퍼스나콘</a>
			</li> --%>
			<li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}products/list?category_code=600">굿즈</a></li>
		</ul>
	</div>


<div class="container">
<br><br>
  <h4>비료/상토 제품</h4>
</div>
	
<div class="container">	
		<div class="soil">
		 <c:forEach items="${soilList1}" var="soil" varStatus="status">
		
		 <c:if test="${status.index % 4 == 0}">
		  <div class="products card-deck">
		 </c:if>
		 
			<div class="card" style="width:20%" >
				<img class="card-img-top" style="height:300px;"
					src="${pageContext.request.contextPath}/resources/image/hyun/${soil.product_img}"
					alt="Card image" style="width:100%; height:300px">
				<div class="card-body">
					<h5 class="card-title">${soil.product_name}</h5>
					<p class="card-text">${soil.product_detail}</p>
					<a href="shop/shop_detail?product_code=${soil.product_code}" class="btn btn-info">제품 보기</a>
				</div>
			</div>
				<c:if test="${status.index % 4 == 3}">
		   </div>
		  </c:if>
		  </c:forEach>
		</div>
		</div>	

		<!--  페이지네이션 -->
	<ul class="pagination justify-content-center" style="margin:20px 0">
	  <li class="page-item"><a class="page-link" href="#">이전</a></li>
	  <li class="page-item"><a class="page-link" href="#">1</a></li>
	  <li class="page-item"><a class="page-link" href="#">2</a></li>
	  <li class="page-item"><a class="page-link" href="#">3</a></li>
	  <li class="page-item"><a class="page-link" href="#">4</a></li>
	  <li class="page-item"><a class="page-link" href="#">5</a></li>
	  <li class="page-item"><a class="page-link" href="#">다음</a></li>
	</ul>

<jsp:include page="../../main/footer.jsp" />  
</body>
</html>