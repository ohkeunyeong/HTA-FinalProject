$(function(){
	
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
	
	// 장바구니 담기 버튼 클릭시
	$('#cartbtn').click(function(){
		var user_id = $('.id').val();
		var product_code = $('.code').val();
		if(user_id == ''){
			$('#CartErrorModal').modal({backdrop: 'static', keyboard: false});
			$("#cartErrorBtn").click(function(){
				$('#CartErrorModal').modal('hide');
				location.href="/project/member/login";
			});
			return false;
		}
		$('#CartModal').modal({backdrop: 'static', keyboard: false});
		$('#addbtn').click(function(){
			$('#CartModal').modal('hide');
			$.ajax({
				url : "/project/cart/add",
				type : 'post',
				data : {product_code : product_code, 
						id : user_id,
						order_de_count : $('.numBox').val()
					   },
				success : function(data){
					console.log(data);
					if(data == 1){
						$('#CartAddConfirmModal').modal({backdrop: 'static', keyboard: false});
						$('.CartAddConfirmModal_body').html("<h4>장바구니에 담았습니다.</h4>");
						$(".order_de_count").val('1');
					}else{
						$('#CartAddErrorModal').modal({backdrop: 'static', keyboard: false});
					}
				}
			});
		});
	});
});