<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<jsp:include page="../../main/header.jsp"/>
		<title>주말장터 - 장바구니</title>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/jjs/CartView.js" type="text/javascript"></script>
	</head>
	<body>
		<input type="hidden" value="${id}" class="id" />
		<div class="container text-center" style="margin-top : 100px"><h1>장바구니</h1></div>
		<div class="container" style="margin-bottom : 50px;">
			<c:if test="${listcount > 0}">
				<table class="table table-striped text-center">
					<thead>
						<tr>
							<th class="align-middle">모두 선택<br><input name="allCheck" type="checkbox"></th>
							<th class="align-middle">상품 이미지</th>
							<th class="align-middle">상품명</th>
							<th class="align-middle">가격</th>
							<th class="align-middle">구입 수량</th>
							<th class="align-middle">최종 가격</th>
							<th class="align-middle">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="c" items="${cartlist}">
							<c:if test="${c.category_code == 100}">
							<c:set var="pageName" value="shopSeed" />
							</c:if>
							<c:if test="${c.category_code == 200}">
								<c:set var="pageName" value="shopSoil" />
							</c:if>
							<c:if test="${c.category_code == 300}">
								<c:set var="pageName" value="shopPesticide" />
							</c:if>
							<c:if test="${c.category_code == 400}">
								<c:set var="pageName" value="shopTools" />
							</c:if>
							<c:if test="${c.category_code == 500}">
								<c:set var="pageName" value="shopGoods" />
							</c:if>
							
							<tr>
								<td class="align-middle"><input name="RowCheck" type="checkbox" value="${c.product_price * c.order_de_count}" data-cartNum="${c.cart_num}" data-pro_name="${c.product_name}" data-code="${c.product_code}"></td>
								<td class="align-middle"><img src="${pageContext.request.contextPath}/upload${c.product_img}" width="80px" height="80px"></td>
								<td class="align-middle"><a href="/project/shop/shop_detail?product_code=${c.product_code}&pageName=${pageName}">${c.product_name}</a></td>
								<td class="align-middle"><fmt:formatNumber pattern="###,###,###" value="${c.product_price}"/>원</td>
								<td class="align-middle">
									<input class="text-center" type="number" value="${c.order_de_count}" readOnly style="width:40px;">
								</td>
								<td class="align-middle"><fmt:formatNumber pattern="###,###,###" value="${c.product_price * c.order_de_count}"/>원</td>
								<td class="align-middle"><button class="btn btn-danger cartdelbtn" value="${c.cart_num}">삭제</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="text-right"><button class="btn btn-danger float-left" id="selectionDelete">선택 삭제</button>
				<span style="font-size : 30px;" class="orderPrice">주문 가격 : 0원</span></div>
				<div class="text-right"><button class="btn btn-primary orderbtn" style="font-size: 20px; width: 100px;">주문</button></div>
			</c:if>
		</div>
		
		<jsp:include page="cartModal.jsp" />
		
		<c:if test="${listcount == 0 || empty listcount}">
			<div class="container text-center"><h1>장바구니에 담긴 상품이 없습니다.</h1></div>
		</c:if>
		<hr>
		<jsp:include page="../../main/footer.jsp"/>
	</body>
</html>