<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>Log In</title>
</head>
<body>
<div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">
            <h5 class="card-title text-center">로그인</h5>
            <form class="form-signin" method="post" action="login">
              <div class="form-label-group">
                <input type="text" id="id" name="id" class="form-control" placeholder="아이디" required autofocus>
              </div><br>

              <div class="form-label-group">
                <input type="password" id="pwd" name="pwd" class="form-control" placeholder="비밀번호" required>
              </div>
              
              <hr>
              
              <div class="form-label-group">
              <c:if test="${check == 1 }">
                <label>${message }</label>
              </c:if>
              </div>

              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">회원가입</button>
              <hr class="my-4">
              Forgot your <a href="javascript:void(0)" onclick="findid()">아이디</a> 또는 
              				<a href="javascript:void(0)" onclick="findpassword()">비밀번호</a>?
              <button class="btn btn-lg btn-secondary btn-block text-uppercase" onclick="location='join_form'">회원가입</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
  <script type="text/javascript">
  function findid(){
		var url="find_id_form";
		
		window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=500");
	}
  
  function findpassword(){
	  var url="find_password_form";
	  
	  window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=500");
  }
  </script>
<%@ include file="../main/footer.jsp"%>