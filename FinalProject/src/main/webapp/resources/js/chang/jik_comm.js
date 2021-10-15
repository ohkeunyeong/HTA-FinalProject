 // $('.center.noborder')영역에 좋아요 이미지와 버튼 달리 보여주기
function getLike(){
	 $.ajax({
		 url : '../jik/isLike',
		 data : {
			 id : $("#Loginid").val(),
			 num : $("#jik_num").val()
		 },
		 type : 'post',
		 success : function(rdata){
			 var output="";
			 if(rdata==1){
				 $('.center.noborder').empty();
				 output += "<img src='../resources/image/chang/like.png' width='50px'>"
				 output += "<button class='btn btn-light' id='like' name='like' onclick='like();'>좋아요</button>"
				
			}else{
				 $('.center.noborder').empty();
				 output += "<img src='../resources/image/chang/dlike.png' width='50px'>"
				 output += "<button class='btn btn-light' id='like' name='like' onclick='like();'>좋아요</button>"
			}
			 $('.center.noborder').html(output);
		 }
	 })
}

//좋아요 버튼 클릭 시 
function like(){
	var output="";
	 $.ajax({
			 url : '../jik/like',
			 data : {
				 id : $("#Loginid").val(),
				 num : $("#jik_num").val()
			 },
			 type : 'post',
			 success : function(rdata){
				 if(rdata==1){
					 $('.center.noborder').empty();
					 output += "<img src='../resources/image/chang/like.png' width='50px'>"
					 output += "<button class='btn btn-light' id='like' name='like' onclick='like();'>좋아요</button>"
					 $('.center.noborder').html(output);
				}else{
					if(confirm("좋아요를 취소 하시겠습니까?")){
					$.ajax({
							url : '../jik/dlike',
								data : {
										id : $("#Loginid").val(),
										num : $("#jik_num").val()
										},
										type : 'post',
										success : function(rdata){
											if(rdata==1){
												$('.center.noborder').empty();
												output += "<img src='../resources/image/chang/dlike.png' width='50px'>"
												output += "<button class='btn btn-light' id='like' name='like' onclick='like();'>좋아요</button>"
												$('.center.noborder').html(output);
											}
										}
					})
					}else{
						return false;
					}
				}
			 }
	 })
}

function getList(currentPage,state){
	    option=state;//현재 선택한 댓글 정렬방식을 저장합니다. 1=>등록순, 2=>최신순
	    
		$.ajax({
			type: "post",
			url: "../jik_comm/list",
			data : {
				"jik_num" : $("#jik_num").val(),
				"page" : currentPage,
				"state" : state
			},
			dataType:"json",
			success:function(rdata){
				//댓글의 총 갯수가 표시 됩니다.
				$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
				var red1='red';		var red2='red';
				if(option==1){  //등록순인 경우 등록순이 'red', 최신순이 'gray'로 글자색을 나타냅니다.
					red2='gray';
				}else if(option==2){ //최신순인 경우 등록순이 'gray', 최신순이 'red'로 글자색을 나타냅니다.
					red1='gray';
				}
				var output="";
				
				   output += '<li class="comment_tab_item ' +  red1 + '" >'
				   		  + ' <a href="javascript:void(0);" onclick="getList(1,1);" class="comment_tab_button">최신순 </a>'
                          + '</li>'
                          + '<li class="comment_tab_item ' +  red2 + '" >'
                          + '   <a href="javascript:getList(1,2)" class="comment_tab_button">등록순</a>'
                          + '</li>'
                     $('.comment_tab_list').html(output);//댓글 수 등록순 최신순 출력
               if(rdata.listcount > 0){    
				    output='';
					$(rdata.list).each(function(){
						var lev = this.jik_comm_re_lev;
						var comment_reply='';
						var s = this.jik_comm_secret.toString().trim();
						//레벨에 따라 왼쪽 여백줍니다.
						if(lev>=1){
							comment_reply = ' CommentItem--reply lev1';//margin-left: 46px;
						}
						
					
						
					   output  += '<li id="' + this.jik_comm_num + '" class="CommentItem' + comment_reply + '">'
							   + '   <div class="comment_area">'
							   + '    <div class="comment_box">'
							   + '      <div class="comment_nick_box">'
							   + '            <div class="comment_nick_info">'
							   + '               <div class="comment_nickname">' + this.nick  + '</div>'
							   + '            </div>' //comment_nick_info                  
							   + '       </div>'  // comment_nick_box
							   + '     </div>'   //comment_box
							   + '    <div class="comment_text_box">'
							   + '       <p class="comment_text_view">';
							   if(s=='Y'){
								   if(this.jik_id== $("#Loginid").val() || this.id== $("#Loginid").val()){
									   output += '         <span class="text_comment">' + this.jik_comm_content + '</span>';
								   }else{
									   output += '         <span class="text_comment">' + "비밀 댓글입니다." + '</span>';
								   }
							   }else if(s=='N'){
								   output += '         <span class="text_comment">' + this.jik_comm_content +'</span>';
							   }
						
					   output  += '       </p>'
							   + '    </div>' //comment_text_box
							   + '    <div class="comment_info_box">'
							   + '      <span class="comment_info_date">' + this.jik_comm_date + '</span>';
						
						   	  output += '  <a href="javascript:replyform(' + this.jik_comm_num +',' 
						   	         + lev + ',' + this.jik_comm_re_seq +',' 
						   	         + this.jik_comm_re_ref +')"  class="comment_info_button">답글쓰기</a>'
						     
						   	  output += '   </div>' //comment_info_box;
							   
						 
						//글쓴이가 로그인한 경우 나타나는 더보기입니다.
                        //수정과 삭제 기능이 있습니다.							
						if($("#Loginid").val()==this.id ||$("#Loginid").val()=='admin'){ 
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
						}else{
							 output +=  '<div class="comment_tool">'
								   + '    <div title="더보기" class="comment_tool_button">'
								   + '       <div>&#46;&#46;&#46;</div>' 
								   + '    </div>'
								   + '    <div id="commentItem' +  this.jik_comm_num + '"  class="LayerMore">' //스타일에서 display:none; 설정함
								   + '     <ul class="layer_list">'							   
								   + '      <li class="layer_item">'
								   + ' 		<a href="javascript:void(0);" onclick="#" class="layer_button">신고하기 </a>'
								   + '     </div>'//LayerMore
								   + '   </div>'//comment_tool
						}
							   
						output += '</div>'// comment_area
							   + '</li>'//li
					})//each
					 $('.comment_list').html(output);
					
					if(rdata.listcount > rdata.list.length){
						$("#message").text("더보기");
					}else{
						$("#message").text("");
					}
			 }//if(rdata.boardlist.length>0)
			 else{ //댓글 1개가 있었는데 삭제하는 경우 갯수는 0이라  if문을 수행하지 않고 이곳으로 옵니다.
				   //이곳에서 아래의 두 영역을 없앱니다.
				 $('.comment_list').empty(); 
			 }
			}//success end
		});//ajax end
		
		 
	}//function(getList) end
//더보기 클릭 후 - > 수정 클릭한 경우에 수정 폼을 보여줍니다.
function updateForm(jik_comm_num){ //num : 수정할 댓글 글번호
	
	//선택한 내용을 구합니다.
	var content=$('#'+jik_comm_num).find('.text_comment').text();
	
	var selector = '#'+jik_comm_num+'.comment_area'
	$(selector).hide(); //selector 영역  숨겨요 - 수정에서 취소를 선택하면 보여줄 예정입니다.
	
	//$('.comment_list+.CommentWriter').clone() : 기본 글쓰기 영역 복사합니다.
	//글이 있던 영역에 글을 수정할 수 있는 폼으로 바꿉니다.
	selector=$('#'+jik_comm_num);
	selector.append($('#message+.CommentWriter').clone());
	
	//댓글쓰기 영역 숨깁니다.
	$('#message+.CommentWriter').hide();
	
	//수정 폼의 <textarea>에 내용을 나타냅니다.
	selector.find('textarea').val(content);
	
	
	//'.btn_register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가하며 등록을 수정완료
	selector.find('.btn_register').attr('data-id',jik_comm_num).addClass('update').text('수정완료');
	
	//폼에서 취소를 사용할 수 있도록 보이게 합니다.
	selector.find('.btn_cancel').css('display','block').addClass('update_cancel');
	
	selector.find('.comment_inbox_count').text(content.length+"/200");
}//function(updateForm) end

//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(jik_comm_num){//num : 댓글 번호
	if(!confirm('정말 삭제하시겠습니까')){
		return;
	}
	
	$.ajax({
		url:'../jik_comm/delete',
		data:{jik_comm_num:jik_comm_num},
		success:function(rdata){
			if(rdata==1){
				getList(1,option);
			}
		}
	})
}//function(del) end


//답글 달기 폼
function replyform(jik_comm_num,lev,seq,ref){
	//댓글달기 폼이 열려있다는 것은 다른 폼이 열려있지 않은 경우입니다.
	if($('#message+.CommentWriter').css('display')=='block'){
		var output = '<li class="CommentItem CommentItem--reply lev'
				   +  lev 	+ ' CommentItem-form"></li>'
				   
		var selector = $('#'+jik_comm_num);
		
		//선택한 글 뒤에 답글 폼을 추가합니다.
		selector.after(output);
		
		//글쓰기 영역 복사합니다.
		output=$('#message+.CommentWriter').clone();
		
		//댓글쓰기 영역 숨깁니다.
		$('#message+.CommentWriter').hide();
		
		
		//더보기를 누른 상태에서 답글 달기 폼을 연 경우 더보기의 영역 보이지 않게 합니다.
		$(".CommentBox .LayerMore").css('display','none');
		
		//선택한 글 뒤에 답글 폼 생성합니다.
		selector.next().html(output);
		
		//답글 폼의 <textarea>의 속성 'placeholder'를 '답글을 남겨보세요'로 바꾸어 줍니다.
		selector.next().find('textarea').attr('placeholder','답글을 남겨보세요');
		
		//답글 폼의 '.btn_cancel'을 보여주고 클래스 'reply_cancel'를 추가합니다.
		selector.next().find('.btn_cancel').css('display','block')
							.addClass('reply_cancel');
		
		//답글 폼의 '.btn_register'에 클래스 'reply' 추가합니다.
		//속성 'data-ref'에 ref, 'data-lev'에 lev, 'data-seq'에 seq값을 설정합니다.
		selector.next().find('.btn_register').addClass('reply').text('답글완료')
					.attr('data-ref',ref).attr('data-lev',lev).attr('data-seq',seq);
	}else{
		alert('다른 작업 완료 후 선택하세요')
	}
}//function(replyform) end
//더보기 클릭 후 - > 수정 클릭한 경우에 수정 폼을 보여줍니다.
$(function(){
	var page=1;
	option=1;
	count = parseInt($("#count").text());
	
	getLike();//좋아요 이미지와 버튼 불러옵니다.
	
	if(count !=0){ //댓글 갯수가 0이 아니면
		getList(1,option) // 첫 페이지의 댓글을 구해 옵니다. ( 한 페이지에 3개씩 가져옵니다.)
	}else { //댓글이 없는 경우 
		$("#message").text("등록된 댓글이 없습니다.")
	}
	
	//getList를 새로 불러오기 때문에 대댓글 쓰기 기능 동작시 작동하지 않도록 함. 
	$("#message").click(function(){
		if($('#message+.CommentWriter').css('display')=='block'){
			getList(++page,option);
		}else{
			alert('작업 완료 후 가능합니다.')
		}
	}); // click end
	
	getList(page,option); // 처음 로드 될때는 등록순 정렬

	
	
	
	$('.CommentBox').on('keyup','.comment_inbox_text',function(){
		jik_comm_content = $(this).val();
		length = $(this).val().length;
		if(length > 200){
			length = 200;
			jik_comm_content = jik_comm_content.substring(0, length);
		}
		$(this).prev().text(length+'/200');
	})//'keyup','.comment_inbox_text',function(){
	
	//등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
	$('#message+.CommentWriter .btn_register').click(function(){
		var content=$('.comment_inbox_text').val();
		if(!content){//내용없이 등록 클릭한 경우
			alert("댓글을 입력하세요");
			return;
		}
		if($('.secret').is(':checked')){
			secret='Y'
			$('.secret').attr('checked',false);
		}else{
			secret='N'
		}
		$.ajax({
			url : "../jik_comm/add",
			data : {
					"jik_comm_content" : $(".comment_inbox_text").val(),
					"id" : $("#Loginid").val(),
					"nick" : $("#Loginnick").val(),
					"jik_board_num" : $("#jik_num").val(),
					"jik_comm_re_lev" : 0,
					"jik_comm_re_seq" : 0,
					"jik_comm_secret" : secret,
					"jik_id" : $("#Jik_id").val()
			},
			type : 'post',
			success : function(rdata){
				if (rdata == 1){
					getList(page,option);
				}
			}
		})//ajax
		
		$('.comment_inbox_text').val('');//textarea 초기화
		$('.comment_inbox_count').text('');//입력한 글 카운트 초기화
	})//click
	
		//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라져요-toggle()이용
	 $('.comment_list').on('click','.comment_tool_button',function(){
		 var selector = $(this).next();
		 
		 //댓글쓰기 폼이 나타난 경우에만 더보기를 선택할 수 있도록 합니다.
		 if($('#message+.CommentWriter').css('display')=='block'){
			 selector.toggle();
			 
			 //더보기를 여러개 선택하더라도 최종 선택한 더보기 한개만 보이도록 합니다.
			 if(selector.css('display')=='block'){//현재 더보기가 열린 경우
				 //$(".LayerMore")중에서 selector가 아닌 객체들의 display 속성을 none으로 설정합니다.
				 $(".LayerMore").not(selector).css('display','none'); 
			 }
		 }else{
			 //답글쓰기 폼이나 수정 폼이 열려있는 상황에서 더보기를 클릭한 경우
			 alert('작업 완료 후 선택해 주세요')
		 }
	 })//'.comment_tool_button' click end
	 
	 //더보기를 선택한 후 수정이나 삭제를 클릭한 경우 수정과 삭제 영역이 사라지게 합니다.
	 $(".comment_list").on('click','.LayerMore',function(){
		 $(this).hide();
	 })//'.LayerMore' click end
	 
	 //수정 후 수정완료 클릭한 경우
	 $('.CommentBox').on('click','.update',function(){
		 console.log("수정완료")
		 
		 //댓글쓰기 영역 보이도록 합니다.
		 $('#message+.CommentWriter').show();
		 
		 var content = $(this).parent().parent().find('textarea').val();
		 if(!content){
			 alert('수정할 내용을 입력하세요');
			 return
		 }
		 if($('.secret').is(':checked')){
				secret='Y'
				$('.secret').attr('checked',false);
			}else{
				secret='N'
			}
		 $.ajax({
			 url :'../jik_comm/update',
			 data:{jik_comm_num:$(this).attr('data-id'), jik_comm_content:content, jik_comm_secret:secret},
			 success:function(rdata){
				 if(rdata==1){
					getList(page,option); 
				 }//if
			 }//success
		 });//ajax
	 })//수정후 등록 버튼을 클릭한 경우
	 
	 //수정 후 취소 클릭한 경우
	 $('.CommentBox').on('click','.update_cancel',function(){
		 //댓글 번호를 구합니다.
		 var jik_comm_num=$(this).next().attr('data-id');
		 var selector='#' +jik_comm_num;
		 
		 //selector의 후손 중 .CommentWriter 영역 삭제 합니다.
		 $(selector + ' .CommentWriter').remove();
		 
		 //댓글쓰기 영역 보이도록 합니다.
		 $('#message+.CommentWriter').show();
		 
		 //숨겨두었던 .comment_area 영역 보여줍니다.
		 $(selector + '>.comment_area').css('display','block');
	 })//수정 후 취소 버튼을 클릭한 경우
	
	 
	 
	 //답글 달기 - > 답변완료 클릭한 경우
	 $('.CommentBox').on('click','.reply',function(){
		 
		 var content=$(this).parent().parent().find('.comment_inbox_text').val();
		 if(!content){
			 alert('답변 내용을 입력하세요');
			 return
		 }
		 
		 //댓글쓰기 영역 보이도록 합니다.
		 $('#message+.CommentWriter').show();
		 
		 if($('.secret').is(':checked')){
				secret='Y'
				$('.secret').attr('checked',false);
			}else{
				secret='N'
			}
		 
		 $.ajax({
			 url : '../jik_comm/reply',
			 data : {
				 id : $("#Loginid").val(),
				 nick : $("#Loginnick").val(),
				 jik_comm_content : content,
				 jik_board_num : $("#jik_num").val(),
				 jik_comm_re_lev : $(this).attr('data-lev'),
				 jik_comm_re_ref : $(this).attr('data-ref'),
				 jik_comm_re_seq : $(this).attr('data-seq'),
				 jik_comm_secret : secret,
				 jik_id : $("#Jik_id").val()
			 },
			 type : 'post',
			 success : function(rdata){
				 if(rdata==1){
						getList(page,option); 
				}//if
			 }
		 })//ajax
	 })//답변 달기 등록 버튼을 클릭한 경우
	/* 
	 * 새창띄우기 -- 이상하게 작동됨.
		function popupOpen(){
	
		 window.open("../jik/report", "신고", "width=500, height=700, scrollbars=no, resizable=no");
		 return false;
		
	}
	 $(".report_button").click(function(){
		 popupOpen();
		
		 
	 })
	 */
	
	 
	 //좋아요 버튼 클릭 시 
	 $('#like').click(function(){
		 console.log("asdfasdfasdfasdfasdf")
	 	var output="";
		 $.ajax({
				 url : '../jik/like',
				 data : {
					 id : $("#Loginid").val(),
					 num : $("#jik_num").val()
				 },
				 type : 'post',
				 success : function(rdata){
					 if(rdata==1){
						 $('.center.noborder').empty();
						 output += "<img src='../resources/image/chang/like.png' width='50px'>"
						 output += "<button class='btn btn-light' id='like' name='like'>좋아요</button>"
						
					}
					 $('.center.noborder').html(output);
				 }
			 })
		})
	//답변달기 후 취소 버튼을 클릭한 경우
	$('.CommentBox').on('click','.reply_cancel',function(){
		$(this).parent().parent().parent().remove();
			
		//댓글쓰기 영역 보이도록 합니다.
		$('#message+.CommentWriter').show();
	})//수정 후 취소 버튼을 클릭한 경우

	 
})//ready