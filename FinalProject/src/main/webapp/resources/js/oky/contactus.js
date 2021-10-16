$(function() {

	$("#contact").click(function() { // 1:1 문의 클릭시 아이디 없으면 안넘어가게하기
		if (!id) {
			alert("로그인 후 이용해 주세요");
			return false;
		}
	});

	$("#send").click(function() {// 아이디 저장 기능
		if ($.trim($("#subject").val()) == "") {
			alert("제목을 입력하세요");
			$("#subject").focus();
			return false
		}

		if ($.trim($("#content").val()) == "") {
			alert("내용을 입력하세요");
			$("#content").focus();
			return false
		}
	});
	$('.cancelbtn').click(function() {
		window.location = "index.jsp";
	})

});