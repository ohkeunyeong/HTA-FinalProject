<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>주말농장 | 관리자페이지</title>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jjs/adminMain.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jjs/orderDetail.js"></script>
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<jsp:include page="include/header.jsp" />

		<jsp:include page="include/aside.jsp" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="min-height: 1419.6px;">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>주문 상세정보</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item"><a href="orderList">주문목록</a></li>
								<li class="breadcrumb-item active">주문 상세정보</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">

							<!-- Profile Image -->
							<div class="card card-primary card-outline">
								<div class="card-body box-profile">
									<ul class="list-group list-group-unbordered mb-3 h5">
										<li class="list-group-item"><b>주문번호</b> <a class="float-right">${orderdetail.order_num}</a></li>
										<li class="list-group-item"><b>수령인</b> <a class="float-right">${orderdetail.order_name}</a></li>
										<li class="list-group-item"><b>전화번호</b> <a class="float-right">${orderdetail.order_phone}</a></li>
										<li class="list-group-item"><b>주소</b> <a class="float-right">${orderdetail.user_address1} ${orderdetail.user_address2}</a></li>
										<fmt:formatNumber var="totalPrice" value="${orderdetail.order_totalprice}" pattern="###,###,###" />
										<li class="list-group-item"><b>주문가격</b> <a class="float-right">${totalPrice}원</a></li>
										<li class="list-group-item"><b>결제방식</b> <a class="float-right">${orderdetail.order_payment}</a></li>
										<li class="list-group-item"><b>결제일</b> <a class="float-right">${orderdetail.order_date}</a></li>
										<li class="list-group-item"><b>배송상태</b> <a class="float-right">${orderdetail.order_delivery}</a></li>
									</ul>
									<input type="hidden" value="${param.order_num}" id="order_num">
									<input type="hidden" value="${orderdetail.order_delivery}" id="order_delivery">
									<c:if test="${orderdetail.order_delivery == '배송준비'}">
										<div class="float-right"><span class="h4 align-middle">배송상태 변경 : </span><button class="btn btn-primary" id="deliveryBtn">배송중</button></div>
									</c:if>
									<c:if test="${orderdetail.order_delivery == '배송중'}">
										<div class="float-right"><span class="h4 align-middle">배송상태 변경 : </span><button class="btn btn-primary" id="deliveryBtn">배송완료</button></div>
									</c:if>
									<c:if test="${orderdetail.order_delivery == '배송완료'}">
										<span class="float-right h4">배송완료</span>
									</c:if>

								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->

						</div>
						<!-- /.col -->
						<c:forEach var="d" items="${orderlist}">
							<div class="col-lg-6">
								<div class="card card-primary">
									<div class="card-header"></div>
									<div class="card-body d-flex">
										<img class="img-fluid" src="${pageContext.request.contextPath}/upload${d.product_img}" alt="productImg" width="200px" height="200px">
										<div class="h3 mt-2">
											<p>상품이름 : <span>${d.product_name}</span></p>
											<p>카테고리 : <span>${d.category_name}</span></p>
											<p>주문수량 : <span>${d.order_de_count}</span></p>
											<p>상품가격 : <span>${d.product_price}</span></p>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->


		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
			<div class="p-3">
				<h5>Title</h5>
				<p>Sidebar content</p>
			</div>
		</aside>
		<!-- /.control-sidebar -->

		<jsp:include page="include/footer.jsp" />
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED SCRIPTS -->
	<jsp:include page="include/plugin_js.jsp" />

</body>
</html>

