<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<jsp:include page="include/head.jsp" />
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
            <h1 class="m-0 text-dark">공지사항 상세보기</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item"><a href="postList">게시물 관리</a></li>
              <li class="breadcrumb-item active">공지사항 상세보기</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title mt-2">공지사항 제목</h3>
              <div class="float-right">
              	<span>2021-09-23 21:43PM</span>&nbsp;&nbsp;&nbsp;&nbsp;
              	<span>조회수 : 10</span>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
            	<div class="post">
            		<p class="m-3">공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용공지사항 내용</p>
            	</div>
            </div>
            <!-- /.card-body -->
            <div class="card-footer bg-white">
              
            </div>
            <!-- /.card-footer -->
            <div class="card-footer">
            	<div class="float-right">
              		<button type="button" class="btn btn-default"><i class="far fa-edit"></i> 수정</button>&nbsp;&nbsp;
              		<button type="button" class="btn btn-default"><i class="far fa-trash-alt"></i> 삭제</button>
              	</div>
            </div>
            <!-- /.card-footer -->
          </div>
          <!-- /.card -->
        </div>
          
          
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
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
