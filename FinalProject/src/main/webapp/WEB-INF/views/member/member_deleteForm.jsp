<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script> 
<script>
$(document).ready(function () {  
   $('form').submit(function() {
var input_pass=$.trim($("#pass").val());

   if (input_pass ==""){
	alert("비밀번호를 입력하세요");
	$("#pass").focus();
	return false;	  
	}
})

}) 
</script>
<style>
img { display: block; margin: 0px auto; }
form {
    background-color: #fefefe;
    margin: 5% auto 15% auto; 
}
h3 {
    text-align: center;
    color: red;
}

#logo{
	background-color:#28A745;
 	padding: 10px 20px; 
}
input {
    width: 95%;
    padding: 10px;
    margin: 5px 0 22px 0;
    display: inline-block;
    margin: 0;
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
    border-radius: 3px;
    border: 1px solid lightgray;    
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer; /* 손가락 커서 모양 */
    width: 100%;
    opacity: 0.9;
}

button:hover {
    opacity:1;
    
}
button:focus{
   outline:none;
}

/* 취소 버튼*/
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

.cancelbtn, .submitbtn {
  float: left;
  width: 50%;
}
</style>
</head>
<body>
<form name="form" action="deleteProcess" method="post">
<div id="logo"><img src="${pageContext.request.contextPath}/resources/image/logo2.png" alt="Logo" ></div>
<hr>
<h3>주의사항</h3><hr>
<div style="font-size:10pt;">
회원탈퇴시 개인정보 및 모든 데이터는 삭제됩니다. <br>
또한 소속 내 농장의 유일한 관리자일 경우, 다른 멤버에게 관리자를 위임하거나 <br>
내농장 삭제 후 탈퇴가 가능합니다. <br>
본인 확인을 위해 비밀번호를 입력 바랍니다. <br>
<hr>
<br>
</div>
<div>
    <b>아이디 </b>
    <span class="box int_name">
        <input type="text" id="id" name="id" value="${id}" readOnly >
    </span>
</div>
<div>
   <b>비밀번호 </b>
    <span class="box int_name">
        <input type="text" id="pass" name="pass">
    </span>
</div>
         <button type="submit" class="cancelbtn">탈퇴하기</button>
         <button type="button" class="submitbtn" onClick='window.close()'>취소</button>          
</form>
</body>
</html>