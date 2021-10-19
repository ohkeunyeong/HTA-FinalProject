<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 | 굿즈</title>
<link href="${pageContext.request.contextPath}/resources/css/hyun/shop.css" type="text/css" rel ="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
<jsp:include page="../../main/header.jsp" />  

<jsp:include page="shopSlidebar.jsp" />
	
<jsp:include page="shop_nav.jsp" />

	<c:if test="${listcount > 0}">
		<div class="container shop--content">
			<div class="text-center mt-3 mb-3">
				<h1>주말농부라면 주말굿즈!</h1>
			</div>
			<div class="content--item">
				<c:forEach items="${productlist}" var="p">
					<div class="card mr-5 mb-5" style="width: 18rem;">
						<img src="${pageContext.request.contextPath}/upload${p.product_img}" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품이름 : ${p.product_name}</h5>
							<p class="card-text">
								카테고리 : ${p.category_name}<br>
								상품가격 : ${p.product_price}<br>
								상품정보 : ${p.product_detail}<br>
							</p>
							<a href="${pageContext.request.contextPath}/shop/shop_detail?product_code=${p.product_code}&pageName=${pageName}" class="btn btn-primary">상세보기</a>
						</div>
					</div>
				</c:forEach>
	
				<div class="container justify-content-center mb-3">
					<ul class="pagination m-0 justify-content-center">
						<c:if test="${page <= 1 }">
							<li class="page-item"><a class="page-link gray">«</a></li>
						</c:if>
						<c:if test="${page > 1 }">
							<li class="page-item"><a href="shop_list?page=${page-1}&category_code=${category_code}&pageName=${pageName}" class="page-link">«</a></li>
						</c:if>
	
						<c:forEach var="a" begin="${startpage}" end="${endpage}">
							<c:if test="${a == page }">
								<li class="page-item "><a class="page-link gray">${a}</a></li>
							</c:if>
							<c:if test="${a != page }">
								<li class="page-item"><a href="shop_list?page=${a}&category_code=${category_code}&pageName=${pageName}" class="page-link">${a}</a></li>
							</c:if>
						</c:forEach>
	
						<c:if test="${page >= maxpage }">
							<li class="page-item"><a class="page-link gray">»</a></li>
						</c:if>
						<c:if test="${page < maxpage }">
							<li class="page-item"><a href="shop_list?page=${page+1}&category_code=${category_code}&pageName=${pageName}" class="page-link">»</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</c:if>
	
	<c:if test="${listcount == 0 || empty listcount}">
		<div class="container text-center mt-5 mb-5"><h1>올라온 상품이 없습니다.</h1></div>
	</c:if>
	
	
<jsp:include page="../../main/footer.jsp" />  
</body>
</html>