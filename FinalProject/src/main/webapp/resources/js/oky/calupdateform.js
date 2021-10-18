 $(document).ready(function () { 
	$("form").submit(function () {
		
		if ($.trim($("#title").val()) == "") {
			alert("제목을 입력하세요");
			$("#title").focus();
			return false;
		}		
		if ($.trim($("#content").val()) == "") {
			alert("내용을 입력하세요");
			$("#content").focus();
			return false;
		}	
	});//submit end
	
	$("#outmynong").click(function(){
		if(confirm("농장에서 탈퇴 하시겠습니까?")){
		}else {
			return false
		}	
	})
  });// ready()end