<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>수다 농장 - 수정</title>
	<jsp:include page="../../main/header.jsp" />
	<script src="../resources/js/chang/free_modifyform.js"></script>
	<style>
	.container{width:60%} 
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	#upfile{display:none}
	</style>

</head>
<body>
<br><br><br><br><br>
	<%-- 게시판 수정 --%>
  <div class="container">
   <form action="modifyAction" 
   		 method="post" name="modifyform" enctype="multipart/form-data">
   	  <input type="hidden" name="free_num" 	value="${freedata.free_num}">
   	  <input type="hidden" name="free_id" 	value="${freedata.free_id}">
     <h1>수다 농장 - 수정</h1>
     <div class="form-group">
     	<label for="nick">글쓴이</label><input value="${freedata.nick}" 
     	readOnly name="nick" type="text" class="form-control">
     </div>
     
     <div class="form-group">
       <label for="free_subject">제목</label>
       <textarea name="free_subject" id="free_subject" rows="1" 
     			class="form-control"	maxlength="100">${freedata.free_subject}</textarea>
     </div>	
     
     <div class="form-group">
       <label for="free_content">내용</label>
       <textarea name="free_content" id="free_content" 
     			rows="15" 	class="form-control">${freedata.free_content}</textarea>
     </div>	
     
      <c:if test="${id !=null && id != ''}">
     <div class="form-group">
     	<button type=submit class="btn btn-primary">수정</button>
     	<button type=reset  class="btn btn-danger"
     			onClick="history.go(-1)">취소</button>
     </div>
     </c:if>
   </form>
  </div>
</body>
</html>