<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 상품삭제 모달창 -->
<div class="modal hide fade" id="productDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품 삭제</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h6>${product.product_name} 상품을 삭제하시겠습니까??</h6>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-danger" href="productDelete?code=${product.product_code}">삭제</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
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
				<h4>선택한 상품이 없습니다.</h4>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- 상품등록 모달창 -->
<div class="modal hide fade" id="productAddModal">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품등록</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="productAdd" method="post" name="productAddForm" enctype="multipart/form-data" id="productAddForm">
					<!-- 상품코드 -->
					<div class="form-group">
						<label for="product_code">상품코드</label> <input class="form-control" id="product_code" name="product_code">
					</div>

					<!-- 상품이름 -->
					<div class="form-group">
						<label for="product_name">상품이름</label> <input class="form-control" id="product_name" name="product_name">
					</div>

					<!-- 카테고리 -->
					<div class="form-group">
						<label for="category_name">카테고리</label>
						<select class="form-control" id="categorySelectModal" name="category_code">
						</select>
					</div>

					<!-- 상세정보 -->
					<div class="form-group">
						<label for="product_detail">상품상세정보</label>
						<textarea class="form-control" id="product_detail" name="product_detail"></textarea>
					</div>

					<!-- 가격 -->
					<div class="form-group">
						<label for="product_price">가격</label> <input class="form-control" id="product_price" name="product_price">
					</div>

					<!-- 이미지 -->
					<div class="form-group text-left">
						<button class="btn btn-primary" id="imgUploadbtn">이미지 첨부</button>
						<input class="form-control" type="file" id="imgUpload" name="uploadfile" accept="image/*"> <span id="imgvalue"></span> <img src="${pageContext.request.contextPath}/resources/image/jjs/remove.png" alt="이미지삭제" width="30px" class="remove">
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

<!-- 상품 유효성검사 모달 -->
<div class="modal fade" id="ProductValidationModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">상품</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id="ProductValidationModal-body">
				
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>