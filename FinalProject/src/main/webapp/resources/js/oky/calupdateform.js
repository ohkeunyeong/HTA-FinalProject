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
  });// ready()end