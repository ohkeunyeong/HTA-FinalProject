$(document).ready(function() {

		$(".findpw").click(function() {
			$(".signupbtn").text('비밀번호 찾기');
			$(".find").val("findpw");
			$("#pwtext").html("가입한 메일 주소로 임시 비밀번호를 보내드립니다.");
		});

		$(".findid").click(function() {
			$(".signupbtn").text('아이디 찾기');
			$(".find").val("findid");
			$("#pwtext").html('');
		});

		$('.cancelbtn').click(function() {
			location.href = '../main';
		})

		$("form").submit(function() {
			if ($.trim($("#name").val()) == "") {
				alert("이름을 입력 하세요");
				$("#name").focus();
				return false;
			}
			if ($.trim($("#tel").val()) == "") {
				alert("전화번호를 입력 하세요");
				$("#tel").focus();
				return false;
			}
			if ($.trim($("#email").val()) == "") {
				alert("이메일주소를 입력 하세요");
				$("#email").focus();
				return false;
			}
		});
	});