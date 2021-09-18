<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<head>
  <title>헤더</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <style>
  	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

	*{
		font-family: 'Do Hyeon', sans-serif;
		
	}
  </style>
</head>
<body>

<div class="container">
  <div class="btn-group">
    <div class="btn-group"  style="padding:128px 16px">
      <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
      	내농장
      </button>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="createmy">농장생성</a>
        <a class="dropdown-item" href="cal?name=">캘린더</a>
        <a class="dropdown-item" href="acc?name=">가계부</a>
        <a class="dropdown-item" href="nong?name=">멤버게시판</a>
      </div>
    </div>
    <div class="btn-group"  style="padding:128px 16px">
      <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
      	농장모듬
      </button>
      <div class="dropdown-menu" data-toggle="tab-hover">
        <a class="dropdown-item" href="jik/list" >직거래 장터</a>
        <a class="dropdown-item" href="#">수다 농장</a> <!-- 자유 게시판  -->
        <a class="dropdown-item" href="#">품앗이 장터</a> <!-- 인력게시판 -->
        <a class="dropdown-item" href="#">궁금해요</a>
        <a class="dropdown-item" href="#">출석 도장</a>
      </div>
    </div>
       <div class="btn-group"  style="padding:128px 16px">
      <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
      	굿즈 장터
      </button>
      <div class="dropdown-menu" data-toggle="tab-hover">
        <a class="dropdown-item" href="#" >퍼스나콘</a>
        <a class="dropdown-item" href="#">농기구</a>
         <a class="dropdown-item" href="#">주말 굿즈</a>
        
      </div>
    
    </div>
     <div class="btn-group"  style="padding:128px 16px">
      <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
      	장바구니
      </button>
      <!-- <div class="dropdown-menu" data-toggle="tab-hover">
        <a class="dropdown-item" href="#" >Tablet</a>
        <a class="dropdown-item" href="#">Smartphone</a>
      </div> -->
    </div>
  </div>
  &nbsp;&nbsp;&nbsp;
  <a href="#">검색</a>&nbsp;&nbsp;&nbsp;
  <a href="#">로그인</a>&nbsp;&nbsp;&nbsp;
  <a href="#">회원가입</a>&nbsp;&nbsp;&nbsp;
  <a href="${pageContext.servletContext.contextPath}/admin/main">관리자</a>
</div>
<br>
<hr>
</body>
</html>
