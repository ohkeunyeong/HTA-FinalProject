<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>주말농장 - 관리자 페이지</title>
		<style>
			#container-main{
				height : 715px;
				position : relative;
				margin-left : 280px;
				width : 82%;
			}
			
			.container-main_list{
				color : black;
				font-size : 30px;
				margin-top : 10px;
			}
			
			.container-main_list > a{
				float : right;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../../main/header.jsp" />
		<jsp:include page="aside.jsp" />
		<div class="container-fluid" id="container-main">
			<p class="container-main_list"><span>회원목록</span><a href="${pageContext.servletContext.contextPath}/admin/userlist">더보기></a></p>
			<hr>
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>닉네임</th>
						<th>내농장</th>
						<th>회원등급</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>javas</td>
						<td>자바</td>
						<td>JavaSCR</td>
						<td>JavaFarm</td>
						<td>농장멤버</td>
					</tr>
					<tr>
						<td>Spring</td>
						<td>스프링</td>
						<td>SpringS</td>
						<td></td>
						<td>일반멤버</td>
					</tr>
				</tbody>
			</table>
			
			<div style="width : 49%; float : left;">
				<p class="container-main_list"><span>게시물 관리</span><a href="#">더보기></a></p>
				<hr>
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
				
			<div style="width : 49%; float : right;">
				<p class="container-main_list"><span>주말장터 관리</span><a href="#">더보기></a></p>
				<hr>
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
			<div style="width : 49%; float : left;">
				<p class="container-main_list"><span>농장목록</span><a href="#">더보기></a></p>
				<hr>
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
				
			<div style="width : 49%; float : right;">
				<p class="container-main_list"><span>주문목록</span><a href="#">더보기></a></p>
				<hr>
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
		<jsp:include page="footer.jsp" />
	</body>
</html>