<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>회원관리 시스템 회원가입 페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/chang/join.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script>
	$(function() {
		var checkid=false;
		var checkemail=false;
		
		$('form').submit(function() {
			if (!$.isNumeric($("input[name='tel']").val())) {
				alert("-제외하고 전화번호를 다시 입력하세요");
				$("input[name='tel']").val('').focus();
				return false;
			}			
			if(!checkid){
				alert("사용가능한 id로 입력하세요.");
				$("input:eq(0)").val('').focus();
				return false;
			}
			if(!checkemail){
				alert("email 형식을 확인하세요");
				$("input:eq(6)").focus();
				return false;
			}
		}); //submit

		$("input:eq(4)").on('keyup',
 				function() {
					$("#email_message").empty();
					//[A-Za-z0-9_]와 동일한 것이  \w
					//+는 1회 이상 반복을 의미합니다. {1,}와 동일합니다.
					//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
					var pattern = /^\w+@\w+[.]\w{3}$/;
					var email = $("input:eq(4)").val();
					if (!pattern.test(email)) {
						$("#email_message").css('color', 'red')
						                   .html("이메일형식이 맞지 않습니다.");
						checkemail=false;
					}else{
						$("#email_message").css('color', 'green')
						                   .html("이메일형식에 맞습니다.");
						checkemail=true;
					}
				});//email keyup 이벤트 처리 끝
				
		$("input:eq(0)").on(
				'input',
				function() {
			        $("#message").empty();//처음에 pattern에 적합하지 않은 경우 메시지 출력 후 적합한 데이터를 입력해도 계속 같은 데이터 출력하므로 이벤트 시작할 때마다 비워둔다.
					//[A-Za-z0-9_]와 동일한 것이  \w
					//+는 1회 이상 반복을 의미합니다. {1,}와 동일합니다.
					//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
					var pattern = /^\w{5,12}$/;
					var id = $("input:eq(0)").val();
					if (!pattern.test(id)) {
						$("#message").css('color', 'red')
						             .html("영문자 숫자 _로 5~12자 가능합니다.");
						checkid=false;	
						return;
					}
					
					$.ajax({
						url : "idcheck",
						data : {"id" : id},
						success : function(resp){
							if(resp == -1){ // db에 해당 id가 없는 경우
								$("#message").css('color','green').html(
										"사용 가능한 아이디 입니다.");
								checkid=true;
							} else {//db에 해당 id가 있는 경우 (0)
								$("#message").css('color','blue').html(
										"사용중인 아이디 입니다.");
								checkid=false;
							}
						}
					})//ajax end
		})//id keyup end
	})//ready
</script>
</head>
<body>
	<form name="joinform" action="joinProcess" method="post">
		<h1>회원가입 페이지</h1>
		<hr>
		<b>아이디</b> 
		<input type="text" name="id" placeholder="아이디"	required maxLength="12"> 
		<span id="message"></span> 
	    
	    <b>비밀번호</b><input
			type="password" name="pass" placeholder="비밀번호" required>

		<b>이름</b><input type="text" name="name" placeholder="이름"
			maxLength="5" required> 
						
		<b>닉네임</b><input type="text" name="nick" placeholder="닉네임"
			maxLength="8" required> 
		
		<b>이메일 주소 </b>
		<input type="text" name="mail"	placeholder="이메일" maxLength="30" required>
		<span id="email_message"></span>
		
		<b>전화번호</b><input type="text" name="tel"
			maxLength="11" required> 
		<div class="clearfix">
			<button type="submit" class="submitbtn">회원가입</button>
			<button type="reset" class="cancelbtn">다시작성</button>
		</div>
		
	
	</form>
</body>
</html>
