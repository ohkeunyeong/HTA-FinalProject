<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container">
	<ul class="nav nav-tabs shop--nav">
		<li class="nav-item shop--item"><a class="nav-link" href="home">장터홈</a></li>
		<li class="nav-item shop--item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=100">씨앗/모종</a></li>
		<li class="nav-item shop--item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=200">비료/상토</a></li>
		<li class="nav-item shop--item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=300">살충제</a></li>
		<li class="nav-item shop--item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=400">농기구</a></li>
		<li class="nav-item shop--item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=500">굿즈</a></li>
	</ul>
</div>