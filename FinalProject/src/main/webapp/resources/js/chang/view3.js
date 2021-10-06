$(function(){
	var page=1; //더 보기에서 보여줄 페이지를 기억할 변수
	count = parseInt($("#count").text());
	option=1;
	if(count !=0){ //댓글 갯수가 0이 아니면
		getList(1,option) // 첫 페이지의 댓글을 구해 옵니다. ( 한 페이지에 3개씩 가져옵니다.)
	}else { //댓글이 없는 경우 
		$("#message").text("등록된 댓글이 없습니다.")
	}
	
	
	function getList(currentPage,state){
		option=state;
		$.ajax({
					type: "post",
					url: "../jik_comm/list",
					data : {
						"jik_num" : $("#jik_num").val(),
						"page" : currentPage,
						"state" : state
					},
					dataType : "json",
					success : function(rdata){
						$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
						var red1='red';		var red2='red';
						if(option==1){  //등록순인 경우 등록순이 'red', 최신순이 'gray'로 글자색을 나타냅니다.
							red2='gray';
						}else if(option==2){ //최신순인 경우 등록순이 'gray', 최신순이 'red'로 글자색을 나타냅니다.
							red1='gray';
						}					
						var output="";
						$("#count").text(rdata.listcount);
						if(rdata.listcount > 0){
							
							  output += '<li class="comment_tab_item ' +  red1 + '" >'
	                          + '   <a href="javascript:getList(1)" class="comment_tab_button">등록순 </a>'
	                          + '</li>'
	                          + '<li class="comment_tab_item ' +  red2 + '" >'
	                          + '   <a href="javascript:getList(2)" class="comment_tab_button">최신순</a>'
	                          + '</li>';
	                     $('.comment_tab_list').html(output);//댓글 수 등록순 최신순 출력
	                     
					    output='';
						$(rdata.list).each(function(){
							var lev = this.reply_re_lev;
							var comment_reply='';
							//레벨에 따라 왼쪽 여백줍니다.
							if(lev==1){
								comment_reply = ' CommentItem--reply lev1';//margin-left: 46px;
							}else if(lev==2){
								comment_reply = ' CommentItem--reply lev2';//margin-left: 92px;
							}
							
						
							
							output += '<li id="' + this.jik_comm_num + '" class="CommentItem' + comment_reply + '">'
								   + '   <div class="comment_area">'
								   + '    <div class="comment_box">'
								   + '      <div class="comment_nick_box">'
								   + '            <div class="comment_nick_info">'
								   + '               <div class="comment_nickname">' + this.nick + '</div>'
								   + '            </div>' //comment_nick_info                  
								   + '       </div>'  // comment_nick_box
								   + '     </div>'   //comment_box
								   + '    <div class="comment_text_box">'
								   + '       <p class="comment_text_view">'
								   + '         <span class="text_comment">' + this.jik_comm_content + '</span>'
								   + '       </p>'
								   + '    </div>' //comment_text_box
								   + '    <div class="comment_info_box">'
								   + '      <span class="comment_info_date">' + this.jik_comm_date + '</span>';
							if(lev<2){ //답글쓰기는 답글의 답글까지만 사용하도록 합니다.
							   	  output += '  <a href="javascript:replyform(' + this.jik_comm_num +',' 
							   	         + lev + ',' + this.jik_comm_re_seq +',' 
							   	         + this.jik_comm_re_ref +')"  class="comment_info_button">답글쓰기</a>'
							      }
							output += '   </div>' //comment_info_box;
								   
							//글쓴이가 로그인한 경우 나타나는 더보기입니다.
	                        //수정과 삭제 기능이 있습니다.							
							if($("#Loginid").val()==this.id){  
							 output +=  '<div class="comment_tool">'
								   + '    <div title="더보기" class="comment_tool_button">'
								   + '       <div>&#46;&#46;&#46;</div>' 
								   + '    </div>'
								   + '    <div id="commentItem' +  this.jik_comm_num + '"  class="LayerMore">' //스타일에서 display:none; 설정함
								   + '     <ul class="layer_list">'							   
								   + '      <li class="layer_item">'
								   + '       <a href="javascript:updateForm(' + this.jik_comm_num + ')"'
								   + '          class="layer_button">수정</a>&nbsp;&nbsp;'
								   + '       <a href="javascript:del(' + this.jik_comm_num + ')"'
								   + '          class="layer_button">삭제</a></li></ul>'
								   + '     </div>'//LayerMore
								   + '   </div>'//comment_tool
							}
								   
							output += '</div>'// comment_area
								   + '</li>'//li
						})//each
						 $('.comment_list').html(output);
				 }//if(rdata.boardlist.length>0)
				 else{ //댓글 1개가 있었는데 삭제하는 경우 갯수는 0이라  if문을 수행하지 않고 이곳으로 옵니다.
					   //이곳에서 아래의 두 영역을 없앱니다.
					 $('.comment_list').empty();  
					 $('.comment_tab_list').empty(); 
				 }
				}//success end
			});//ajax end
			
			 
		}//function(getList) end
	
	// 글자수 50개 제한하는 이벤트
	$(".comment_inbox_text").on('keyup',function(){
		jik_comm_content = $(this).val();
		length = $(this).val().length;
		if(length > 200){
			length = 200;
			jik_comm_content = jik_comm_content.substring(0, length);
		}
		$(".comment_inbox_count").text(length + "/200")
	})
	
	
	//더 보기를 클릭하면 page 내용이 추가로 보여집니다.
	$("#message").click(function(){
		getList(++page,1);
	}); // click end
	
	
	
	
	// 등록 또는 수정완료 버튼을 클릭한 경우
	// 버튼의 라벨이 '등록'인 경우는 댓글을 추가하는 경우
	// 버튼의 라벨이 '수정완료'인 경우는 댓글을 수정하는 경우
	$("#write").click(function(){
		buttonText = $("#write").text(); // 버튼의 라벨로 add할지 update할지 결정
		
		if(buttonText == "등록"){ // 댓글을 추가하는 경우
			url = "../jik_comm/add";
			data = {
					"jik_comm_content" : $(".comment_inbox_text").val(),
					"id" : $("#Loginid").val(),
					"nick" : $("#Loginnick").val(),
					"jik_board_num" : $("#jik_num").val(),
					"jik_comm_re_lev" : 0,
					"jik_comm_re_seq" : 0
			};
		}else { //댓글을 수정하는 경우
			url = "../jik_comm/update";
			data = {
					"jik_comm_num" : jik_comm_num,
					"jik_comm_content" : jik_comm_content
			};
			$("#write").text("등록"); // 다시 등록으로 변경
		}
		
		$.ajax({
			type : "post",
			url : url,
			data : data,
			success : function(result){
				$("#content").val('');
				if (result == 1){
					//page=1
					getList(page,1); // 등록, 수정완료 후 해당 페이지 보여줍니다.
				}//if
			}//success
		})//ajax end
	})// $("#write") end
	
	
	// pencil2.png를 클릭하는 경우(수정)
	$("#comment").on('click','.update', function(){
		before = $(this).parent().prev().text(); // 선택한 내용을 가져옵니다.
		$("#content").focus().val(before); // textarea에 수정전 내용을 보여줍니다.
		jik_comm_num = $(this).next().next().val(); // 수정할 댓글번호를 저장합니다.
		$("#write").text("수정완료"); // 등록버튼의 라벨을 '수정완료'로 변경합니다.
		
		//$("#comment .update").parent().parent()
		//#comment영역의 update클래스를 가진 엘리먼트의 부모의 부모 => <tr>
		//not(this) : 테이블의 <tr>중에서 현재 선택한 <tr>을 제외한 <tr>에 배경색을 흰색으로 설정합니다.
		//즉, 선택한 수정(.update)만 'lightgray'의 배경색이 나타나도록 하고
		//선택하지 않은 수정의 <tr>엘리먼트는 흰색으로 설정합니다.
		//$("#comment .update").parent().parent().not(this).css('background', 'white');
		$(this).parent().parent().css("background","lightgray");
		//수정할 행의 배경색을 변경합니다.
		$(this).parent().parent().siblings().css("background","white");
		
	})
	
		$("#comment").on('click','.remove', function(){
			
		if(!confirm('정말 삭제하시겠습니까?')){
			return;
		}
		jik_comm_num = $(this).next().val(); // 댓글번호
		
		$.ajax({
			type : "post",
			url : "../jik_comm/delete",
			data : {
				"jik_comm_num" : jik_comm_num
				},
			success : function(result){
				if (result == 1){
					//page=1;
					getList(page,1); // 삭제 후 해당 페이지 보여줍니다.
				}//if
			}//success
		})//ajax end
		
	})
})
