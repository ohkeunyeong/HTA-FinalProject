<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>주말농장 - 관리자페이지(회원상세정보)</title>
		<style>
			#container-userinfo{
				position : relateve;
				margin-left : 280px;
				width : 50%;
				margin : 0 auto;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../../main/header.jsp" />
		<jsp:include page="aside.jsp" />
		<div class="container mt-3" id="container-userinfo">
			<h1>회원상세정보</h1>
			<div class="form-group text-left">
				<label for="id">아이디</label>
				<input type="text" class="form-control"
					   id="id" name="id" value="javas" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="name">이름</label>
				<input type="text" class="form-control"
					   id="name" name="name" value="자바" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="nick">닉네임</label>
				<input type="text" class="form-control"
					   id="nick" name="nick" value="javaSC" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="email">이메일</label>
				<input type="text" class="form-control"
					   id="email" name="email" value="javas@naver.com" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="tel">전화번호</label>
				<input type="text" class="form-control"
					   id="tel" name="tel" value="010-1111-1111" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="farmName">농장이름</label>
				<input type="text" class="form-control"
					   id="farmName" name="farmName" value="javas" readOnly>
			</div>
			
			<div class="form-group text-left">
				<label for="grade">회원등급</label>
				<input type="text" class="form-control"
					   id="grade" name="grade" value="농장멤버" readOnly>
			</div>
			
			<div class="text-right mb-4">	
				<a type="button" class="btn btn-info" href="userlist">목록</a>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
	</body>
</html>