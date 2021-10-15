<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 장바구니 삭제 모달창 -->
<div class="modal hide fade" id="CartDeleteModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h5>선택하신 상품을 삭제하시겠습니까?</h5>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="cartmodaldelbtn">삭제</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>

<!-- 주문 정보 입력 모달창 -->
<div class="modal fade" id="OrderInfoModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">주문 정보 입력</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="/project/cart/order" id="OrderForm" method="post" name="OrderFrom">
					<input type="hidden" value="${id}" name="id"> 
					<input type="hidden" value="" name="pricesum"> 
					<input type="hidden" value="" name="cartNumArr">

					<!-- 수령인 -->
					<div class="form-group text-left">
						<label for="order_name">수령인</label> <input type="text" class="form-control" id="order_name" name="order_name" placeholder="수령인 입력">
					</div>

					<!-- 수령인 연락처 -->
					<div class="form-group text-left">
						<label for="order_phone">수령인 연락처</label> <input type="text" class="form-control" id="order_phone" name="order_phone" placeholder="ex) 010-XXXX-XXXX">
					</div>

					<!-- 우편번호 -->
					<div class="form-group text-left">
						<label for="order_address1">우편번호</label>
						<div class="input-group">
							<input type="text" class="form-control" id="order_address1" name="order_address1" readOnly> <input type="button" class="btn btn-info" id="postsearchbtn" value="주소 검색">
						</div>
					</div>

					<!-- 주소 -->
					<div class="form-group text-left">
						<label for="order_address2">주소</label> <input type="text" class="form-control" id="order_address2" name="order_address2" readOnly>
					</div>

					<!-- 상세 주소 -->
					<div class="form-group text-left">
						<label for="order_address3">상세 주소</label> <input type="text" class="form-control" id="order_address3" name="order_address3" placeholder="상세주소 입력">
					</div>

					<!-- 결제 방식 -->
					<div class="form-group text-center">
						<div>
							<h4>결제 방식</h4>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label" for="creditcardPayment"> <input type="radio" class="form-check-input" id="creditcardPayment" name="order_payment" value="카드결제" checked readonly>카드결제
							</label>
						</div>
					</div>

					<!-- 총 결제 금액 -->
					<div class="form-group text-left">
						<p style="font-size: 30px;" class="text-center">
							총 결제 금액 : <span style="font-size: 30px;" class="total_price"></span>
						</p>
					</div>

					<!-- 버튼 -->
					<div class="text-right">
						<button type="button" class="btn btn-primary" id="orderFrombtn">주문</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 장바구니 선택삭제 에러 모달창 -->
<div class="modal hide fade" id="CartSelectionDeleteFailModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h3>장바구니 삭제 실패</h3>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>

<!-- 주문 정보 입력 오류 모달창 -->
<div class="modal hide fade" id="OrderInfoErrorModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title" id="OrderInfoErrorModal-Title"></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id="OrderInfoErrorModal-body"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>