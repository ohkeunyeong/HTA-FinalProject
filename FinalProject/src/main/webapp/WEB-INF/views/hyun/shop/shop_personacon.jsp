<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 퍼스나콘</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css" type="text/css" rel ="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
h4{padding-top:30px;}
</style>
</head>
<body>
<jsp:include page="shop_header.jsp" />  

<!-- 굿즈 장터 내 네비게이션 바 -->
<!-- 굿즈 장터 내 네비게이션 바 -->
<div class="container">
  <ul class="nav nav-tabs nav-justified">
    <li class="nav-item">
      <a class="nav-link active" href="#">장터홈</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">씨앗/모종</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">비료/상토</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">살충제</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">농기구</a>
    </li>
    <li class="nav-item">
      <a class="nav-link active" href="#">퍼스나콘</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">굿즈</a>
    </li>
  </ul>
</div>



<div class="container">
<br><br>
  <h4>이번주 가장 인기많은 퍼스나콘 Top20</h4>


</div>
	

<jsp:include page="../../main/footer.jsp" />  
</body>
</html>