<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>회원관리 시스템 회원수정 페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/join.css" type="text/css" rel="stylesheet">
<style>
h3{ text-align: center; color: #1a92b9;}
input[type=file]{
 display:none;
 }
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<br><br><br><br>

<form name="joinform" action="updateProcess" method="post"
      enctype="multipart/form-data">
         <h3>회원 정보 수정</h3>
         <hr>
         <b>아이디</b>
         <input type="text" name="id" value="${member_info.id}" readonly>
          <span id="message"></span>
         
         <b>비밀번호</b>
         <input type="password" name="pass" value="${memberinfo.password}" placeholder="비밀번호를 입력하세요" required>
         <span id="pass_message"></span>
         
         <b>이름</b>
         <input type="text" name="name" value="${member_info.name}" placeholder="이름을 입력하세요" required>
         <span id="name_message"></span>
         
         <b>닉네임</b>
         <input type="text" name="nick" maxLength="8" value="${member_info.nick}" 
                placeholder="닉네임을 입력하세요" required>
         <span id="nick_message"></span>
         
         <b>전화번호</b>
         <input type="text" name="tel" maxLength="11" value="${member_info.tel}" 
                placeholder="전화번호를 입력하세요" required>
         <span id="tel_message"></span>
         
         
         <b>이메일 주소</b>
         <input type="text" name="email" value="${member_info.mail}" maxLength="30" 
         placeholder="이메일을 입력하세요" required>
         <span id="email_message"></span>
         
         
         
         <div class="clearfix">
          <button type="submit" class="submitbtn">수정</button>
          <button type="reset" class="cancelbtn">취소</button>
        </div>       
     </form>
<script>
  
  // 처음 화면 로드시 보여줄 이메일은 이미 체크 완료된 것이므로 기본 checkemail=true입니다.
  var checkemail=true;
  $("input:eq(6)").on('keyup',
		  function() {
	          $("#email_message").empty();
	          //A-Za-z0-9_]와 동일한 것이 \w
	          //+는 1회 이상 반복을 의미합니다. {1, }와 동일합니다.
	          //\w+ 는 [A-Za-z0-9_]를 1개 이상 사용하라는 의미입니다.
	          var pattern = /^\w+@\w+[.]\w{3}$/;
	          var email = $("input:eq(6)").val();
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
  
    var check=0;
    $('form').submit(function() {
           
    	   
    	  if(!checkemail){
    		  alert("email 형식을 확인하세요");
    		  $("input:eq(6)").focus();
    		  return false;
    		  }
    	  
    	  if (check == 0) {
    		  value = $('#filename').text();
    		  html = "<input type= 'text' value='" + value +"' name = 'check'>";
    		  $(this).append(html);
    	  }
     })
     
     $('input[type=file]').change(function(event){
    	 check++;
    	 var inputfile = $(this).val().split('\\');
    	 var filename=inputfile[inputfile.length - 1];
    	 var pattern = /(gif|jpg|jpeg|png)$/i;//플래그 i는 대소문자 구분없는 검색
    	 if (pattern.test(filename)) {
    		 $('#filename').text(filename);//inputfile.length - 1=2
    		 
    		 var reader = new FileReader(); //파일을 읽기 위한 객체 생성
    	   //DataURL 형식으로 파일을 읽어옵니다.
    	   //읽어온 결과는 reader 객체의 result 속성에 저장됩니다.
    	   //event.target.files[0] : 선택한 그림의 파일객체에서 첫번째 객체를 가져옵니다.
    	     reader.readAsDataURL(event.target.files[0]);
    	   
    	     reader.onload = function(event) {//읽기에 성공했을 때 실행되는 이벤트 핸들러 
    	        $('#showImage').html('<img width="20px" src="'
    	        		              + event.target.result + '">');
    	     };
    	 } else {
    		 alert('확장자는 gif, jpg, jpeg, png가 가능합니다.');
    		 check=0;
    	 }
     })//$('input[type=file]').change() end
</script>
</body>
</html>