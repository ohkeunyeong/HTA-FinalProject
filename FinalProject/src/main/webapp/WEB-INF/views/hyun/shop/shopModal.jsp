<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 장바구니 모달창 -->
<div class="modal hide fade" id="CartModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니 담기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<span style="font-size: 15px;">상품을 장바구니에 추가하시겠습니까?</span>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="addbtn">추가</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>

<!-- 주문 정보 입력 모달창 -->
<div class="modal fade" id="MainOrderInfoModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header text-center">
				<h2 class="modal-title">주문 정보 입력</h2>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form action="MainOrderAction.ma" id="OrderForm" method="post" name="OrderFrom">
					<input type="hidden" value="${user_id}" name="user_id"> <input type="hidden" value="${p.product_code}" name="product_code">
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
							<label class="form-check-label" for="creditcardPayment"> <input type="radio" class="form-check-input" id="creditcardPayment" name="order_payment" value="카드결제">카드결제
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label" for="phonePayment"> <input type="radio" class="form-check-input" id="phonePayment" name="order_payment" value="휴대전화">휴대전화
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label" for="accountPayment"> <input type="radio" class="form-check-input" id="accountPayment" name="order_payment" value="계좌이체">계좌이체
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label" for="samsungpayPayment"> <input type="radio" class="form-check-input" id="samsungpayPayment" name="order_payment" value="삼성페이">삼성페이
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
						<button type="submit" class="btn btn-primary">주문</button>
						<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 주문 오류 모달창 -->
<div class="modal hide fade" id="productOrderModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">상품 주문</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>로그인 후 구매 해주십시오.</h4>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary productOrderErrorBtn">확인</button>
			</div>

		</div>
	</div>
</div>

<!-- 주문 정보 입력 오류 모달창 -->
<div class="modal hide fade" id="DetailOrderInfoErrorModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title" id="DetailOrderInfoErrorModal-Title"></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id="DetailOrderInfoErrorModal-body"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>

<!-- 장바구니 담기 오류 모달창 -->
<div class="modal hide fade" id="CartErrorModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니 담기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>로그인 후 담아주세요.</h4>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="cartErrorBtn">확인</button>
			</div>

		</div>
	</div>
</div>

<!-- 장바구니 담기 실패 오류 모달창 -->
<div class="modal hide fade" id="CartAddErrorModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니 담기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<h4>장바구니 담기 실패했습니다.</h4>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>

<!-- 장바구니 담기 확인 모달창 -->
<div class="modal hide fade" id="CartAddConfirmModal">
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">장바구니 담기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body CartAddConfirmModal_body"></div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<a type="button" class="btn btn-primary" href="javascript:location.href='/project/cart/list?id=${id}';">장바구니로 </a>
				<button type="button" class="btn btn-info" data-dismiss="modal">계속 쇼핑</button>
			</div>

		</div>
	</div>
</div>