<!-- 출처 : https://codepen.io/EthanMcFarlin/pen/yZLbGy  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
     <title>메일문의</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/contactus.css">
     <script src="${pageContext.request.contextPath}/resources/js/oky/contactus.js"></script>      
</head>
<body>
<br><br><br>
<header style="color: #28A745">1:1문의</header>

<form action="mailsend" method="post" id="form" class="topBefore">
<input type="hidden" name="userid"  value= "${id}" readOnly>
<input type="hidden" name="username" value= "${list.name}" readOnly>
<input type="hidden" name="email" value= "${list.mail}" readOnly>
<input type="hidden" name="phone" value= "${list.tel}" readOnly>
<input type="hidden" name="sender" value= "okycontactus@gmail.com" readOnly>


  <input type="text" name="receiver"value= "가입한 메일 주소로 답장을 보내드립니다." readOnly>
  <input type="text" name="subject" id="subject" placeholder="제목">
  <textarea name="content" id="content"  placeholder="내용"></textarea>
  <input id="send" type="submit" value="보내기">
  <input type="button" id="cancelbtn" class="cancelbtn" value="취소">


</form> 
</body>
</html>