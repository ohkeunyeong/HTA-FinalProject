<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 농장 초대</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="//t1.daumcdn.net/cafe_cj/pcweb/build/css/2009/popup-a877b185d4.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/member_inviteForm.css"></link>
<script src="${pageContext.request.contextPath}/resources/js/oky/member_inviteForm.js"></script>
</head>
<body>
	<form name="form" action="inviteProcess" method="post">
		<input type="hidden" class="pan" id="pan" value="ok" name="invite">
		<div class="pop_title">
			<h2>
				<span style="color: red; font-size: 14px;"> ${name} </span> 농장으로 부터
				초대되었습니다.
			</h2>
		</div>
		<div class="pop_content">
			<!-- pop_content -->
			안녕하세요 <span style="color: blue; font-size: 18px;"> <b>${list.nick}</b></span>
			님!<br /> 저희 농장으로 초대합니다!<br />
			<br />
			<!-- pop_content end -->
		</div>

		<div class="pop_btn">
			<button class="botao medio azul" id="ok">수락</button>
			<button class="botao medio vermelho" id="no">거절</button>
		</div>
	</form>
</body>
</html>