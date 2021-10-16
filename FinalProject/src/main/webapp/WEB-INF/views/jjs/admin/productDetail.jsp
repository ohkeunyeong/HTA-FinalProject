<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<jsp:include page="include/header.jsp" />

		<jsp:include page="include/aside.jsp" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0 text-dark">상품상세보기</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item"><a href="productList">주말장터 관리</a></li>
								<li class="breadcrumb-item active">상품상세보기</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="container-fluid">
							<div class="card">
								<div class="card-body">
									<div class="row">
										<div class="col-12 col-sm-6">
											<div class="col-12">
												<img src="${pageContext.request.contextPath}/upload${product.product_img}" style="width: 400px; height: 300px;">
											</div>
										</div>
										<div class="col-12 col-sm-6">
											<div class="col-12">
												<div class="form-group">
													<label for="product_code">상품코드</label> <input class="form-control" id="product_code" name="product_code" value="${product.product_code}" disabled>
												</div>
												<div class="form-group">
													<label for="product_name">상품이름</label> <input class="form-control" id="product_name" name="product_name" value="${product.product_name}" disabled>
												</div>
												<div class="form-group">
													<label for="category_name">카테고리</label> <input class="form-control" id="category_name" name="category_name" value="${product.category_name}" disabled>
												</div>
												<div class="form-group">
													<label for="product_detail">상품상세정보</label>
													<textarea class="form-control" id="product_detail" name="product_detail" disabled style="resize: none;">${product.product_detail}</textarea>
												</div>
												<div class="form-group">
													<fmt:formatNumber var="price" value="${product.product_price}" pattern="###,###,###"/>
													<label for="product_price">가격</label> <input class="form-control" id="product_price" name="product_price" value="${price}원" disabled>
												</div>
												<div class="form-group">
													<label for="product_date">상품등록일</label> <input class="form-control" id="product_date" name="product_date" value="${product.product_date}" disabled>
												</div>
												<div class="float-right">
													<button class="btn btn-danger" data-toggle="modal" 
															data-backdrop="static" data-keyboard="false" 
															data-target="#productDeleteModal">삭제</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<jsp:include page="modal/productModal.jsp" />

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

