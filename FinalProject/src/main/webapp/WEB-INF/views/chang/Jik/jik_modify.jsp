<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>MVC 게시판</title>
	<jsp:include page="../../main/header.jsp" />
	<script src="${pageContext.request.contextPath}/resources/chang_js/modifyform.js"></script>
	<style>
	.container{width:60%}
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	#upfile{display:none}
	</style>

</head>
<body>
	<%-- 게시판 수정 --%>
  <div class="container">
   <form action="modifyAction" 
   		 method="post" name="modifyform" enctype="multipart/form-data">
   	  <input type="hidden" name="jik_num" 	value="${jikdata.jik_num}">
   	  <input type="hidden" name="jik_file" 	value="${jikdata.jik_file}">
   	  <input type="hidden" name="before_file" 	value="${jikdata.jik_file}">
     <h1>MVC 게시판 - 수정</h1>
     <div class="form-group">
     	<label for="nick">글쓴이</label><input value="${jikdata.nick}" 
     	readOnly name="nick" type="text" class="form-control">
     </div>
     
     <div class="form-group">
       <label for="jik_subject">제목</label>
       <textarea name="jik_subject" id="jik_subject" rows="1" 
     			class="form-control"	maxlength="100">${jikdata.jik_subject}</textarea>
     </div>	
     
     <div class="form-group">
       <label for="jik_content">내용</label>
       <textarea name="jik_content" id="jik_content" 
     			rows="15" 	class="form-control">${jikdata.jik_content}</textarea>
     </div>	
     
      <div class="form-group read">
         <label for="jik_file">파일 첨부</label>
         <label for="upfile">
       	   <img src="../resources/image/attach.png" alt="파일첨부" width="20px">
         </label>
         <input type="file" id="upfile" name="uploadfile">
         <span id="filevalue">${jikdata.jik_original}</span>
        <img src="../resources/image/remove.png" alt="파일삭제" 
        		  width="10px" class="remove">
     </div>
     
     <div class="form-group">
     	<button type=submit class="btn btn-primary">수정</button>
     	<button type=reset  class="btn btn-danger"
     			onClick="history.go(-1)">취소</button>
     </div>
   </form>
  </div>
</body>
</html>