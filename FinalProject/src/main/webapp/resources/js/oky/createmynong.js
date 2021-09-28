$(function() {
	$(document).keypress(function(e) { //엔터키 방지
		if (e.keyCode == 13) e.preventDefault(); 
		});

	
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
	  
	  
	  $("#name").on('keyup', function(){
		  var name = $("#name").val();
		  var pattern = /^\w{1,10}$/;
		  if(!pattern.test(name)){
			  console.log(name)
			  alert('농장명은 영문자 숫자_로 최대 10글자까지 가능합니다');
			  $("#name").val('').focus();
		  }		  
		  $.ajax({
        	  url : "okynamecheck",
        	  data : {"mynong_name" : name},
        	  success : function(resp) {
        		  if (resp == -1) {//db에 해당 id가 없는 경우
        			  $("#message").css('color', 'blue').html(
        					  "사용 가능한 농장명 입니다.");
        		      checkname=true;
        		  } else {//db에 해당 id가 있는 경우(0)
        		    $("#message").css('color','red').html(
        		    		"사용중인 농장명 입니다.");
        		    checkname=false;
        		  }
        	  }
          });//ajax end 
	  }); //$("#name").on('keyup') end
		  
})//function end