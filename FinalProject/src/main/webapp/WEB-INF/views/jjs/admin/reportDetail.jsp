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
							<h1 class="m-0 text-dark">신고글 상세보기</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item"><a href="farmPostList">게시물 관리</a></li>
								<li class="breadcrumb-item active">신고글 상세보기</li>
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
						<div class="col-md-12">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title mt-2">제목 : ${reportdetail.board_subject}</h3>
									<div class="float-right">
										<span>작성자 : ${reportdetail.board_nickname}</span>&nbsp;&nbsp;&nbsp;&nbsp; 신고날짜 : <span>${reportdetail.report_date}</span>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<div class="post">
										<p class="m-3">내용 : ${reportdetail.board_content}</p>
									</div>
									<div class="post">
										<p class="m-3">신고내용 : ${reportdetail.report_content}</p>
									</div>
								</div>
								<!-- /.card-body -->
								<div class="card-footer bg-white"></div>
								<!-- /.card-footer -->
								<div class="card-footer">
									<c:if test="${reportdetail.board_table == 'jik'}">
										<span>직거래게시판</span>
									</c:if>
									<c:if test="${reportdetail.board_table == 'free'}">
										<span>자유게시판</span>
									</c:if>
									<c:if test="${reportdetail.board_table == 'work'}">
										<span>인력게시판</span>
									</c:if>
									<c:if test="${reportdetail.board_table == 'qb'}">
										<span>궁금해요게시판</span>
									</c:if>
									<div class="float-right">
										<button type="button" class="btn btn-default" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#reportDeleteModal">
											<i class="far fa-trash-alt"></i> 신고글 삭제
										</button>
									</div>
								</div>
								<!-- /.card-footer -->
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

		<div class="modal fade" id="reportDeleteModal">
			<div class="modal-dialog modal-sm modal-dialog-centered">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header text-center">
						<h2 class="modal-title">신고글 삭제</h2>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<h5>신고글 삭제하시겠습니까??</h5>
						<form action="reportDelete" method="post" name="delform">
							<input type="hidden" name="report_num" value="${param.num }">
							<input type="hidden" name="board_table" value="${param.table}">
							<input type="hidden" name="board_num" value="${reportdetail.board_num}">
							<div class="modal-footer">
								<div class="text-right">
									<button type="submit" class="btn btn-danger">삭제</button>
									<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

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

