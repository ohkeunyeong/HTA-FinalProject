<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 삭제 모달창 -->
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
				<h6>javas님을 삭제하시겠습니까??</h6>
			</div>
        
			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-danger" href="#">삭제</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
        
		</div>
	</div>
</div>

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
				<form action="#">
					<div class="form-group">
						<label for="notice_subject">제목</label>
						<input type="text" class="form-control" id="notice_subject" name="notice_subject">
					</div>
					
					<div class="form-group">
						<label for="notice_content">내용</label>
						<textarea class="form-control" id="notice_content" 
						name="notice_content"></textarea>
					</div>
					
					<div class="form-group">
						<input type="checkbox" name="fix">&nbsp;공지사항 고정
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