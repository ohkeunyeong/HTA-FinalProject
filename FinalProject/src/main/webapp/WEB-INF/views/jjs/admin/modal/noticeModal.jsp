<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 공지사항 쓰기 모달창 -->
<div class="modal hide fade" id="noticeAddModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">공지사항 쓰기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="noticeAdd" method="post" name="noticeAddForm" id="noticeAddForm">
					<div class="form-group">
						<label for="notice_subject">제목</label> <input type="text" class="form-control" id="notice_subject" name="NOTICE_SUBJECT">
					</div>

					<div class="form-group">
						<label for="notice_content">내용</label>
						<textarea class="form-control" id="notice_content" name="NOTICE_CONTENT" rows="10"></textarea>
					</div>

					<div class="form-group">
						<input type="checkbox" name="NOTICE_FIX" value="FIX">&nbsp;공지사항 고정
					</div>

					<!-- 버튼 -->
					<div class="text-right">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>

<!-- 공지사항 수정 모달창 -->
<div class="modal hide fade" id="noticeModifyModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">공지사항 수정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="noticeModify" method="post" name="noticeModifyForm" id="noticeModifyForm">
					<div class="form-group">
						<label for="notice_subject">제목</label> <input type="text" class="form-control" id="noticeModify_subject" name="NOTICE_SUBJECT">
					</div>

					<div class="form-group">
						<label for="notice_content">내용</label>
						<textarea class="form-control" id="noticeModify_content" name="NOTICE_CONTENT" rows="10"></textarea>
					</div>

					<div class="form-group">
						<input type="checkbox" name="NOTICE_FIX" value="FIX" id="noticeModify_fix">&nbsp;공지사항 고정
					</div>

					<!-- 버튼 -->
					<div class="text-right">
						<button type="submit" class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>

<!-- 선택삭제 모달창 -->
<div class="modal fade" id="DeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">삭제</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>정말 삭제하시겠습니까??</h4>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="Deletebtn">삭제</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 삭제 모달창 -->
<div class="modal fade" id="noticeDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">삭제</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>정말 삭제하시겠습니까??</h4>
				<form action="noticeDelete" method="post" name="delform">
					<input type="hidden" name="num" value="${param.num }">
					<div class="modal-footer">
						<div class="text-right">
							<button type="submit" class="btn btn-danger">삭제</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 선택삭제 글 선택 안했을때 나오는 모달창 -->
<div class="modal fade" id="noSelectionModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h3 class="modal-title">선택삭제</h3>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>선택한 글이 없습니다.</h4>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- 삭제성공 모달창 -->
<div class="modal fade" id="DeleteSuccessModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">삭제</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>공지사항 글 삭제 성공</h4>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- 공지사항 유효성검사 모달 -->
<div class="modal fade" id="NoticeValidationModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">공지사항</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id="NoticeValidationModal-body">
				
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>