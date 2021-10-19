	  function checkTarget(id) {
			$("#userid").text(id);		
			$("#usersetid").val(id);	
	  }
	  
	  function deletecheck(name, id){
		  if (confirm("정말 삭제하시겠습니까??") == true){    
			  location.href='deletemynong?name='+ name + '&id=' + id; 
			}else{   
			 return;
	        }
	  }
	  function deletemem(id){
		  if (confirm("정말 삭제하시겠습니까??") == true){    
			  location.href='deletenongmem?id=' + id; 
			}else{   
			 return;
	        }
	  }
$(function() {
	$(document).keypress(function(e) { //엔터키 방지
		if (e.keyCode == 13) e.preventDefault(); 
		});
			  
	  $("#search").on('click', function(){
		  var admin = $("#id").val();
		  var id = $("#idck").val();
		  $.ajax({
        	  url : "okyidcheck",
        	  data : {"id" : id},
        	  success : function(data) {
        		  console.log(data)
        		  if (data.list.length > 0) {//db에 해당 id가 있는경우
        			  $(data.list).each(
        				function(index, item){
        					if(item.id == admin) {
        						alert('자신의 계정은 추가 할 수 없습니다.')
        						$("#message2").html('');
        						$("#message3").html('');
        						return;
        					}
        			  $("#message2").css('color', 'blue').html(
        					 "회원 아이디: " + item.id + "<br>"  + "회원 닉네임: "  + item.nick );
        			  $("#message3").html(
        					  '<button type="submit" class="btn-primary" id="add" name="add">'+"추가하기"+ '</button>');
        			  $("#okuse").show();			
        				}	  
        			  )
        		  } else {//db에 해당 id가 없는경우
        		    $("#message2").css('color','red').html(
        		    		"해당 아이디가 없습니다 다시 확인해주세요");
        		    $("#message3").html('');
        		  }
        	  }
          });//ajax end 
	  }); //$("#search").on('click') end

})//function end

