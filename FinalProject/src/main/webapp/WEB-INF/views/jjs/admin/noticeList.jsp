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
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jjs/noticeList.js"></script>
<style>
textarea {
	resize: none;
}

.gray{color:gray}

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
							<h1 class="m-0 text-dark">게시물 관리</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="main">Home</a></li>
								<li class="breadcrumb-item"><a href="noticeList">게시물 관리</a></li>
								<li class="breadcrumb-item active">공지사항</li>
							</ol>
						</div>
						<!-- /.col -->
						<div class="h3" style="margin: 0 auto;">
							<a href="noticeList">공지사항</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="reportList">농장모듬</a>
						</div>
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
									<h3 class="card-title">공지사항 글 개수 : ${listcount}</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm" style="width: 150px;">
											<input type="text" id="search_word" name="search_word" class="form-control float-right" placeholder="제목 입력">
										</div>
									</div>
								</div>
								<!-- /.card-header -->
								<c:if test="${listcount > 0}">
									<div class="card-body table-responsive p-0" style="height: 490px;">
										<table class="table table-head-fixed text-nowrap">
											<thead>
												<tr>
													<th><input type="checkbox" id="allCheck" name="allCheck"></th>
													<th>번호</th>
													<th>제목</th>
													<th>작성일</th>
													<th>조회수</th>
													<th>고정유무</th>
												</tr>
											</thead>
											<tbody>
												<c:set var="num" value="${listcount-(page-1)*limit}" />
												<c:forEach items="${noticelist}" var="n">
													<tr>
														<td>
															<input name="RowCheck" type="checkbox" value="${n.NOTICE_NUM}">
														</td>
														<td>
															<c:out value="${num}" />
															<c:set var="num" value="${num - 1}" />
														</td>
														<td>
															<div>
																<a href="noticeDetail?num=${n.NOTICE_NUM}"> <c:out value="${n.NOTICE_SUBJECT}" escapeXml="true" />
																</a>
															</div>
														</td>
														<td>
															<div>${n.NOTICE_DATE}</div>
														</td>
														<td>
															<div>${n.NOTICE_READCOUNT}</div>
														</td>
														<td>
															<div>
																<c:if test="${n.NOTICE_FIX eq 'FIX'}">
																	<button class="btn btn-primary fixbtn" value="" name="NOTICE_FIX" data-num="${n.NOTICE_NUM}">고정해제</button>
																</c:if>
																<c:if test="${empty n.NOTICE_FIX}">
																	<button class="btn btn-primary fixbtn" value="FIX" name="NOTICE_FIX" data-num="${n.NOTICE_NUM}">고정</button>
																</c:if>
															</div>
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
												<li class="page-item"><a href="noticeList?page=${page-1}" class="page-link">«</a></li>
											</c:if>

											<c:forEach var="a" begin="${startpage}" end="${endpage}">
												<c:if test="${a == page }">
													<li class="page-item "><a class="page-link gray">${a}</a></li>
												</c:if>
												<c:if test="${a != page }">
													<li class="page-item"><a href="noticeList?page=${a}" class="page-link">${a}</a></li>
												</c:if>
											</c:forEach>

											<c:if test="${page >= maxpage }">
												<li class="page-item"><a class="page-link gray">»</a></li>
											</c:if>
											<c:if test="${page < maxpage }">
												<li class="page-item"><a href="noticeList?page=${page+1}" class="page-link">»</a></li>
											</c:if>
										</ul>
									</div>
								</c:if>

								<c:if test="${listcount == 0 || empty listcount}">
									<p class="text-center h2 mt-3 mb-3"><span>등록된 글이 없습니다.</span></p>
								</c:if>

							</div>
							<!-- /.card -->
							<div class="btn_group">
								<c:if test="${listcount > 0}">
									<button class="btn btn-danger selectionDelete">선택삭제</button>
								</c:if>
								<button class="btn btn-primary float-right mb-3" data-toggle="modal" 
										data-backdrop="static" data-keyboard="false" 
										data-target="#noticeAddModal">공지사항 쓰기</button>
							</div>
						</div>
						<!-- /.row -->
					</div>
					<!-- /.container-fluid -->
				</div>
				<!-- /.content -->
			</div>
		</div>
		<!-- /.content-wrapper -->

		<jsp:include page="modal/noticeModal.jsp" />

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

