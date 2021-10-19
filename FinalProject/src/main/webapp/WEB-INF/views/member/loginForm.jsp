<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../main/header.jsp" />
<meta charset="UTF-8">
<title>주말농장 - 로그인</title>
<link href="${pageContext.request.contextPath}/resources/css/jjs/login.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jjs/login.js"></script>
<script>
	$(function(){
		if('${result}' == '-1'){
			$('#loginFailModal').modal({backdrop: 'static', keyboard: false});
			$('#loginFailModal-body').html("<h4>아이디가 존재하지 않습니다.</h4>");
		}
		
		if('${result}' == '0'){
			$('#loginFailModal').modal({backdrop: 'static', keyboard: false});
			$('#loginFailModal-body').html("<h4>비밀번호가 틀렸습니다.</h4>");
		}
	});
</script>
</head>
<body>
	<div class="main-loginFrom">
		<h2 class="text-center">주말장터 로그인</h2>
		<form action="${pageContext.request.contextPath}/member/loginProcess" method="post" id="loginForm" name="loginForm">
			<div class="form-group mb-2">
				<label for="id">아이디:</label> <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id"
					<c:if test="${!empty saveid}">
						value="${saveid}"
					</c:if>> 
				<span id="id-message"></span>
			</div>
			<div class="form-group mb-2">
				<label for="pass">비밀번호:</label> <input type="password" class="form-control" id="pass" placeholder="Enter Password" name="pass"> <span id="pass-message"></span>
			</div>
			<div class="form-group form-check">
				<label class="form-check-label"> <input class="form-check-input" type="checkbox" name="remember" id="remember" 
					<c:if test="${!empty saveid}">
						checked
					</c:if>>Remember me
				</label>
			</div>
			<button type="submit" class="btn btn-primary" style="width: 100%">로그인</button>
			<p class="mt-3 mb-0 text-center">
				<a href="${pageContext.request.contextPath}/member/find">아이디찾기/비밀번호찾기</a>
			</p>
			<hr>
			<p class="mt-3 mb-0 text-center">
				<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
			</p>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>