$(function(){
	function cartSum(){
		var sum = 0;
		var list = $("input[name='RowCheck']");
		for(var i = 0; i < list.length; i++){
			if(list[i].checked){
				sum += parseInt($(list[i]).val());
			}
		}
		$('.orderPrice').text("주문 가격 : " + Number(sum).toLocaleString('en') + "원");
		$('input[name="pricesum"]').val(sum);
		$('.total_price').text(Number(sum).toLocaleString('en') + "원");
	}
	
	$('input[name="RowCheck"]').click(function(){
		cartSum();
	});
	
	// 주문 부분
	$('.orderbtn').click(function(){
		var valueArr = new Array();
		var user_id = $('.checkUser_id').val();
		var list = $("input[name='RowCheck']");
		for(var i = 0; i < list.length; i++){
			if(list[i].checked){
				valueArr.push(list[i].value);
			}
		}
		if(valueArr.length == 0){
			$("#ErrorModal").modal({backdrop: 'static', keyboard: false});
			$('#ErrorModal-Title').text('상품 주문');
			$("#ErrorModal-body").html("<span style='font-size : 18px;'>주문 하실 상품을 선택해주세요.</span>");
		}else{			
			$('#OrderInfoModal').modal({backdrop: 'static', keyboard: false});
		}
	});
	
	$("#orderFrombtn").click(function(){
		var product_name;
		var valueArr = new Array();
		var list = $("input[name='RowCheck']");
		for(var i = 0; i < list.length; i++){
			if(list[i].checked){
				product_name = $(list[i]).attr("data-pro_name");
				valueArr.push($(list[i]).attr("data-cartNum"));
			}
		}
		console.log(valueArr);
		$('input[name="cartNumArr"]').val(valueArr);
		
		if($.trim($('#order_name').val()) == ''){
			$('#OrderInfoErrorModal').modal('show');
			$('#OrderInfoErrorModal-Title').text("주문 정보");
			$('#OrderInfoErrorModal-body').html("<h4>수령인을 입력해주세요.</h4>");
			return false;
		}
		
		if($.trim($('#order_phone').val()) == ''){
			$('#OrderInfoErrorModal').modal('show');
			$('#OrderInfoErrorModal-Title').text("주문 정보");
			$('#OrderInfoErrorModal-body').html("<h4>수령인 연락처를 입력해주세요.</h4>");
			return false;
		}
		
		var phoneReg = /^\d{3}-\d{3,4}-\d{4}$/;
		if(!phoneReg.test($.trim($('#order_phone').val()))){
			$('#OrderInfoErrorModal').modal('show');
			$('#OrderInfoErrorModal-Title').text("주문 정보");
			$('#OrderInfoErrorModal-body').html("<h5>전화번호 형식에 맞게 입력해주세요</h5>");
			$('#order_phone').val('');
			return false;
		}
		
		if($.trim($('#order_address1').val()) == ''){
			$('#OrderInfoErrorModal').modal('show');
			$('#OrderInfoErrorModal-Title').text("주문 정보");
			$('#OrderInfoErrorModal-body').html("<h4>주소검색을 해주세요.</h4>");
			return false;
		}
		
		if($.trim($('#order_address3').val()) == ''){
			$('#OrderInfoErrorModal').modal('show');
			$('#OrderInfoErrorModal-Title').text("주문 정보");
			$('#OrderInfoErrorModal-body').html("<h4>상세주소를 입력해주세요.</h4>");
			return false;
		}
		
		var order = {
				id : $("input[name='id']").val(),
				pricesum : $("input[name='pricesum']").val(),
				cartNumArr : $('input[name="cartNumArr"]').val(),
				order_name : $('#order_name').val(),
				order_phone : $('#order_phone').val(),
				order_address1 : $('#order_address1').val(),
				order_address2 : $('#order_address2').val() + " " + $('#order_address3').val(),
				creditcardPayment : $('#creditcardPayment').val(),
				product_name : product_name
		}
		console.log(order);
		iamport(order);
	});
	
	// 다음 우편 검색 API
	$('#postsearchbtn').click(function(){
		Postcode();
	});
	
	function Postcode(){
		new daum.Postcode({
			oncomplete: function(data) {
				
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수
				
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				
				if(fullRoadAddr !== ''){
					fullRoadAddr += extraRoadAddr;
				}
				
				
				$('#order_address1').val(data.zonecode);
				$('#order_address2').val(fullRoadAddr);
				
			}
		}).open();
	}
	
	// 장바구니 선택 삭제 부분
	var chkObj = $("input[name='RowCheck']");
	var rowCnt = chkObj.length;
	
	$('input[name="allCheck"]').click(function(){
		var chk_listArr = $('input[name="RowCheck"]');
		for(var i = 0; i < chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
			cartSum();
		}
	});
	
	$('input[name="RowCheck"]').click(function(){
		if($('input[name="RowCheck"]:checked').length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
	
	function deleteValue(){
		 var valueArr = new Array();
		 var id = $('.id').val();
		 var list = $("input[name='RowCheck']");
		 for(var i = 0; i < list.length; i++){
			 if(list[i].checked){
				 valueArr.push($(list[i]).attr('data-cartNum'));
			 }
		 }
		 if(valueArr.length == 0){
			$("#ErrorModal").modal({backdrop: 'static', keyboard: false});
			$('#ErrorModal-Title').text('장바구니 선택 삭제');
			$("#ErrorModal-body").html("<h4>선택한 상품이 없습니다.</h4>");
		 }else{
			 $("#CartDeleteModal").modal({backdrop: 'static', keyboard: false});
			 $("#cartmodaldelbtn").click(function(){
				 $("#CartDeleteModal").modal('hide');
				 $.ajax({
					url : 'selectionDelete',
					type : 'post',
					traditional : true,
					data : {valueArr : valueArr, id : id},
					success : function(data){
						if(data == valueArr.length){
							location.href="list?user_id=" + id;
						}else{
							$("#CartSelectionDeleteFailModal").modal({backdrop: 'static', keyboard: false});
						}
					}
				 });
			 });
		 }
	}
	
	$('#selectionDelete').click(function(){
		deleteValue();
	});
	
	// 장바구니 삭제 부분
	function cartDelete(cart_num){
		var id = $(".id").val();
		$('#CartDeleteModal').modal({backdrop: 'static', keyboard: false});
		$('#cartmodaldelbtn').click(function(){
			$('#CartDeleteModal').modal('hide');
			$.ajax({
				url : "cartDelete",
				type : 'post',
				data : {cart_num : cart_num, id : id},
				success : function(data){
					if(data == 1){
						location.href="list?user_id=" + id;
					}else{
						$('#ErrorModal').modal({backdrop: 'static', keyboard: false});
						$('#ErrorModal-Title').text('장바구니');
						$('#ErrorModal-body').html("<span style='font-size : 21px;'>장바구니 상품 삭제 실패 했습니다.</span>");
					}
				}
			});
		});
	}
	
	$('.cartdelbtn').click(function(){
		var cart_num = $(this).val();
		cartDelete(cart_num);
	});
});

function iamport(order){
	var msg;
	//가맹점 식별코드
	IMP.init('imp63560217');
	IMP.request_pay({
	    pg : 'html5_inicis',
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name :  order.product_name, //결제창에서 보여질 이름
	    amount : Number(order.pricesum), //실제 결제되는 가격
	    buyer_email : 'iamport@siot.do',
	    buyer_name : order.order_name,
	    buyer_tel : order.order_phone,
	    buyer_addr : order.order_address2,
	    buyer_postcode : order.order_address1
	}, function(rsp) {
		console.log(rsp);
	    if ( rsp.success ) {
            $.ajax({
                url: "/project/cart/order",
                type: 'POST',
                dataType: 'json',
                data: {
                    imp_uid : rsp.imp_uid,
                    order_num : rsp.merchant_uid,
                    id : order.id,
                    order_name : order.order_name,
                    user_address1 : order.order_address1,
                    user_address2 : order.order_address2,
                    order_phone : order.order_phone,
                    order_totalprice : order.pricesum,
                    order_payment : order.creditcardPayment,
                    valueArr : order.cartNumArr
                },success : function(data){
                	if(data == 1){
                		location.replace('/project/orderSuccess');
                	}
                }
            })
            
	    } else {
	    	msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            //실패시 이동할 페이지
            location.href="/project/cart/list?user_id=" + order.id;
            alert(msg);
	    }
	});
}