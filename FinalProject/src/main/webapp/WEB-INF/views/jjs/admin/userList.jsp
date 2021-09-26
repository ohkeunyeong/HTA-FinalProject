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
<script src="${pageContext.request.contextPath}/resources/js/jjs/userList.js"></script>
<style>
.gray {
	color: gray
}

a:not([href]) {
	color: gray;
	text-decoration: none;
}

#myNongList{
	width: 150px; 
	position: absolute; 
	right: 10px; 
	bottom: 12px;
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
							<h1 class="m-0 text-dark">회원목록</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item active">회원목록</li>
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
									<h3 class="card-title">회원수 : ${listcount}</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm" style="width: 150px;">
											<input type="text" name="search_word" id="search_word" class="form-control float-right" placeholder="아이디 입력">
										</div>
									</div>
								</div>
								<!-- /.card-header -->
								<c:if test="${listcount > 0 }">
									<div class="card-body table-responsive p-0" style="height: 395px;">
										<table class="table table-head-fixed text-nowrap">
											<thead>
												<tr>
													<th>이름</th>
													<th>아이디</th>
													<th>닉네임</th>
													<th>내농장</th>
													<th>회원등급</th>
													<th>이메일</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="m" items="${userlist}">
													<tr>
														<td>
															<div>${m.name}</div>
														</td>
														<td>
															<div>
																<a href="userInfo?id=${m.id}">${m.id}</a>
															</div>
														</td>
														<td>
															<div>${m.nick}</div>
														</td>
														<td>
															<div>${m.mynong_name}</div>
														</td>
														<td>
															<c:if test="${m.my_farm == '0' }">
																<div>일반멤버</div>
															</c:if>
															<c:if test="${m.my_farm == '1' }">
																<div>농장 관리자</div>
															</c:if>
															<c:if test="${m.my_farm == '2' }">
																<div>농장멤버</div>
															</c:if>
														</td>
														<td>
															<div>${m.mail}</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
									<!-- /.card-body -->
									<div class="card-footer clearfix">
										<ul class="pagination m-0 justify-content-center">
											<c:if test="${page <= 1 }">
												<li class="page-item"><a class="page-link gray">«</a></li>
											</c:if>
											<c:if test="${page > 1 }">
												<li class="page-item"><a href="userList?page=${page-1}" class="page-link">«</a></li>
											</c:if>

											<c:forEach var="a" begin="${startpage}" end="${endpage}">
												<c:if test="${a == page }">
													<li class="page-item "><a class="page-link gray">${a}</a></li>
												</c:if>
												<c:if test="${a != page }">
													<li class="page-item"><a href="userList?page=${a}" class="page-link">${a}</a></li>
												</c:if>
											</c:forEach>

											<c:if test="${page >= maxpage }">
												<li class="page-item"><a class="page-link gray">»</a></li>
											</c:if>
											<c:if test="${page < maxpage }">
												<li class="page-item"><a href="userList?page=${page+1}" class="page-link">»</a></li>
											</c:if>
										</ul>
									</div>
								</c:if>

								<c:if test="${listcount == 0 }">
									<p class="text-center h2 mt-3 mb-3">
										<span>등록된 회원이 없습니다.</span>
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

