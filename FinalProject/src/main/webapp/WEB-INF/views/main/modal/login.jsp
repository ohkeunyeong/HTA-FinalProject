<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade" id="loginModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal body -->
			<div class="modal-body">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<br>
				<div class="container">
					<h2 class="text-center">Login</h2>
					<form action="member/loginProcess" method="post" id="loginForm" name="loginForm">
						<div class="form-group mb-2">
							<label for="id">ID:</label> <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id"> <span id="id-message"></span>
						</div>
						<div class="form-group mb-2">
							<label for="pass">Password:</label> <input type="password" class="form-control" id="pass" placeholder="Enter Password" name="pass"> <span id="pass-message"></span>
						</div>
						<div class="form-group form-check">
							<label class="form-check-label">
								<input class="form-check-input" type="checkbox" name="remember" id="remember">Remember me
							</label>
						</div>
						<button type="submit" class="btn btn-primary" style="width: 100%">Login</button>
						<p class="mt-3 mb-0 text-center">
							<span>For got <a href="#">UserID</a> / <a href="#">Password</a></span>
						</p>
						<hr>
						<p class="mt-3 mb-0 text-center">
							<a href="member/join">Create an Account!</a>
						</p>
					</form>
				</div>
			</div>

		</div>
	</div>
</div>

<div class="modal fade" id="loginFailModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h3 class="modal-title">로그인 실패</h3>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body text-center" id="loginFailModal-body"></div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>