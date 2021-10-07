<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">

<meta charset='UTF-8'>
<meta name="robots" content="noindex">
<link rel="shortcut icon" type="image/x-icon"
	href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel='stylesheet prefetch'
	href='https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css'>
<link rel='stylesheet prefetch'
	href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.2/css/font-awesome.min.css'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jjs/chat.css">
<style>
#frame .content {
	width: 100%
}

sup {
	position: relative;
	top: -10px;
	right: -95%;
	font-size: 3px;
}

.inout {
	text-align: center;
}
</style>
</head>
<body>
	<div id="frame">
		<div class="content">
			<div class="contact-profile">
				<img src="${pageContext.request.contextPath}/resources/image/jjs/among us.png" alt="avatar"/>
				<p>${name}</p>
				<div class="social-media">
					<i class="fa fa-facebook" aria-hidden="true"></i>
					<i class="fa fa-twitter" aria-hidden="true"></i>
					<i class="fa fa-instagram" aria-hidden="true"></i>
				</div>
			</div>
			<div class="messages">
				<ul>
					
				</ul>
			</div>
			<div class="message-input">
				<div class="wrap">
					<input type="text" id="write"
						placeholder="Write your message..." />
					<button class="exit">나가기</button>
				</div>
			</div>
		</div>	
	</div>
	<script>
		function newMessage(){
			var message = $(".message-input input").val();
			
			if($.trim(message) == ''){
				return false;
			}
			
			output = '<li class="sent">'
					+ '<img src="upload${filename}" alt=""/>'
					+ '<p></p></li>';
			$(output).appendTo($('.messages ul'));
			
			// 입력한 내용들을 문자열로 변환하기 위해 text()를 이용합니다.
			$('.messages>ul>li').last().find('p').text(message);
			
			$(".message-input input").val('');
			
			moveScroll();
			
			return message;
		}; // newMessage end
		
		$(".exit").click(function(){
			if(confirm("정말로 나가시겠습니까?")){
				send("${name}님이 퇴장하셨습니다.out");
				ws.close();
			}
		}); // $('.exit').click end
		
		$(window).on("keyup", function(e){
			if(e.which == 13){ // 엔터
				var message = newMessage(); // 화면에 보이는 메시지 전송
				if(message){ // 메시지가 존재하는 경우
					send(message); // 소켓에 보내는 메시지 전송				
				}
			}
		}); //keyup end
		
		// ws = new WebSocket("ws://localhost:8088/mychat/boot.do?id=${name}&filename=${filename}");
		var url = "ws://localhost:8088${pageContext.request.contextPath}/echo?id=${id}&nick=${nick}";
		ws = new WebSocket(url);
		
		// 웹 소켓이 연결되었을 때 호출되는 이벤트
		ws.onopen = function(event){
			console.log("연결되었습니다.");
		}
		
		// 서버에서 전송하는 데이터를 받으려면 message이벤트를 구현하면 됩니다.
		// 웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트입니다.
		ws.onmessage = function(event){
			console.log("받은 데이터 : " + event.data);
			// 님이 퇴장하셨습니다.out
			response(event.data);
		}
		
		// 웹 소켓이 닫혔을 때 호출되는 이벤트입니다.
		ws.onclose = function(event){
			location.href="logout";
		}
		
		function send(message){
			ws.send(message); // 웹 소켓으로 message를 보냅니다.
		}
		
		function moveScroll(){
			console.log($('.messages')[0].scrollHeight);
			// scrollTop()은 선택한 요소의 스크롤바 수직 위치를 반환하거나 스크롤바 수직 위치를 정합니다.
			// scrollHeight : 스크롤 시키지 않았을때의 전체 높이
			$('.messages').scrollTop($(".messages")[0].scrollHeight);
		}
		
		function response(text){
			// text 전달 형식 - 
			arr = text.split('&');
			message = arr[2];
			var out = "님이 퇴장하셨습니다.out";
			var inin = "님이 입장하셨습니다.in";
			console.log(message)
			
			// 입장과 퇴장의 경우 css가 가운데로 위치해야 해서 클래스 inout을 이용합니다.
			if(message.indexOf(out) > -1 || message.indexOf(inin) > -1){
				index = message.lastIndexOf('.');
				output = "<li class='inout'><p></p></li>";
				message = message.substring(0, index);
			}else{
				name = arr[0];
				filename = arr[1];
				output = "<li class='replies'>"
						+ "<img src='upload" + filename + "'>"
						+ "<sup>" + name + "</sup><p></p></li>";
			}
			
			$('#frame > div.content > div.messages > ul').append(output);
			$(".messages>ul>li").last().find('p').text(message);
			
			moveScroll();
		} // response() end
	</script>
</body>
</html>