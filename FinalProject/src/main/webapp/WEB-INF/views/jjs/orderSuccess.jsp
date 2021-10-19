<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../main/header.jsp" />
<meta charset="UTF-8">
<title>주말장터 - 주문완료</title>
</head>
<body>
	<div class="container text-center mb-3" style="margin-top : 100px;">
		<h1>주문이 완료되었습니다.</h1>
		<div>
			<a class="btn btn-info" href="${pageContext.request.contextPath}/member/userOrderView" style="margin-right : 10px;">주문내역 보기</a>
			<a class="btn btn-primary" href="${pageContext.request.contextPath}/main">홈으로 가기</a>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>