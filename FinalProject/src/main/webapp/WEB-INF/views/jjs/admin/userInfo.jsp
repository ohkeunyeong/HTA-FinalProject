<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
					<div class="row">
						<div class="col-md-3">

							<!-- Profile Image -->
							<div class="card card-primary card-outline">
								<div class="card-body box-profile">
									<div class="text-center">
										<img class="profile-user-img img-fluid img-circle" src="${pageContext.request.contextPath}/dist/img/user4-128x128.jpg" alt="User profile picture">
									</div>

									<h3 class="profile-username text-center">자바</h3>

									<p class="text-muted text-center">java</p>

									<ul class="list-group list-group-unbordered mb-3">
										<li class="list-group-item"><b>내농장</b> <a class="float-right">JavaFarm</a></li>
										<li class="list-group-item"><b>회원등급</b> <a class="float-right">농장멤버</a></li>
										<li class="list-group-item"><b>닉네임</b> <a class="float-right">javas</a></li>
										<li class="list-group-item"><b>이메일</b> <a class="float-right">javas@naver.com</a></li>
										<li class="list-group-item"><b>전화번호</b> <a class="float-right">010-9999-9999</a></li>
									</ul>

									<button class="btn btn-danger btn-block" data-toggle="modal" 
											data-backdrop="static" data-keyboard="false" 
											data-target="#userDeleteModal">
										<b>회원삭제</b>
									</button>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->

						</div>
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card">
								<div class="card-header p-2">
									<ul class="nav nav-pills">
										<li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">최근에 올린 게시물</a></li>
									</ul>
								</div>
								<!-- /.card-header -->
								<div class="card-body">
									<div class="tab-content">
										<div class="active tab-pane" id="activity">
											<!-- Post -->
											<div class="post">
												<div class="user-block">
													<img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image"> <span class="username"> <a href="userInfo">자바</a>
													</span> <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
												</div>
												<!-- /.user-block -->
												<p>게시글 내용</p>
												<div class="row mb-3">
													<div class="col-sm-6">
														<img class="img-fluid" src="${pageContext.request.contextPath}/dist/img/photo1.png" alt="Photo">
													</div>

													<div class="col-sm-6">
														<div class="row">
															<div class="col-sm-6">
																<img class="img-fluid mb-3" src="${pageContext.request.contextPath}/dist/img/photo2.png" alt="Photo"> <img class="img-fluid" src="${pageContext.request.contextPath}/dist/img/photo3.jpg" alt="Photo">
															</div>
															<!-- /.col -->
															<div class="col-sm-6">
																<img class="img-fluid mb-3" src="${pageContext.request.contextPath}/dist/img/photo4.jpg" alt="Photo"> <img class="img-fluid" src="${pageContext.request.contextPath}/dist/img/photo1.png" alt="Photo">
															</div>
															<!-- /.col -->
														</div>
														<!-- /.row -->
													</div>
												</div>
											</div>
											<!-- /.post -->
											<!-- Post -->
											<div class="post">
												<div class="user-block">
													<img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image"> <span class="username"> <a href="userInfo">자바</a>
													</span> <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
												</div>
												<!-- /.user-block -->
												<p>게시글 내용</p>
											</div>
											<!-- /.post -->
											<!-- Post -->
											<div class="post">
												<div class="user-block">
													<img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image"> <span class="username"> <a href="userInfo">자바</a>
													</span> <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
												</div>
												<!-- /.user-block -->
												<p>게시글 내용</p>
											</div>
											<!-- /.post -->
										</div>
									</div>
									<!-- /.tab-content -->
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.nav-tabs-custom -->
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

		<jsp:include page="modal/adminModal.jsp" />

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

