<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <style>
  	textarea{
  		resize : none;
  	}
  	
  	input[type="file"]{
  		display: none;
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
            <h1 class="m-0 text-dark">주말장터 관리</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="main">Home</a></li>
              <li class="breadcrumb-item active">주말장터 관리</li>
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
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title mt-2">주말장터 관리</h3>
                <select class="form-control float-right" style="width : 150px;">
					<option>카테고리명</option>
					<option value="1">퍼스나콘</option>
					<option value="2">굿즈</option>
					<option value="3">농기구</option>
    			</select>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
              	<div class="input-group float-right" style="width : 400px;">
					<select id="productinfo" name="search_field">
				       <option value="0" selected>상품이름</option>
				       <option value="1">상품코드</option>
				       <option value="2">카테고리명</option>
				    </select>
				     <input name="search_word" type="text" class="form-control"
				            placeholder="상품이름 입력하세요" value="${search_word}" id="search_word">
				     <button id="search" class="btn btn-primary" type="submit">검색</button>
				</div>
              	<button class="btn btn-primary mb-3" data-toggle="modal" data-target="#productAddModal">상품등록</button>
                <table class="table table-bordered text-center">
                  <thead>                  
                    <tr>
                      <th><input type="checkbox"></th>
                      <th>상품 이미지</th>
                      <th>상품명</th>
                      <th>상품코드</th>
                      <th>카테고리명</th>
                      <th>상품등록일</th>
                      <th>수정</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td class="align-middle"><input type="checkbox"></td>
                      <td class="align-middle"><img src="${pageContext.request.contextPath}/resources/image/jjs/among us.png" style="width : 85px; height : 70px;"></td>
                      <td class="align-middle"><a href="productDetail">상품이름</a></td>
                      <td class="align-middle">A001</td>
                      <td class="align-middle">굿즈</td>
                      <td class="align-middle">21-09-24</td>
                      <td class="align-middle"><button class="btn btn-info" data-toggle="modal" data-target="#productModifyModal">수정</button></td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td><img src="${pageContext.request.contextPath}/resources/image/logo.png" style="width : 100px; height : 30px;"></td>
                      <td>상품이름</td>
                      <td>A001</td>
                      <td>굿즈</td>
                      <td>21-09-24</td>
                      <td>수정</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td><img src="${pageContext.request.contextPath}/resources/image/logo.png" style="width : 100px; height : 30px;"></td>
                      <td>상품이름</td>
                      <td>A001</td>
                      <td>굿즈</td>
                      <td>21-09-24</td>
                      <td>수정</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td><img src="${pageContext.request.contextPath}/resources/image/logo.png" style="width : 100px; height : 30px;"></td>
                      <td>상품이름</td>
                      <td>A001</td>
                      <td>굿즈</td>
                      <td>21-09-24</td>
                      <td>수정</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td><img src="${pageContext.request.contextPath}/resources/image/logo.png" style="width : 100px; height : 30px;"></td>
                      <td>상품이름</td>
                      <td>A001</td>
                      <td>굿즈</td>
                      <td>21-09-24</td>
                      <td>수정</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td><img src="${pageContext.request.contextPath}/resources/image/jjs/among us.png" style="width : 100px; height : 30px;"></td>
                      <td>상품이름</td>
                      <td>A001</td>
                      <td>굿즈</td>
                      <td>21-09-24</td>
                      <td>수정</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
              <div class="card-footer clearfix">
              	<button class="btn btn-danger">선택삭제</button>
                <ul class="pagination pagination-sm m-0 float-right">
                  <li class="page-item"><a class="page-link" href="#">«</a></li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">»</a></li>
                </ul>
              </div>
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

