$(document).ready(function () {
	$("#outmynong").click(function(){
		if(confirm("농장에서 탈퇴 하시겠습니까?")){
		}else {
			return false
		}	
	})
	// submit 버튼 클릭할 때 이벤트 부분
	$("form").submit(function () {
		
		if ($.trim($("#nong_pass").val()) == "") {
			alert("비밀번호를 입력하세요");
			$("#nong_pass").focus();
			return false;
		}
		
		if ($.trim($("#nong_sub").val()) == "") {
			alert("제목를 입력하세요");
			$("#nong_sub").focus();
			return false;
		}	
		
		if ($.trim($("textarea").val()) == "") {
			alert("내용을 입력하세요");
			$("textarea").focus();
			return false;
		}		
	});//submit end
	
	
	$("#upfile").change(function () {
		console.log($(this).val())  //c:\fakepath\upload.png
		var inputfile = $(this).val().split('\\');
		$("#filevalue").text(inputfile[inputfile.length - 1]);
	});
	
});// ready()end
function page_back(){
	history.go(-1);
}