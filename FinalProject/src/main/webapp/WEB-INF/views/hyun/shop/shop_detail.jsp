<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<style>
h5 {
	padding-top: 10px;
	font-weight:medium;
}

.container .nav {
	margin-top: 80px;
	font-size: 20px;
}

div.goods {
	margin:auto;
	margin-bottom:40px;
	width:80%
}

 div.goods div.goodsImg { float:left; width:350px; }
 div.goods div.goodsImg img { width:350px; height:auto; }
 
 div.goods div.goodsInfo { float:right; width:450px; font-size:20px;}
 div.goods div.goodsInfo p { margin:0 0 10px 0; }
 div.goods div.goodsInfo p span { display:inline-block; width:100px; margin-left:10%; margin-right:15px; padding-top:10px;}
 
 div.goods div.goodsInfo p.cartStock input { font-size:20px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
 div.goods div.goodsInfo p.cartStock button { font-size:26px; border:none; background:none; }
 div.goods div.goodsInfo p.addToCart { text-align:right; }
 div.goods div.gdsDes { font-size:18px; clear:both; padding-top:30px; padding-bottom:40px;}


</style>

<!--리뷰 목록 스크립트 -->
 <script> 
		   function reviewList() {
			   
			   
			 var product_code = ${product.product_code};
			 $.getJSON("/shop/shop_detail/reviewList" + "?n=" + product_code, function(data){
			  var str = "";
			  
			  $(data).each(function(){
			   
			   console.log(data);
			   
			   var review_Date = new Date(this.review_Date);
			   review_Date = review_Date.toLocaleDateString("ko-US")
			   
			   str += "<li data-product_code='" + this.product_code + "'>"
			     + "<div class='userInfo'>"
			     + "<span class='ID'>" + this.ID + "</span>"
			     + "<span class='date'>" + review_Date + "</span>"
			     + "</div>"
			     + "<div class='review_Content'>" + this.review_content + "</div>"
			     + "<div class='product_code' type='hidden'>" + this.product_code + "</div>"
			     + "<div class='product_name' type='hidden'>" + this.product_name + "</div>"
			     + "<div class='category_code'type='hidden'>" + this.category_code + "</div>"
			     + "</li>";           
			  });
			  
			  $("section.reviewList ol").html(str);
			 });
			 
			 }
			</script>
			
</head>
<body>
	<jsp:include page="shop_header.jsp" />

    <br><br><br>    	
    
	<!-- 굿즈 장터 내 네비게이션 바 -->
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="seed">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="soil">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="pesticide">살충제</a></li>
			<li class="nav-item"><a class="nav-link" href="tools">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="personacon">퍼스나콘</a></li>
			<li class="nav-item"><a class="nav-link" href="goods">굿즈</a></li>
		</ul>
	</div>

	
	<br><br><br>
		
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
		          			<input type="hidden" value="${user_id}" name="user_id">
		          			<input type="hidden" value="${p.product_code}" name="product_code">
							<!-- 수령인 -->
							<div class="form-group text-left">
				      			<label for="order_name">수령인</label>
				      			<input type="text" class="form-control" id="order_name" name="order_name" placeholder="수령인 입력">
				    		</div>
				    			
				    		<!-- 수령인 연락처 -->
				    		<div class="form-group text-left">
				      			<label for="order_phone">수령인 연락처</label>
				      			<input type="text" class="form-control" id="order_phone" name="order_phone" placeholder="ex) 010-XXXX-XXXX">
				    		</div>
				    		
				    		<!-- 우편번호 -->
				    		<div class="form-group text-left">
				      			<label for="order_address1">우편번호</label>
				      			<div class="input-group">
				      				<input type="text" class="form-control" id="order_address1" name="order_address1" readOnly>
				      				<input type="button" class="btn btn-info" id="postsearchbtn" value="주소 검색">
				      			</div>
				    		</div>
				    		
				    		<!-- 주소 -->
				    		<div class="form-group text-left">
				      			<label for="order_address2">주소</label>
				      			<input type="text" class="form-control" id="order_address2" name="order_address2" readOnly>
				    		</div>
				    		
				    		<!-- 상세 주소 -->
				    		<div class="form-group text-left">
				      			<label for="order_address3">상세 주소</label>
				      			<input type="text" class="form-control" id="order_address3" name="order_address3" placeholder="상세주소 입력">
				    		</div>
				    		
				    		<!-- 결제 방식 -->
				    		<div class="form-group text-center">
				      			<div><h4>결제 방식</h4></div>
								<div class="form-check-inline">
									<label class="form-check-label" for="creditcardPayment">
										<input type="radio" class="form-check-input" id="creditcardPayment" name="order_payment" value="카드결제">카드결제
									</label>
								</div>
							    <div class="form-check-inline">
									<label class="form-check-label" for="phonePayment">
										<input type="radio" class="form-check-input" id="phonePayment" name="order_payment" value="휴대전화">휴대전화
									</label>
								</div>
								<div class="form-check-inline">
									<label class="form-check-label" for="accountPayment">
										<input type="radio" class="form-check-input" id="accountPayment" name="order_payment" value="계좌이체">계좌이체
									</label>
								</div>
								<div class="form-check-inline">
									<label class="form-check-label" for="samsungpayPayment">
										<input type="radio" class="form-check-input" id="samsungpayPayment" name="order_payment" value="삼성페이">삼성페이
									</label>
								</div>
				    		</div>
				    		
				    		<!-- 총 결제 금액 -->
				    		<div class="form-group text-left">
				      			<p style="font-size : 30px;" class="text-center">총 결제 금액 : <span style="font-size : 30px;" class="total_price"></span></p>
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
					<div class="modal-body" id="DetailOrderInfoErrorModal-body">
					  
					</div>
		        
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
		
		 <c:if test="${id == null }"> <!-- 세션아이디 = id -->
		  <p>리뷰를 남기시려면 <a id="shop_login" style="color:blue">로그인</a>해주세요</p>
		 </c:if>
		 
		 <c:if test="${id != null}">
		 <section class="reviewForm">
		  <form role="form" method="post" autocomplete="off" action="/project/shop/registReview">
		  	
		  	<input type="hidden" name="product_code" value="${product.product_code}">
		  	<input type="hidden" name="product_name" value="${product.product_name}">
		  	<input type="hidden" name="category_code" value="${product.category_code}">
		  	
		   <div class="input_area">
		    <textarea name="review_content" id="review_content"></textarea>
		   </div>
		   
		   <div class="input_area">
		    <button type="submit" id="review_btn">리뷰 남기기</button>
		   </div>
		   
		   		<script>
				 $("#review_btn").click(function(){
				  
				  var formObj = $(".reviewForm form[role='form']");
				  var product_code = $("#product_code").val();
				  var review_content = $("#review_content").val();
				  var product_name = $("#product_name").val();
				  var category_code = $("#category_code").val();
				  
				  var data = {
					  product_code : product_code,
					  review_content : review_content
					  product_name : product_name
				    };
				  
				  $.ajax({
				   url : "/shop/registReview",
				   type : "post",
				   data : data,
				   success : function(){
				    reviewList();
				    $("#review_content").val("");
				   }
				  });
				 });
				</script>
		  </form>
		 </section>
		 </c:if>
		 
		 <section class="reviewList">
		  <ol>
		   <li>댓글 목록</li>
		   </ol>
		   
		   <script>
		   reviewList();
		   </script>
		  
    
		 </section>
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
					<div class="modal-body CartAddConfirmModal_body">
						
					</div>
		        
					<!-- Modal footer -->
					<div class="modal-footer">
						<a type="button" class="btn btn-primary" href="javascript:location.href='MainCartView.ma?user_id=${user_id}';">장바구니로 </a>
						<button type="button" class="btn btn-info" data-dismiss="modal">계속 쇼핑</button>
					</div>
		        
				</div>
			</div>
		</div>
	</body>
</html>