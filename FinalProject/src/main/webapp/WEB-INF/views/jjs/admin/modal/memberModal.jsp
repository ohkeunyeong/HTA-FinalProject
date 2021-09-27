<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원삭제 모달창 -->
<div class="modal hide fade" id="userDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회원 삭제</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h6>${memberInfo.nick}님을 삭제하시겠습니까??</h6>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-danger" href="userDelete?id=${memberInfo.id}">삭제</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>