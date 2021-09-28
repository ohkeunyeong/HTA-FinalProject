<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script src="${pageContext.request.contextPath}/resources/js/jjs/farmList.js"></script>
<style>
.gray {
	color: gray
}

a:not([href]) {
	color: gray;
	text-decoration: none;
}
</style>
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
							<h1 class="m-0 text-dark">농장목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item active">농장목록</li>
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
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h3 class="card-title mt-2">농장목록</h3>
									<select class="form-control float-right" id="farmSelect" style="width: 150px;">
										<option value="0">최신순</option>
										<option value="1">멤버인원수</option>
									</select>
								</div>
								<!-- /.card-header -->
								<c:if test="${listcount > 0}">
									<div class="card-body">
											<c:forEach items="${farmList}" var="f">
												<div class="row border mb-3">
													<div class="col-12 col-sm-5">
														<div class="col-12 mt-5 ml-5">
															<img src="${pageContext.request.contextPath}/resources/image/jjs/among us.png" style="width: 200px; height: 200px">
														</div>
													</div>
													<div class="col12 col-sm-6">
														<div class="col-12 mt-3">
															<div class="input-group">
																<p class="h4 p-2">농장이름 : <span>${f.mynong_name}</span></p>
															</div>
														</div>
														<div class="col-12 mt-3">
															<div class="input-group">
																<p class="h4 p-2">농장관리자 : <span>${f.name}</span></p>
															</div>
														</div>
														<div class="col-12 mt-3">
															<div class="input-group">
																<p class="h4 p-2">농장인원수 : <span>${f.membercnt}</span></p>
															</div>
														</div>
														<div class="col-12 mt-3 mb-3">
															<div class="input-group">
																<p class="h4 p-2">농장등록일 : <span>${f.mynong_date}</span></p>
															</div>
														</div>
													</div>
												</div>
											</c:forEach>
									</div>

									<!-- /.card-body -->

									<div class="card-footer clearfix">
										<ul class="pagination m-0 justify-content-center">
											<c:if test="${page <= 1 }">
												<li class="page-item"><a class="page-link gray">«</a></li>
											</c:if>
											<c:if test="${page > 1 }">
												<li class="page-item"><a href="farmList?page=${page-1}" class="page-link">«</a></li>
											</c:if>

											<c:forEach var="a" begin="${startpage}" end="${endpage}">
												<c:if test="${a == page }">
													<li class="page-item "><a class="page-link gray">${a}</a></li>
												</c:if>
												<c:if test="${a != page }">
													<li class="page-item"><a href="farmList?page=${a}" class="page-link">${a}</a></li>
												</c:if>
											</c:forEach>

											<c:if test="${page >= maxpage }">
												<li class="page-item"><a class="page-link gray">»</a></li>
											</c:if>
											<c:if test="${page < maxpage }">
												<li class="page-item"><a href="farmList?page=${page+1}" class="page-link">»</a></li>
											</c:if>
										</ul>
									</div>
								</c:if>

								<c:if test="${listcount == 0 }">
									<p class="text-center h2 mt-3 mb-3">
										<span>등록된 농장이 없습니다.</span>
									</p>
								</c:if>
							</div>
							<!-- /.card -->
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
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

