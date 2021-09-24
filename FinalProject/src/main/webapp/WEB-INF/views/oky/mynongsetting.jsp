<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 농장 관리</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script>
$(function() {
	$(document).keypress(function(e) { //엔터키 방지
		if (e.keyCode == 13) e.preventDefault(); 
		});
	
    $("#okuse").hide();
	   $('form').submit(function () {
		  var name = $("#name").val();
		  var pattern = /^\w{1,10}$/;
		  if(!pattern.test(name)){
			  console.log(name)
			  alert('농장명은 영문자 숫자_로 최대 10글자까지 가능합니다');
			  $("#name").val('').focus();
			  return false;
		  }		  
		  if(!checkname) {
			  alert('중복된 농장 이름입니다. 다시 확인하세요')
			  $("#name").val('').focus();
			  return false;
		  }
	  }); //submit end 	  

		  
	  $("#search").on('click', function(){
		  var id = $("#idck").val();
		  $("#okuse").hide();
		  $.ajax({
        	  url : "okyidcheck",
        	  data : {"id" : id},
        	  success : function(data) {
        		  console.log(data)
        		  if (data.list.length > 0) {//db에 해당 id가 있는경우
        			  $(data.list).each(
        				function(index, item){
        			  $("#message2").css('color', 'blue').html(
        					 "회원 아이디: " + item.id + "<br>"  + "회원 닉네임: "  + item.nick );
        			  $("#okuse").show();       					
        				}	  
        			  )
        		  } else {//db에 해당 id가 없는경우
        		    $("#message2").css('color','red').html(
        		    		"해당 아이디가 없습니다 다시 확인해주세요");
        		    $("#okuse").hide();
        		  }
        	  }
          });//ajax end 
	  }); //$("#search").on('click') end
})//function end
</script>
</head>
<body>
<jsp:include page="../main/header.jsp" /> 
 <form name="createform" action="createProcess" method="post">
<input type="hidden" id="id" value="admin" name="ID">
<h1>내 농장 관리</h1>
<div>농장명 : ${mynong_name}<br>
     관리자 아이디 : ${id}
</div>
<div>회원 추가 
<a href="#" data-toggle="modal" data-target="#idsearch">검색</a>
</div>
<button type="submit" class="submitbtn">농장생성</button>
          
          
</form>

  <div class="modal fade" id="idsearch" role="dialog"> 

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">


          <h4 class="modal-title" align="center">회원 아이디 검색</h4> 
          <button type="button" class="close" data-dismiss="modal" >×</button>

        </div>

        <div class="modal-body">
                   <form id="my-form">
                   <input type ="text" name="idck" id="idck" placeholder="아이디 입력">            
                   <button type="button" id="search" class="searchid" >검색</button><br>
                   <span id="message2"></span>
                   </form>
        </div>
        </div>

        <div class="modal-footer">
        <button type="button"  id="okuse"  data-dismiss="modal">추가하기</button><br>

        </div>

      </div>

    </div> 
</body>
</html>