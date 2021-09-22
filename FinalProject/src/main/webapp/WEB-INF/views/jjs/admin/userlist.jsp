<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>주말농장 - 관리자페이지(회원목록)</title>
		<style>
			#container-userlist{
				position : relative;
				margin-left : 280px;
			}
			
			.table{
				font-size : 20px;
			}
			
			#selectUser{
				float : right;
				width : 10%;
			}
			
			#userCount{
				font-size : 30px;
			}
			
			#searchUser{
				margin : 0 auto;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../../main/header.jsp" />
		<jsp:include page="aside.jsp" />
		<div class="container mt-3" id="container-userlist">
			<h1>회원목록</h1>
			<hr>
			<form action="userlist" method="post">
				<div class="input-group w-50" id="searchUser">
					<select id="viewcount" name="search_field">
						<option value="0" selected>이름</option>
						<option value="1">아이디</option>
						<option value="2">이메일</option>
						<option value="3">농장이름</option>
					</select>
					<input name="search_word" type="text" class="form-control"
						   placeholder="이름 입력하세요" value="${search_word}">
					<button class="btn btn-primary" type="submit">검색</button>
				</div>
			</form>
			
			<span id="userCount">회원 수 : N명</span>
			
			<select class="form-control" id="selectUser">
				<option value="0">일반멤버</option>
				<option value="1">농장멤버</option>
				<option value="2">농장관리자</option>
			</select>
			<table class="table table-striped table-bordered text-center">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>농장이름</th>
						<th>회원등급</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><a href="userInfo">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger" data-toggle="modal" data-target="#userDeleteModal">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
					<tr>
						<td><a href="#">javas</a></td>
						<td>자바</td>
						<td>javaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
						<td><button class="btn btn-danger">삭제</button></td>
					</tr>
				</tbody>
			</table>
			<ul class="pagination justify-content-center mt-2">
				<li class="page-item"><a class="page-link" href="javascript:void(0);">이전</a></li>
				<li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
				<li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
				<li class="page-item"><a class="page-link" href="javascript:void(0);">다음</a></li>
			</ul>
			
			<jsp:include page="modal/adminModal.jsp" />
		</div>
		<jsp:include page="footer.jsp" />
	</body>
</html>