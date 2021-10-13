<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>ID/PW찾기</title>
<jsp:include page="header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>   
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/find.css"></link>  
<script>
$(document).ready(function () {   

   $(".findpw").click(function(){
	   $(".signupbtn").text('비밀번호 찾기');
	   $(".find").val("findpw");
	   $("#pwtext").html("가입한 메일 주소로 임시 비밀번호를 보내드립니다.");
   });	
   
   $(".findid").click(function(){
	   $(".signupbtn").text('아이디 찾기');
	   $(".find").val("findid");
	   $("#pwtext").html('');
   });	   
   
	$('.cancelbtn').click(function(){
		location.href = '../main';
	})
   
   $("form").submit(function() {
	   if ($.trim($("#name").val()) =="") {
		   alert("이름을 입력 하세요");
		   $("#name").focus();
		   return false;
	   }
	   if ($.trim($("#tel").val()) =="") {
		   alert("전화번호를 입력 하세요");
		   $("#tel").focus();
		   return false;
	   }
	   if ($.trim($("#email").val()) =="") {
		   alert("이메일주소를 입력 하세요");
		   $("#email").focus();
		   return false;
	   }
  });
});  
   </script>
 
</head>
<body>
<br><br><br><br><br><br><br>
   <form name="findform" action="findProcess" method="post">   
   <input type="hidden" class="find" id="find" value="findid" name="find"> <!-- 아이디, 비밀번호 찾기 버튼 클릭 시 value 값이 해당 값으로 변함 -->    
        <!-- header -->
<!--         <div id="header">
            <img style="text-align: center; width: 200px; height: 200px;"  src="image/logo.png" id="logo">
        </div> -->

      <div class="wrap">
                 <button type="button" class="findid">아이디 찾기</button>&nbsp;&nbsp;&nbsp;&nbsp;
                 <button type="button" class="findpw">비밀번호 찾기</button><br>
      </div>
        <!-- wrapper -->
        <div id="wrapper">       
            <!-- content-->
            <div id="content">


                <!-- NAME -->
                <div><span style="color: red; font-size: small;" id="pwtext"></span></div>
                <div>
                    <h3 class="join_title"><label for="name">이름</label></h3>
                    <span class="box int_name">
                        <input type="text" id="name" name="name" class="int" maxlength="20" placeholder="이름을 입력하세요">
                    </span>
                </div>

                <!-- BIRTH -->
                <div>
                    <h3 class="join_title"><label for="name">전화번호</label></h3>
                    <span class="box int_name">
                           <input type="text" placeholder="'-' 없이 번호만 입력해주세요" name="tel"  id="tel" class="int">
                    </span>
                </div>                


                <!-- EMAIL -->
                     <div>
                    <h3 class="join_title"><label for="email">이메일</label></h3>
                    <span class="box int_name">
                           <input type="text" placeholder="이메일주소를 입력하세요" name="email"  id="email" class="int">
                    </span>
                    </div>
                <!-- JOIN BTN-->
                <div class="btn_area">
                    <button type="submit" id="btnJoin" class="signupbtn">
                        <span>아이디 찾기</span>
                    </button>
                    <button type="button" id="button" class="cancelbtn">
                        <span>취소</span>                        
                    </button>
                </div>
 
            <!-- content-->

        </div> 
        <!-- wrapper -->
        </div>
   </form>  
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="../main/footer.jsp" /> 
</body>
</html>