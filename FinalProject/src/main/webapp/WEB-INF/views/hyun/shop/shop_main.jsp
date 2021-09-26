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
	<!-- 배너 -->
	<div class="container-fluid p-3 my-1 bg-info text-white" style="height:330px;">
	  <h1>3년간 베스트! 효과 직빵! ㅇㅇㅇ 살충제</h1>
	  <p>This part is inside a .container-fluid class.</p>
	  <p>The .container-fluid class provides a full width container, spanning the entire width of the viewport.</p>           
	</div>
	
	<center>
	<img onmouseup="window.open('http://이벤트 페이지')" src="http://배너 이미지 경로 .jpg" style="cursor:pointer;">
	</center>
	
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

			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">엉덩이 방석 1개</h5>
					<p class="card-text">내 엉덩이를 보호해주는 작은 동그라미 친구! 타사보다 더 크고 탄탄한 주말
						장터의 엉덩이 방석에 앉아보세요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">주말 장터 장바구니(대)</h5>
					<p class="card-text">수확한 농작물을 담아보세요. 리뉴얼로 사이즈는 더 커지고 소재는 더
						강해졌어요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">팍팍 곡괭이(소)</h5>
					<p class="card-text">자갈 제거에 제격인 곡괭이입니다. 가볍고 오래 사용해도 녹슬지 않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>
		</div>


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

			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">엉덩이 방석 1개</h5>
					<p class="card-text">내 엉덩이를 보호해주는 작은 동그라미 친구! 타사보다 더 크고 탄탄한 주말
						장터의 엉덩이 방석에 앉아보세요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">주말 장터 장바구니(대)</h5>
					<p class="card-text">수확한 농작물을 담아보세요. 리뉴얼로 사이즈는 더 커지고 소재는 더
						강해졌어요.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>

			<div class="card" style="width: 300px;">
				<img class="card-img-top"
					src="${pageContext.request.contextPath}/resources/image/homi.jpg"
					alt="Card image" style="width: 100%">
				<div class="card-body">
					<h5 class="card-title">팍팍 곡괭이(소)</h5>
					<p class="card-text">자갈 제거에 제격인 곡괭이입니다. 가볍고 오래 사용해도 녹슬지 않습니다.</p>
					<a href="#" class="btn btn-info">제품 보기</a>
				</div>
			</div>
		</div>
		<br>

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