<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<jsp:include page="../main/header.jsp" />
<style>
.gray {
	color: gray;
}
</style>
</head>
<body>
	<div class="container text-center">
		<h1 class="mb-4" style="margin-top : 88px;">구매 목록</h1>
		<c:if test="${listcount > 0 }">
			<table class="table table-striped table-bordered text-center">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>수령인</th>
						<th>주소</th>
						<th>주문가격</th>
						<th>결제일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="o" items="${orderlist}">
						<tr>
							<td>
								<div>
									<a href="userOrderDetail?order_num=${o.order_num}">${o.order_num}</a>
								</div>
							</td>
							<td>
								<div>
									<span>${o.order_name}</span>
								</div>
							<td>
								<div>
									<span>${o.user_address1} ${o.user_address2}</span>
								</div>
							<td>
								<div>
									<fmt:formatNumber var="totalPrice" value="${o.order_totalprice}" pattern="###,###,###" />
									<span>${totalPrice}원</span>
								</div>
							<td>
								<div>
									<span>${o.order_date}</span>
								</div>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<ul class="pagination justify-content-center">
				<c:if test="${page <= 1 }">
					<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
				</c:if>
				<c:if test="${page > 1 }">
					<li class="page-item"><a href="userOrderView?page=${page-1}" class="page-link">이전&nbsp;</a></li>
				</c:if>

				<c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a == page }">
						<li class="page-item "><a class="page-link gray">${a}</a></li>
					</c:if>
					<c:if test="${a != page }">
						<li class="page-item"><a href="userOrderView?page=${a}" class="page-link">${a}</a></li>
					</c:if>
				</c:forEach>

				<c:if test="${page >= maxpage }">
					<li class="page-item"><a class="page-link gray">&nbsp;다음</a></li>
				</c:if>
				<c:if test="${page < maxpage }">
					<li class="page-item"><a href="userOrderView?page=${page+1}&user_id=${param.user_id}" class="page-link">&nbsp;다음</a></li>
				</c:if>
			</ul>
		</c:if>
	</div>
	<c:if test="${listcount == 0}">
		<div class="container text-center">
			<h1>주문하신 상품이 없습니다.</h1>
		</div>
	</c:if>
	<hr>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>