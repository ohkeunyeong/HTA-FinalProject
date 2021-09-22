<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>주말농장 - 관리자페이지(게시물 관리)</title>
		<style>
			#container-noticelist{
				position : relative;
				margin-left : 280px;
			}
			
			.table{
				font-size : 20px;
			}
			
			#noticeCount{
				font-size : 30px;
			}
			
			#searchNotice{
				margin : 0 auto;
			}
			
			#notice_content{
				resize : none;
			}
		</style>
	</head>
	<body>
		<jsp:include page="../../main/header.jsp" />
		<jsp:include page="aside.jsp" />
		<div class="container mt-3" id="container-noticelist">
			<h1>게시물 관리</h1>
			<hr>
			<form action="postlist" method="post">
				<div class="input-group w-50" id="searchNotice">
					<select id="viewcount" name="search_field">
						<option value="0" selected>제목</option>
					</select>
					<input name="search_word" type="text" class="form-control"
						   placeholder="제목 입력하세요" value="${search_word}">
					<button class="btn btn-primary" type="submit">검색</button>
				</div>
			</form>
			
			<span id="noticeCount">글 개수 : N개</span>
			
			<table class="table table-striped table-bordered text-center">
				<thead>
					<tr>
						<th class="align-middle">전체 선택<br><input type="checkbox" id="allCheck"></th>
						<th class="align-middle">번호</th>
						<th class="align-middle">제목</th>
						<th class="align-middle">작성일</th>
						<th class="align-middle">조회수</th>
						<th class="align-middle">고정유무</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" id="rowCheck"></td>
						<td>1</td>
						<td>공지사항</td>
						<td>2021-09-22</td>
						<td>3</td>
						<td><button class="btn btn-info" name="fix" id="fixbtn">고정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="rowCheck"></td>
						<td>1</td>
						<td>공지사항</td>
						<td>2021-09-22</td>
						<td>3</td>
						<td><button class="btn btn-info" name="fix">고정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="rowCheck"></td>
						<td>1</td>
						<td>공지사항</td>
						<td>2021-09-22</td>
						<td>3</td>
						<td><button class="btn btn-info" name="fix">고정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="rowCheck"></td>
						<td>1</td>
						<td>공지사항</td>
						<td>2021-09-22</td>
						<td>3</td>
						<td><button class="btn btn-info" name="fix">고정</button></td>
					</tr>
					<tr>
						<td><input type="checkbox" id="rowCheck"></td>
						<td>1</td>
						<td>공지사항</td>
						<td>2021-09-22</td>
						<td>3</td>
						<td><button class="btn btn-info" name="fix">고정</button></td>
					</tr>
				</tbody>
			</table>
			<button class="btn btn-danger" id="selectionDelbtn">선택삭제</button>
			<button class="btn btn-primary float-right" id="noticeAddbtn" data-toggle="modal" data-target="#noticeAddModal">공지사항 쓰기</button>
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