<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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


</style>
</head>
<body>
	<jsp:include page="shop_header.jsp" />

    <br><br><br>    	
    
	<!-- 굿즈 장터 내 네비게이션 바 -->
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="seed">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="soil">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="pesticide">살충제</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="tools">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="personacon">퍼스나콘</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="goods">굿즈</a></li>
		</ul>
	</div>

	<!-- 제품 카드 목록 리스트 -->
	<br>
	<br>
	
		<div class="section1">
			<span>주말농장에서 추천하는 제품!</span> <a href="#" class="button">더보기</a>
		</div>
		
		<div class="recommendation">
		<div class="products card-deck">
			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">튼튼 호미(중)</h5>
					<p class="card-text">얕은 땅을 팔 때 유용한 튼튼호미입니다. 가볍고 오래 사용해도 녹슬지
						않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>			
		</div>
		<br>

	</div>


	<jsp:include page="../../main/footer.jsp" />
</body>
</html>
