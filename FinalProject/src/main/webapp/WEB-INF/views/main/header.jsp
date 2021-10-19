<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
<title>주말농장 메인 헤더</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jjs/header.css"></link>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="/project/resources/js/jjs/header.js"></script> <!-- 절대주소로 변경 -->
</head>
<body>

	<nav class="navbar navbar-expand-sm bg-success navbar-dark fixed-top main-header">
		<!-- fixed-top -->
		<!-- Brand -->
		<a class="navbar-brand" href="${pageContext.request.contextPath}/main" style="height:120%; padding-left:2%;"> <img src="${pageContext.request.contextPath}/resources/image/logo2.png" alt="Logo">
		</a>


		<ul class="navbar-nav navbar-expand-sm" style="padding-right"16%">

			<!-- Dropdown -->
			<li class="nav-item dropdown active" style="padding-left: 4%">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 내 농장 </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/calprocess?id=${id}">캘린더</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/accprocess?id=${id}">가계부</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/nongprocess?id=${id}">멤버게시판</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/mynongprocess?id=${id}">농장관리</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/createmynong">농장생성</a>
				</div></li>

			<!-- Dropdown -->
			<li class="nav-item dropdown active" style="padding-left: 4%;"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 농장 모듬 </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/free/list">수다 농장</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/jik/list">직거래 장터</a>
				</div></li>
				
			<!-- Dropdown -->
			<li class="nav-item dropdown active" style="padding-left: 4%"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 굿즈 장터 </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shopmain?pageName=shopMain">굿즈 장터</a> 
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shop_list?category_code=100&pageName=shopSeed">씨앗/모종</a> 
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shop_list?category_code=200&pageName=shopSoil">비료/상토</a> 
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shop_list?category_code=300&pageName=shopPesticide">살충제</a>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shop_list?category_code=400&pageName=shopTools">농기구</a> 
					<a class="dropdown-item" href="${pageContext.request.contextPath}/shop/shop_list?category_code=500&pageName=shopGoods">주말 굿즈</a> 
				</div></li>

			<!-- Dropdown -->
			<li class="nav-item dropdown active" style="padding-left: 4%"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 고객 센터 </a>
				<div class="dropdown-menu">
				   <a class="dropdown-item" href="${pageContext.request.contextPath}/notice/noticeList">공지사항</a> 
				   <a class="dropdown-item" href="${pageContext.request.contextPath}/faq">FAQ</a> 
				   <a class="dropdown-item" href="${pageContext.request.contextPath}/emailprocess?id=${id}">메일문의</a> 
				</div></li>

		</ul>

		<ul class="navbar-nav navbar-expand-sm" style="width:30%;">
			<c:if test="${empty id}" >
				<li>
					<div class="weather">
						<div class="CurrIcon"></div>
      					<div class="CurrTemp"></div>
      					<div class="City"></div>
    				</div>
    			</li>
    			
				<!-- Links -->
				<li class="nav-item active">
					<a class="nav-link" href="${pageContext.request.contextPath}/cart">장바구니</a>
				</li>
				<li class="nav-item active">
					<a class="nav-link" href="${pageContext.request.contextPath}/member/login">로그인</a>
				</li>
				<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
			</c:if>
			<c:if test="${!empty id}">
				<li>
					<div class="weather" >
						<div class="CurrIcon"></div>
	      				<div class="CurrTemp"></div>
	      				<div class="City"></div>
	    			</div>
    			</li>
				<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/member/logout"> ${nick} 님(로그아웃)</a></li>
				<c:if test="${id == 'admin' }">
					<li class="nav-item active"><a class="nav-link" href="${pageContext.request.contextPath}/admin/main"> 관리자페이지</a></li>
				</c:if>
				<c:if test="${id != 'admin' }">
							<li class="nav-item dropdown active" style="padding-left: 4%"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 마이페이지</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/updatebefore">정보수정</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/member/userOrderView">구매관리</a> <a class="dropdown-item" href="${pageContext.request.contextPath}/cart/list?id=${id}">장바구니</a>
				</div></li>
				</c:if>
			</c:if>

		</ul>
	</nav>
	<br>
	

</body>
</html>
