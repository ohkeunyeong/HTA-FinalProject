<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jjs/shop_nav.js"></script>
<style>
.shop-nav {
	justify-content: space-evenly;
}
</style>
</head>
<body>
	<input type="hidden" value="${pageName}" id="pageName">
	<div class="container">
	<!-- Nav pills -->
	  <ul class="nav nav-pills shop-nav">
	    <li class="nav-item shop-item">
	      <a class="nav-link shop-link" id="shopMain" href="${pageContext.request.contextPath}/shop/shopmain?pageName=shopMain">장터홈</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link shop-link" id="shopSeed" href="${pageContext.request.contextPath}/shop/shop_list?category_code=100&pageName=shopSeed">씨앗/모종</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link shop-link" id="shopSoil" href="${pageContext.request.contextPath}/shop/shop_list?category_code=200&pageName=shopSoil">비료/상토</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link shop-link" id="shopPesticide" href="${pageContext.request.contextPath}/shop/shop_list?category_code=300&pageName=shopPesticide">살충제</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link shop-link" id="shopTools" href="${pageContext.request.contextPath}/shop/shop_list?category_code=400&pageName=shopTools">농기구</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link shop-link" id="shopGoods" href="${pageContext.request.contextPath}/shop/shop_list?category_code=500&pageName=shopGoods">굿즈</a>
	    </li>
	  </ul>
  </div>
</body>
</html>