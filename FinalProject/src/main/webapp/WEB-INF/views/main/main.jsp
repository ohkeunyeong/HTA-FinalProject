<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>주말농장 임시 메인 페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
h1 {
  padding-top: 16px;
  padding-left: 20px;
  font-family: Verdana,Sans-serif
  }

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 50px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
}

.button2 {
  background-color: #6495ED; /* CornflowerBlue */
}

.button1 {width: 50%;}
.button2 {width: 50%;}

</style>
</head>
<body>
<h1>주말 농장 임시 메인 페이지</h1>
<br>
<jsp:include page="header.jsp" />  

	<div class="container">
   	<button class="button button1">	<a href="#">공지사항</a></button>
 	<button class="button button2"> <a href="#">FAQ</a></button>
  	</div>
  
</body>
</html>