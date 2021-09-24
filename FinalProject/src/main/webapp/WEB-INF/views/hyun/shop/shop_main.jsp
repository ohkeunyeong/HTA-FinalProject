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
h4 {
	padding-top: 50px;
}

.container .nav {
	margin-top: 140px;
	font-size: 20px;
}

.recommendation {
	margin-top: 1%;
	margin-left: 14%;
}

.recommendation>span {
	font-size: 30px;
	font-weight: bold;
}

.recommendation .button {
	font-size: 20px;
	font-weight: medium;
	color: gray;
	margin-left: 55%;
	margin-right: 14%;
}

.recommendation .products {
	margin-top: 2%;
	margin-bottom: 2%;
	margin-right: 15%;
}

.recommendation .products > card {
	height:400px;
}

</style>
</head>
<body>
	<jsp:include page="shop_header.jsp" />

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

	<br>
	<br>
	<div class="recommendation">
		<span>주말농장에서 추천하는 제품!</span> <a href="#" class="button">더보기</a>

		<div class="products card-deck">
			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">튼튼 호미(중)</h4>
					<p class="card-text">얕은 땅을 팔 때 유용한 튼튼호미입니다. 가볍고 오래 사용해도 녹슬지
						않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">엉덩이 방석 1개</h4>
					<p class="card-text">내 엉덩이를 보호해주는 작은 동그라미 친구! 타사보다 더 크고 탄탄한 주말
						장터의 엉덩이 방석에 앉아보세요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">주말 장터 장바구니(대)</h4>
					<p class="card-text">수확한 농작물을 담아보세요. 리뉴얼로 사이즈는 더 커지고 소재는 더
						강해졌어요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">팍팍 곡괭이(소)</h4>
					<p class="card-text">자갈 제거에 제격인 곡괭이입니다. 가볍고 오래 사용해도 녹슬지 않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>
		</div>


		<div class="products card-deck">
			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">튼튼 호미(중)</h4>
					<p class="card-text">얕은 땅을 팔 때 유용한 튼튼호미입니다. 가볍고 오래 사용해도 녹슬지
						않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">엉덩이 방석 1개</h4>
					<p class="card-text">내 엉덩이를 보호해주는 작은 동그라미 친구! 타사보다 더 크고 탄탄한 주말
						장터의 엉덩이 방석에 앉아보세요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">주말 장터 장바구니(대)</h4>
					<p class="card-text">수확한 농작물을 담아보세요. 리뉴얼로 사이즈는 더 커지고 소재는 더
						강해졌어요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top" style="height: 300px;"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width:100%">
				<div class="card-body">
					<h4 class="card-title">팍팍 곡괭이(소)</h4>
					<p class="card-text">자갈 제거에 제격인 곡괭이입니다. 가볍고 오래 사용해도 녹슬지 않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>
		</div>
		<br>

	</div>



	<jsp:include page="../../main/footer.jsp" />
</body>
</html>