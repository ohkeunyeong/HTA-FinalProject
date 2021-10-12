<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<style>

textarea {
	resize: none;
}
.form-control:disabled, .form-control[readonly] {
    background-color: #fff;
}
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	.container{width:60%}
	label{font-wight:bold}
	#upfile{display:none}
	#f{width:20px}
</style>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
	<script>
	$(function(){
	$('#board_num').val(opener.document.getElementById('jik_num').value);
	$('#board_id').val(opener.document.getElementById('Jik_id').value);
	$('#board_subject').val(opener.document.getElementById('jik_subject').value);
	$('#board_content').val(opener.document.getElementById('jik_content').value);
	
	function submit()
	{
		var report = $("#report").serialize();
		
		$.ajax(
		{
			url : '../admin/reportAdd',
			type:"POST"
			data : report,
			success : function(rdata){		
						alert("신고 되었습니다.")
						window.close();
					},//success
			error : function(xhr, status) {
			                alert(xhr + " : " + status);
			            }
		});
	}
	});
	</script>
</head>
<body>
  <div class="container">
   <form method="post" id="report" name="report">
   	 <br>
     <hr>
     <h1>신고하기</h1>
     <hr>
     <br>
     <input type="hidden" name="board_num" id="board_num">
     <div class="form-group">
     	<label for="nick">글 작성자</label>
     	<input name="board_id" id="board_id" 
     		   readOnly
     		   type="text"	size="10" maxlength="30"
     		   class="form-control"
     		  >
     </div>

     <div class="form-group">
       <label for="board_subject">글 제목</label>
       <input name="board_subject" id="board_subject" type="text" maxlength="100"
     			class="form-control" readOnly>
     </div>	
     <div class="form-group">
       <label for="board_content">글 내용</label>
       <textarea name="board_content" id="board_content" 
     			rows="10" 	class="form-control" readOnly></textarea>
     </div>	
     <div class="form-group">
       <label for="report_content">신고 사유</label>
             <textarea name="report_content" id="report_content" 
     			rows="10" 	class="form-control" placeholder="신고사유를 적어주세요."></textarea>
     </div>	
     <div class="form-group">
     	<button type=button class="btn btn-primary" onClick='submit(); return false;'>신고하기</button>
     	<button type=button class="btn btn-danger"  onClick='window.close()'>취소</button>
     </div>
   </form>
  </div>
</body>
</html>