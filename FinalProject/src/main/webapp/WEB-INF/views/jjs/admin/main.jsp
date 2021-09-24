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
            <h1 class="m-0 text-dark">관리자 페이지</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item active">관리자 페이지</li>
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
          <div class="container-fluid">
            <div class="card card-primary">
              <div class="card-header">
                <span>회원목록</span>
                <a class="float-right" href="userList">더보기></a>
              </div>
              <div class="card-body">
                <table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>닉네임</th>
						<th>내농장</th>
						<th>회원등급</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>자바</td>
						<td><a href="userInfo">javas</a></td>
						<td>JavaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
					</tr>
					<tr>
						<td>스프링</td>
						<td><a href="userInfo">Spring</a></td>
						<td>SpringS</td>
						<td></td>
						<td>일반멤버</td>
					</tr>
				</tbody>
				</table>
              </div>
            </div>
          </div>
          
          <!-- /.col-md-6 -->
          <div class="col-lg-6">
            <div class="card card-primary">
              <div class="card-header">
                <span>게시물 관리</span>
                <a class="float-right" href="postList">더보기></a>
              </div>
              <div class="card-body">
                <table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>신고번호</th>
							<th>신고글 제목</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>신고글 제목</td>
							<td>스프링</td>
						</tr>
						<tr>
							<td>2</td>
							<td>신고글 제목</td>
							<td>자바</td>
						</tr>
					</tbody>
				</table>
              </div>
            </div>
            
            <div class="card card-primary">
              <div class="card-header">
                <span>농장목록</span>
                <a class="float-right" href="farmList">더보기></a>
              </div>
              <div class="card-body">
                <table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>농장이름</th>
							<th>관리자이름</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>JavaFarm</td>
							<td>자바</td>
						</tr>
						<tr>
							<td>SpringFarm</td>
							<td>스프링</td>
						</tr>
					</tbody>
				</table>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="card card-primary">
              <div class="card-header">
                <span>주말장터 관리</span>
                <a class="float-right" href="productList">더보기></a>
              </div>
              <div class="card-body">
                <table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>상품이름</th>
							<th>카테고리</th>
							<th>상품가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>곡괭이</td>
							<td>농장용품</td>
							<td>1,000원</td>
						</tr>
						<tr>
							<td>이모티콘</td>
							<td>굿즈</td>
							<td>10원</td>
						</tr>
					</tbody>
				</table>
              </div>
            </div>
            
            <div class="card card-primary">
              <div class="card-header">
                <span>주문목록</span>
                <a class="float-right" href="orderList">더보기></a>
              </div>
              <div class="card-body">
                <table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>주문번호</th>
							<th>결제자</th>
							<th>주문가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>곡괭이</td>
							<td>자바</td>
							<td>1,000원</td>
						</tr>
						<tr>
							<td>이모티콘</td>
							<td>스프링</td>
							<td>10원</td>
						</tr>
					</tbody>
				</table>
              </div>
            </div>
          </div>
          <!-- /.col-md-6 -->
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

