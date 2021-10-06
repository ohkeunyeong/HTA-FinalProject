<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="chatIcon.jsp" />
<script>
var socket = null;
$(function(){
	connectWS();
})

function connectWS(){
	var ws = new WebSocket("ws://localhost:8088/project/echo?bno=1234");
	socket = ws;
	
	ws.onopen = function(){
		console.log('Info : connection opened.');
	};

	ws.onmessage = function (event) {
		console.log("ReceiveMessage : " + event.data+"\n");
	};

	ws.onclose = function(event){
		console.log('Info : connection closed.');
		/*setTimeOut(function(){
			connect();
		}, 1000);*/
	};

	ws.onerror = function(error){
		console.log('Error : ', error);
	};

}
</script>
<!-- Main Footer -->
<footer class="main-footer">
	<!-- To the right -->
	<div class="float-right d-none d-sm-inline">Anything you want</div>
	<!-- Default to the left -->
	<strong>Copyright &copy; 2014-2019 <a href="https://adminlte.io">AdminLTE.io</a>.
	</strong> All rights reserved.
</footer>