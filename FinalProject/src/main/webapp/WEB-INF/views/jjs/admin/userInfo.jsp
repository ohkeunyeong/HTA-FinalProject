<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<div class="content-wrapper" style="min-height: 1419.6px;">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>회원 상세정보</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item"><a href="userList">회원목록</a></li>
								<li class="breadcrumb-item active">회원 상세정보</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row" style="justify-content : center">
						<div class="col-md-6">

							<!-- Profile Image -->
							<div class="card card-primary card-outline">
								<div class="card-body box-profile">
									<div class="text-center">
										<c:if test="${memberInfo.persnacon == 'null'}">
											<img class="profile-user-img img-fluid img-circle" src="${pageContext.request.contextPath}/resources/image/jjs/BasicPersonacon.png" alt="User profile picture">
										</c:if>
										<c:if test="${memberInfo.persnacon != 'null'}">
											<img class="profile-user-img img-fluid img-circle" src="${pageContext.request.contextPath}/upload/${memberInfo.persnacon}" alt="User profile picture">
										</c:if>
									</div>

									<h3 class="profile-username text-center">${memberInfo.name}</h3>

									<p class="text-muted text-center">${memberInfo.id}</p>

									<ul class="list-group list-group-unbordered mb-3">
										<li class="list-group-item"><b>내농장</b> <a class="float-right">${memberInfo.mynong_name}</a></li>
										<li class="list-group-item"><b>회원등급</b> 
											<a class="float-right">
												<c:if test="${memberInfo.my_farm == '0' }">
													<div>일반멤버</div>
												</c:if>
												<c:if test="${memberInfo.my_farm == '1' }">
													<div>농장 관리자</div>
												</c:if>
												<c:if test="${memberInfo.my_farm == '2' }">
													<div>농장멤버</div>
												</c:if>
											</a>
										</li>
										<li class="list-group-item"><b>닉네임</b> <a class="float-right">${memberInfo.nick}</a></li>
										<li class="list-group-item"><b>이메일</b> <a class="float-right">${memberInfo.mail}</a></li>
										<c:set var="tel" value="${fn:substring(memberInfo.tel,0,3)}-${fn:substring(memberInfo.tel,3,7)}-${fn:substring(memberInfo.tel,7,13)}"></c:set>
										<li class="list-group-item"><b>전화번호</b> <a class="float-right">${tel}</a></li>
									</ul>

									<button class="btn btn-danger btn-block" data-toggle="modal" data-backdrop="static" data-keyboard="false" data-target="#userDeleteModal">
										<b>회원삭제</b>
									</button>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->

						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<jsp:include page="modal/memberModal.jsp" />

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

