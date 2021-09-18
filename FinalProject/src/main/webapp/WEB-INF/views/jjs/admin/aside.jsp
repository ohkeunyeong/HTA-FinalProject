<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.aside{
		width : 280px;
		font-size : 30px;
		float : left;
	}
	
	.list-group-item{
		margin-bottom : 60px;
	}
	
	.list-group-item+.list-group-item{
		border-top-width : 1px;
	}
	
	a{
		color : black;
	}
</style>
<div class="p-3 aside">
	<a href="#" class="text-dark p-3"><span>Admin</span></a>
	<hr>
	<ul class="list-group">
		<li class="list-group-item list-group-item-action">
			<a href="${pageContext.servletContext.contextPath}/admin/userlist"><i class="fas fa-users"></i>&nbsp;&nbsp;회원목록</a>
		</li>
		<li class="list-group-item list-group-item-action">
			<a href="#"><i class="fas fa-clipboard p-2"></i>&nbsp;&nbsp;게시물 관리</a>
		</li>
		<li class="list-group-item list-group-item-action">
			<a href="#"><i class="fas fa-store"></i>&nbsp;&nbsp;주말장터 관리</a>
		</li>
		<li class="list-group-item list-group-item-action">
			<a href="#"><i class="fas fa-tractor"></i>&nbsp;&nbsp;농장목록</a>
		</li>
		<li class="list-group-item list-group-item-action">
			<a href="#"><i class="far fa-credit-card"></i>&nbsp;&nbsp;결제목록</a>
		</li>
	</ul>
</div>