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
            <h1 class="m-0 text-dark">게시물 관리</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item"><a href="postList">게시물 관리</a></li>
              <li class="breadcrumb-item active">공지사항</li>
            </ol>
          </div><!-- /.col -->
          <div class="h3" style="margin : 0 auto;">
             <a href="postList">공지사항</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <a href="farmPostList">농장모듬</a>
          </div>
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">공지사항</h3>

                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input type="text" name="table_search" class="form-control float-right" placeholder="제목 입력">
                  </div>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body table-responsive p-0" style="height: 480px;">
                <table class="table table-head-fixed text-nowrap">
                  <thead>
                    <tr>
                      <th><input type="checkbox" id="allCheck"></th>
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성일</th>
                      <th>조회수</th>
                      <th>고정유무</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="noticeDetail">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정해제</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td><a href="#">공지사항</a></td>
                      <td>2021-09-23</td>
                      <td>10</td>
                      <td><button class="btn btn-primary">고정</button></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            <div class="mb-3">
            	<button class="btn btn-danger">선택삭제</button>
            	<button class="btn btn-primary float-right" data-toggle="modal" data-target="#noticeAddModal">공지사항 쓰기</button>
            </div>
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
   </div>
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

