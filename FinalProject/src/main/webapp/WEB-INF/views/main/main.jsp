<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시메인</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css" type="text/css" rel ="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
<br><br><br><br><br>
<h1>임시메인 페이지</h1>
<jsp:include page="header.jsp" />  

<div class="container">

  <h4>내 농장 일정</h4>
  <p>오늘 우리 농장의 할일을 확인해요</p>


<div class="row" style="margin:20px 20px 50px 20px">
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">2021.09.19</h5>
        <p class="card-text">오전 9시:약치기</p>
        <a href="#" class="btn btn-primary">상세보기</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">2021.09.20</h5>
        <p class="card-text">일정 내용 적는 부분</p>
        <a href="#" class="btn btn-primary">상세보기</a>
      </div>
    </div>
  </div>
  <div class="col-sm-4">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">2021.09.21</h5>
        <p class="card-text">일정 내용 적는 부분</p>
        <a href="#" class="btn btn-primary">상세보기</a>
      </div>
    </div>
  </div>
</div>

</div>

<jsp:include page="footer.jsp" />  
</body>
</html>



