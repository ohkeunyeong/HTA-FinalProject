$(document).ready(function() {
	$('form').submit(function() {
		var input_pass = $.trim($("#pass").val());

		if (input_pass == "") {
			alert("비밀번호를 입력하세요");
			$("#pass").focus();
			return false;
		}
	})
})