<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
	<!-- Brand Logo -->
	<a href="${pageContext.request.contextPath}/main" class="brand-link"> <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8; background-color: white;"> <span class="brand-text font-weight-light">주말 농장</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
			<div class="image">
				<img src="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3">
			</div>
			<div class="info">
				<a href="${pageContext.request.contextPath}/admin/main" class="d-block">Admin</a>
			</div>
		</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
				<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
				<li class="nav-item has-treeview menu-open"><a href="#" class="nav-link active"> <i class="nav-icon fas fa-align-justify"></i>
						<p>
							Admin Pages <i class="right fas fa-angle-left"></i>
						</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="userList" class="nav-link"> <i class="nav-icon fas fa-users"></i>
								<p>회원목록</p>
						</a></li>

						<li class="nav-item"><a href="postList" class="nav-link"> <i class="nav-icon fas fa-clipboard"></i>
								<p>게시물관리</p>
						</a></li>

						<li class="nav-item"><a href="productList" class="nav-link"> <i class="nav-icon fas fa-store"></i>
								<p>주말장터관리</p>
						</a></li>

						<li class="nav-item"><a href="farmList" class="nav-link"> <i class="nav-icon fas fa-tractor"></i>
								<p>농장목록</p>
						</a></li>

						<li class="nav-item"><a href="orderList" class="nav-link"> <i class="nav-icon far fa-credit-card"></i>
								<p>결제목록</p>
						</a></li>
					</ul></li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>