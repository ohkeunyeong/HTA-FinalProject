<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<style>
h5 {
	padding-top: 10px;
	font-weight:bold;
}

.container .nav {
	margin-top: 80px;
	font-size: 20px;
}

.recommendation {
	margin-top: 1%;
	margin-left: 14%;
}

.section1 {
	text-align: center;
}

.section1> span {
	font-size: 30px;
	font-weight: bold;
	margin-right:48%;
}

.section1 .button {
	font-size: 20px;
	font-weight: medium;
	color: gray;
}

.recommendation .products {
	margin-top: 2%;
	margin-bottom: 2%;
	margin-right: 15%;
}

.recommendation .products card-deck .card {
	width: 300px;
	height: 250px;
}

.recommendation .products>card-img-top {
	height: 200px;
}

/* 슬라이드 배너 */
* {margin:0;padding:0;box-sizing:border-box;}
ul, li {list-style:none;} */

[name="slide"] {display:none; }
.slidebox {max-width:1000px;width:100%;margin:0 auto;text-align:center; }
.slidebox img {max-width:100%; height:300px;}/*width:1000px에 height:300px;짜리 이미지를 넣어야 맞음 */
.slidebox .slidelist {
	white-space:nowrap;
	font-size:0;
	overflow:hidden;
	height:300px;
}
.slidebox .slideitem {
	position:relative;
	display:inline-block;
	vertical-align:middle;
	width:100%;
	transition:all .35s;
}
.slidebox .slideitem label {
	position:absolute;
	z-index:1;
	top:50%;
	transform:translateY(-50%);
	padding:20px;
	border-radius:50%;
	cursor:pointer;
}
label.left {
	left:20px;
	/* background-color:#FFFFFF; */
	background-image:url('${pageContext.request.contextPath}/resources/image/banner/left-arrow.png');
	background-position:center center;
	background-size:50%;
	background-repeat:no-repeat;
}
label.right {
	right:20px;
	/* background-color:#FFFFFF; */
	background-image:url('${pageContext.request.contextPath}/resources/image/banner/right-arrow.png');
	background-position:center center;
	background-size:50%;
	background-repeat:no-repeat;
}

/* 페이징 스타일 */
.paginglist {text-align:center;padding:30px 0;}
.paginglist > li {display:inline-block;vertical-align:middle;margin:0 10px;}
.paginglist > li > label {display:block;padding:10px 30px;border-radius:10px;background:#ccc;cursor:pointer;}
.paginglist > li:hover > label {background:#333;}

[id="slide01"]:checked ~ .slidelist .slideitem {transform:translateX(0);animation:slide01 20s infinite;}
[id="slide02"]:checked ~ .slidelist .slideitem {transform:translateX(-100%);animation:slide02 20s infinite;}
[id="slide03"]:checked ~ .slidelist .slideitem {transform:translateX(-200%);animation:slide03 20s infinite;}
[id="slide04"]:checked ~ .slidelist .slideitem {transform:translateX(-300%);animation:slide04 20s infinite;}

@keyframes slide01 {
	0% {left:0%;}
	23% {left:0%;}
	25% {left:-100%;}
	48% {left:-100%;}
	50% {left:-200%;}
	73% {left:-200%;}
	75% {left:-300%;}
	98% {left:-300%;}
	100% {left:0%;}
}
@keyframes slide02 {
	0% {left:0%;}
	23% {left:0%;}
	25% {left:-100%;}
	48% {left:-100%;}
	50% {left:-200%;}
	73% {left:-200%;}
	75% {left:100%;}
	98% {left:100%;}
	100% {left:0%;}
}
@keyframes slide03 {
	0% {left:0%;}
	23% {left:0%;}
	25% {left:-100%;}
	48% {left:-100%;}
	50% {left:200%;}
	73% {left:200%;}
	75% {left:100%;}
	98% {left:100%;}
	100% {left:0%;}
}
@keyframes slide04 {
	0% {left:0%;}
	23% {left:0%;}
	25% {left:300%;}
	48% {left:300%;}
	50% {left:200%;}
	73% {left:200%;}
	75% {left:100%;}
	98% {left:100%;}
	100% {left:0%;}
}

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
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products/list?category_code=100">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=200">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=300">살충제</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=400">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=500">퍼스나콘</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}products/list?category_code=600">굿즈</a></li>
		</ul>
	</div>

	<!-- 추천 제품 출력 코드  --> <!-- 여기부터 진행 !  -->
		<ul>
	 <c:forEach items="${productList}" var="product">
	 <li>
	  <div class="productsThumb">
	   <img src="${product.product_img}"> <!-- ${productlist}로 가져온 목록을 var product에 하나씩 담아서 product.~~의 ~~에 맞는 값을 가져다 쓰는 것 . -->
	  </div> 
	  <div class="goodsName">
	   <a href="/shop/view?n=${product.product_code}">${product.product_name}</a>
	  </div>
	 </li>
	 </c:forEach>
	</ul>
	
	
	<!-- 제품 카드 목록 리스트 -->
	<br>
	<br>
	
		<div class="section1">
			<span>주말농장에서 추천하는 제품!</span> <a href="#" class="button">더보기</a>
		</div>
		
		<div class="recommendation">
		 <c:forEach items="${productList}" var="product" varStatus="status">
		
		 <c:if test="${status.index % 4 == 0}">
		  <div class="products card-deck">
		 </c:if>
		 
			<div class="card" style="width:400px">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/hyun/${product.product_img}"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">${product.product_name}</h5>
					<p class="card-text">${product.product_detail}</p>
					<a href="shop_detail.jsp" class="btn btn-info">제품 보기</a>
				</div>
			</div>
			
		  <c:if test="${status.index % 4 == 3}">
		   </div>
		  </c:if>
		  </c:forEach>
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