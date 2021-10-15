<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<jsp:include page="../../main/header.jsp" />

	<jsp:include page="shopSlidebar.jsp" />

	<!-- 굿즈 장터 내 네비게이션 바 -->
	<jsp:include page="shop_nav.jsp" />

	<div class="container shop--content">
		<div class="text-center mt-3 mb-3">
			<h1>장터 전체상품</h1>
		</div>
		<div class="content--item">
			<c:forEach items="${productlist}" var="p">
				<div class="card mr-5 mb-5" style="width: 18rem;">
					<img src="${pageContext.request.contextPath}/resources/upload${p.product_img}" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title">${p.product_name}</h5>
						<p class="card-text">${p.product_detail}</p>
						<a href="shop/shop_detail?product_code=${p.product_code}" class="btn btn-primary">상세보기</a>
					</div>
				</div>
			</c:forEach>

			<div class="container justify-content-center mb-3">
				<ul class="pagination m-0 justify-content-center">
					<c:if test="${page <= 1 }">
						<li class="page-item"><a class="page-link gray">«</a></li>
					</c:if>
					<c:if test="${page > 1 }">
						<li class="page-item"><a href="shopmain?page=${page-1}" class="page-link">«</a></li>
					</c:if>

					<c:forEach var="a" begin="${startpage}" end="${endpage}">
						<c:if test="${a == page }">
							<li class="page-item "><a class="page-link gray">${a}</a></li>
						</c:if>
						<c:if test="${a != page }">
							<li class="page-item"><a href="shopmain?page=${a}" class="page-link">${a}</a></li>
						</c:if>
					</c:forEach>

					<c:if test="${page >= maxpage }">
						<li class="page-item"><a class="page-link gray">»</a></li>
					</c:if>
					<c:if test="${page < maxpage }">
						<li class="page-item"><a href="shopmain?page=${page+1}" class="page-link">»</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

	<jsp:include page="../../main/footer.jsp" />
</body>
</html>