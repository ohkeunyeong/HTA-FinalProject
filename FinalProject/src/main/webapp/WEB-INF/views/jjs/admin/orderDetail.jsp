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
  <div class="content-wrapper" style="min-height: 1419.6px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>주문 상세정보</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item"><a href="orderList">주문목록</a></li>
              <li class="breadcrumb-item active">주문 상세정보</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">

            <!-- Profile Image -->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
              
                <ul class="list-group list-group-unbordered mb-3 h3">
                  <li class="list-group-item">
                    <b>주문번호</b> <a class="float-right">210924_332142</a>
                  </li>
                  <li class="list-group-item">
                    <b>수령인</b> <a class="float-right">홍길동</a>
                  </li>
                  <li class="list-group-item">
                    <b>전화번호</b> <a class="float-right">010-1111-1111</a>
                  </li>
                  <li class="list-group-item">
                    <b>주소</b> <a class="float-right">331-213 서울특별시 종로구 종로3가</a>
                  </li>
                  <li class="list-group-item">
                    <b>주문가격</b> <a class="float-right">1,000원</a>
                  </li>
                  <li class="list-group-item">
                    <b>결제일</b> <a class="float-right">21-09-24</a>
                  </li>
                </ul>

              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            
          </div>
          <!-- /.col -->
          <div class="col-md-12">
            <div class="card">
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="activity">
                    <!-- Post -->
                    <div class="post">
                      <div class="user-block">
                        <img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image">
                        <span class="username">
                          <a href="userInfo">자바</a>
                        </span>
                        <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
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
                              <img class="img-fluid mb-3" src="${pageContext.request.contextPath}/dist/img/photo2.png" alt="Photo">
                              <img class="img-fluid" src="${pageContext.request.contextPath}/dist/img/photo3.jpg" alt="Photo">
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-6">
                              <img class="img-fluid mb-3" src="${pageContext.request.contextPath}/dist/img/photo4.jpg" alt="Photo">
                              <img class="img-fluid" src="${pageContext.request.contextPath}/dist/img/photo1.png" alt="Photo">
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
                        <img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image">
                        <span class="username">
                          <a href="userInfo">자바</a>
                        </span>
                        <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
                      </div>
                      <!-- /.user-block -->
                      <p>게시글 내용</p>
                    </div>
                    <!-- /.post -->
                    <!-- Post -->
                    <div class="post">
                      <div class="user-block">
                        <img class="img-circle img-bordered-sm" src="${pageContext.request.contextPath}/dist/img/user1-128x128.jpg" alt="user image">
                        <span class="username">
                          <a href="userInfo">자바</a>
                        </span>
                        <span class="description">2021-09-23 19:08 PM 속해있는 게시판 종류</span>
                      </div>
                      <!-- /.user-block -->
                      <p>게시글 내용</p>
                    </div>
                    <!-- /.post -->
                </div>
                </div><!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
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

