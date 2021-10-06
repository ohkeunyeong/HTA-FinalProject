<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat</title>
<style>
	#chatIcon{
		position:absolute;
		right:10px;
		top:80px;
	}
</style>
</head>
<body>
	<div id="chatIcon">
		<img src="${pageContext.request.contextPath}/resources/image/jjs/chat.png" width="100px" height="100px">
	</div>
	
	<div class="well" style="display:none">
		<input type="text" id="msg" value="1212" class="form-control">
		<button id="btnSend" class="btn btn-primary">Send Message</button>
	</div>
	
<script>
$(function(){
	$('#chatIcon').click(function(){
		location.href = "chat";
	});
	
	$('#btnSend').on('click', function(evt){
		evt.preventDefault();
		if(socket.readyState !== 1){
			return;
		}
		let msg = $('input#msg').val();
		socket.send(msg);
	});
});
</script>
</body>
</html>