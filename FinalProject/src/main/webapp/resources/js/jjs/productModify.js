$(function(){
	var check = 0;
	
	$("#productModifyForm").submit(function(){
		if($.trim($("#product_name").val()) == ''){
			$("#ProductValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#ProductValidationModal-body").html("<h5>상품이름을 입력해주세요</h5>");
			return false;
		}
		
		if($.trim($("#product_detail").val()) == ''){
			$("#ProductValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#ProductValidationModal-body").html("<h5>상세정보를 입력해주세요</h5>");
			return false;
		}
		
		if($.trim($("#product_price").val()) == ''){
			$("#ProductValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#ProductValidationModal-body").html("<h5>상품가격을 입력해주세요</h5>");
			return false;
		}
		
		if($.trim($('#imgvalue').text()) == ''){
			$('#ProductValidationModal').modal({backdrop: 'static', keyboard: false});
			$('#ProductValidationModal-body').html("<h4>이미지를 첨부해주세요</h4>");
			return false;
		}
		
		if(check == 0){
			value = $("#imgvalue").text();
			html = "<input type='hidden' value='" + value + "' name='check'>";
			$(this).append(html);
		}
	});
	
	$("#product_price").keyup(function(){
		if(!($.isNumeric($('#product_price').val()))){
			$("#product_price").val('');
		}
	});
	
	//이미지 첨부 부분
	function show(){
		if($('#imgvalue').text() == ''){
			$(".remove").css('display', 'none');
		} else {
			$(".remove").css('display', 'inline-block');
		}
	}
	
	show();
	
	$('#imgUploadbtn').click(function(e){
		e.preventDefault();
		$('#imgUpload').click();
	});
	
	$('#imgUpload').change(function(){
		check++;
		var inputimg = $(this).val().split("\\");
		var filename = inputimg[inputimg.length - 1];
		var pattern = /(gif|jpg|jpeg|png)$/i;
		if(pattern.test(filename)){
			$('#imgvalue').text(filename);
			
			var reader = new FileReader();
			reader.readAsDataURL(event.target.files[0]);
			reader.onload = function(event){
				$("#productImg").html('<img width="380px" height="300px" src="' + event.target.result + '">');
			}
	
			show();
		}else{
			$('#ProductValidationModal').modal({backdrop: 'static', keyboard: false});
			$('#ProductValidationModal-body').html("<h6>확장자는 gif, jpg, jpeg, png가 가능합니다.</h6>");
			return false;
		}
	});
	
	$('.remove').click(function(){
		$("#imgvalue").text('');
		$("#productImg > img").remove();
		show();
	});
});