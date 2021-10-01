<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 농장 생성</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/createmynong.js"></script>
</head>
<body>
<jsp:include page="../../main/header.jsp" /> 
 <form name="createform" action="createProcess" method="post">
<input type="hidden" id="id" value="${id}" name="id">
<h1>내 농장 만들기</h1>
<div>농장명은 영문자 숫자로 최대 10글자까지 가능합니다</div>
<div>농장명 :
<input type="text" name="mynong_name" id="name" placeholder="입력해주세요" required maxLength="10">
<span id="message"></span>
</div>
<button type="submit" class="submitbtn">농장생성</button>
          
          
</form>

</body>
</html>