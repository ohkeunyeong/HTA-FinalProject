<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>회원관리 시스템 회원수정 페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/join.css" type="text/css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
h3{ text-align: center; color: #1a92b9;}
input[type=file]{
 display:none;
 }
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<br><br><br><br>
<script>
if('${message}'!=''){
alert('${message}')
}
</script>
<form name="updateform" action="updatebeforeProcess" method="post">
         <h3>회원 정보 비밀번호 확인</h3>
         
         <b>비밀번호</b>
         <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
         <span id="pass_message"></span>
         
         <div class="clearfix">
          <button type="submit" class="submitbtn">확인</button>
          <button type="reset" class="cancelbtn">취소</button>          
        </div>       
     </form>

</body>
</html>