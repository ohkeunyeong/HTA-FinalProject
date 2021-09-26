<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
 <title>쇼핑 상세 페이지</title>
 </head>
<jsp:include page="shop_header.jsp" />

<div class="wrapper">

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">신고글 상세보기</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item"><a href="postList">게시물 관리</a></li>
              <li class="breadcrumb-item active">신고글 상세보기</li>
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
              <h3 class="card-title mt-2">신고글 제목</h3>
              <div class="float-right">
              	<span>작성자 : XXX</span>&nbsp;&nbsp;&nbsp;&nbsp;
              	<span>2021-09-23 21:43PM</span>
              </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
            	<div class="post">
            		<p class="m-3">신고글 내용</p>
            	</div>
            	<div class="post">
            		<p class="m-3">신고내용</p>
            	</div>
            </div>
            <!-- /.card-body -->
            <div class="card-footer bg-white">
              
            </div>
            <!-- /.card-footer -->
            <div class="card-footer">
            	<span>게시판 종류</span>
            	<div class="float-right">
              		<button type="button" class="btn btn-default"><i class="far fa-trash-alt"></i> 신고글 삭제</button>
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

  <jsp:include page="../../main/footer.jsp" />
</div>
<!-- ./wrapper -->
</body>
</html>

