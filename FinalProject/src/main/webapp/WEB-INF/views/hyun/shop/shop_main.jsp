<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css" type="text/css" rel ="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
h4{padding-top:30px;}
</style>
</head>
<body>
<jsp:include page="shop_header.jsp" />  

<!-- 굿즈 장터 내 네비게이션 바 -->

<div class="container">
<br><br>
  <h4>주말농장에서 추천하는 제품!</h4>


</div>
	

<jsp:include page="../../main/footer.jsp" />  
</body>
</html>