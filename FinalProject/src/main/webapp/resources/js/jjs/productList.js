function categoryList(){
	$.ajax({
		type : "post",
		url : "categoryList",
		dataType : 'json',
		success : function(data){
			$("#categorySelect > option").remove();
			$(data.categoryList).each(function(index, item){
				var option = "<option value='" + item.category_code + "'>"
						   + item.category_name + "</option>";
				$("#categorySelect").append(option);
			});
		}
	});
}

function productDetail(code){
	$.ajax({
		type : "post",
		url : "productDetail",
		data : {"code" : code},
		dataType : 'json',
		success : function(data){
			console.log(data);
		}
	});
}

$(function(){
	
	// 검색 버튼 클릭한 경우
	$('#productSearch').click(function(){
		// 검색어 유효성 검사를 한다.
		if($("#search_word").val()==''){
			$('#ProductValidationModal').modal({backdrop: 'static', keyboard: false});
			$('#ProductValidationModal-body').html("<h3>검색어를 입력해주세요</h3>");
			return false;
		}
	});
	
	// 검색창 select가 바뀌면 placholder 바뀐다
	$('#productSelect').change(function(){
		selectedValue = $(this).val();
		$("#search_word").val('');
		message = ["상품이름", "상품코드", "카테고리명"];
		$("#search_word").attr("placeholder", message[selectedValue] + " 입력하세요");
	});
	
	$("#productAddBtn").click(function(){
		$.ajax({
			type : "post",
			url : "categoryList",
			dataType : 'json',
			success : function(data){
				$("#categorySelectModal > option").remove();
				$(data.categoryList).each(function(index, item){
					var option = "<option value='" + item.category_code + "'>"
							   + item.category_name + "</option>";
					$("#categorySelectModal").append(option);
				});
			}
		});
		$("#productAddModal").modal({backdrop: 'static', keyboard: false});
	});
	
	$("#productAddForm").submit(function(){
		if($.trim($("#product_code").val()) == ''){
			$("#ProductValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#ProductValidationModal-body").html("<h5>상품코드를 입력해주세요</h5>");
			return false;
		}
		
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
		
		if($.trim($('#imgUpload').val()) == ''){
			$('#ProductValidationModal').modal({backdrop: 'static', keyboard: false});
			$('#ProductValidationModal-body').html("<h4>이미지를 첨부해주세요</h4>");
			return false;
		}
	});
	
	$("#product_price").keyup(function(){
		if(!($.isNumeric($('#product_price').val()))){
			$("#product_price").val('');
		}
	});
	
	var chkObj = $("input[name='RowCheck']");
	var rowCnt = chkObj.length;
	
	$('input[name="allCheck"]').click(function(){
		var chk_listArr = $('input[name="RowCheck"]');
		for(var i = 0; i < chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	}); // $('input[name="allCheck"]').click()
	
	$(document).on('click', 'input[name="RowCheck"]', function(){
		if($("input[name='RowCheck']").length != rowCnt){
			rowCnt = $("input[name='RowCheck']").length;
		}
		
		if($('input[name="RowCheck"]:checked').length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}else{
			$("input[name='allCheck']")[0].checked = false;
		}
	}); // $(document).on()
	
	// 이미지 첨부 부분
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
		var inputimg = $(this).val().split("\\");
		var filename = inputimg[inputimg.length - 1];
		var pattern = /(gif|jpg|jpeg|png)$/i;
		if(pattern.test(filename)){
			$('#imgvalue').text(filename);
			show();
		}else{
			$('#ProductValidationModal').modal({backdrop: 'static', keyboard: false});
			$('#ProductValidationModal-body').html("<h6>확장자는 gif, jpg, jpeg, png가 가능합니다.</h6>");
			return false;
		}
	});
	
	$('.remove').click(function(){
		$("#imgvalue").text('');
		show();
	});
	
	$(".productModifyBtn").click(function(){
		var code = $(this).data("code");
		productDetail(code);
		
		$("#productModifyModal").modal({backdrop: 'static', keyboard: false});
	});
	
	categoryList();
});