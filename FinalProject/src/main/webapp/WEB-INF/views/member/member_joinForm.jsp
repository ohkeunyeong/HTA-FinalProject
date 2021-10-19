<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>회원관리 시스템 회원가입 페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/chang/join.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<jsp:include page="../main/header.jsp" />

<script>
	$(function() {
		var checkid=false;
		var checkemail=false;
		var check=0;
		var checknick=false;
		
		$('input[type=file]').change(function(event){
			check++;
			var inputfile = $(this).val().split('\\');
			var filename=inputfile[inputfile.length -1];
			
			var pattern = /(gif|jpg|gpeg|png)$/i; //플래그 i는 대소문자 구분 없는 검색
			if(pattern.test(filename)){
				$('#filename').text(filename);//inputfile.length - 1=2
				
				var reader = new FileReader(); //파일을 읽기 위한 객체 생성
				//DataURL 형식으로 파일을 읽어옵니다.
				//읽어온 결과는 reader 객체의 result 속성에 저장됩니다.
				//event.target.files[0] : 선택한 그림의 파일객체에서 첫번째 객체를 가져옵니다.
				reader.readAsDataURL(event.target.files[0]);
				
				reader.onload = function(event){
					$('#showImage').html('<img width="25px" src ="'
										  + event.target.result + '">');
				};
			}else{
				alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
				check=0;
			}
		});
		
		$('form').submit(function() {
			if (!$.isNumeric($("input[name='tel']").val())) {
				alert("-를 제외하고 전화번호를 다시 입력하세요");
				$("input[name='tel']").val('').focus();
				return false;
			}
			if(!checkid){
				alert("사용가능한 id로 입력하세요.");
				$("#joinid").val('').focus();
				return false;
			}
			if(!checkemail){
				alert("email 형식을 확인하세요");
				$("#joinemail").focus();
				return false;
			}
			if(!checknick){
				alert("사용가능한 닉네임으로 입력하세요.");
				$("#joinnick").val('').focus();
				return false;
			}
		}); //submit

		$("#joinmail").on('keyup',
 				function() {
					$("#email_message").empty();
					//[A-Za-z0-9_]와 동일한 것이  \w
					//+는 1회 이상 반복을 의미합니다. {1,}와 동일합니다.
					//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
					var pattern = /^\w+@\w+[.]\w{3}$/;
					var email = $("#joinmail").val();
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
				
		$("#joinid").on('input',
				function() {
			        $("#message").empty();//처음에 pattern에 적합하지 않은 경우 메시지 출력 후 적합한 데이터를 입력해도 계속 같은 데이터 출력하므로 이벤트 시작할 때마다 비워둔다.
					//[A-Za-z0-9_]와 동일한 것이  \w
					//+는 1회 이상 반복을 의미합니다. {1,}와 동일합니다.
					//\w+ 는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
					var pattern = /^\w{5,12}$/;
					var id = $("#joinid").val();
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
		
		$("#joinnick").on('input',
				function() {
			        $("#message2").empty();
			        var nick = $("#joinnick").val();
			        
					$.ajax({
						url : "nickcheck",
						data : {"nick" : nick},
						success : function(resp){
							if(resp == -1){ // db에 해당 닉네임이 없는 경우
								$("#message2").css('color','green').html(
										"사용 가능한 닉네임 입니다.");
								checknick=true;
							} else {//db에 해당 닉네임이 있는 경우 (0)
								$("#message2").css('color','blue').html(
										"사용중인 닉네임 입니다.");
								checknick=false;
							}
						}
					})//ajax end
		})//id keyup end
	})//ready
</script>
</head>
<body>
<br><br><br>
	<form name="joinform" action="joinProcess" method="post"  enctype="multipart/form-data">
		<h1>회원가입 페이지</h1>
		<hr>
		<b>아이디</b> 
		<input type="text" name="id" placeholder="아이디"	id="joinid" required maxLength="12"> 
		<span id="message"></span> 
	    
	    <b>비밀번호</b><input
			type="password" name="pass" id="joinpass" placeholder="비밀번호" required>

		<b>이름</b><input type="text" name="name" id="joinname" placeholder="이름"
			maxLength="5" required> 
						
		<b>닉네임</b><input type="text" name="nick" id="joinnick" placeholder="닉네임"
			maxLength="8" required> 
		<span id="message2"></span>
		
		<b>이메일 주소 </b>
		<input type="text" name="mail" id="joinmail" placeholder="이메일" maxLength="30" required>
		<span id="email_message"></span>
		
		<b>전화번호</b><input type="text" name="tel" id="jointel"
			maxLength="11" required> 
		
		
		<b>프로필 사진</b>
		<label>
			<img src="../resources/image/chang/attach.png" width="25px">&nbsp;&nbsp;:&nbsp;&nbsp;
			<span id="showImage"><img width="25px" src ="../resources/image/chang/profile.png"></span>
			<input type="file" name="uploadfile" accept="image/*">
		</label>
		
		<div class="clearfix">
			<button type="submit" class="submitbtn">회원가입</button>
			<button type="reset" class="cancelbtn">다시작성</button>
		</div>
	
	</form>
	
	<jsp:include page="../main/footer.jsp" />
</body>
</html>
