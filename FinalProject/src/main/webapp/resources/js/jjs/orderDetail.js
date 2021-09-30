$(function() {
	var order_num = $('#order_num').val();
	var order_delivery = $('#order_delivery').val();
	$('#deliveryBtn').click(function(){
		var deliveryStatus = '';
		if(order_delivery == '배송준비'){
			deliveryStatus = "배송중";
		}else{
			deliveryStatus = "배송완료";
		}
		
		$.ajax({
			url : "OrderDeliveryUpdate",
			type : 'post',
			data : {deliveryStatus : deliveryStatus,
					order_num : order_num},
			success : function(data){
				if(data == 1){
					location.replace('orderDetail?order_num=' + order_num);
				}
			}
		});
	});
});