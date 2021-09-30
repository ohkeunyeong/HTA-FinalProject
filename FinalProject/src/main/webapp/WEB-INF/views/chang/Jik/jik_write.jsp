<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<jsp:include page="../../main/header.jsp" />
	<script src="../resources/js/chang/writeform.js"></script>
	<style>
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	.container{width:60%}
	label{font-wight:bold}
	#upfile{display:none}
	img{width:20px}
	</style>
</head>
<body>
  <div class="container">
   <form action="add" method="post" enctype="multipart/form-data" name="jikform">
     <h1>MVC 게시판 -write 페이지</h1>
     <div class="form-group">
     	<label for="nick">글쓴이</label>
     	<input name="nick" id="nick" value="${nick}"
     		   readOnly
     		   type="text"	size="10" maxlength="30"
     		   class="form-control"
     		   placeholder="Enter nick">
     </div>

     <div class="form-group">
       <label for="jik_subject">제목</label>
       <input name="jik_subject" id="jik_subject" type="text" maxlength="100"
     			class="form-control"	placeholder="Enter jik_subject">
     </div>	
     <div class="form-group">
       <label for="jik_content">내용</label>
       <textarea name="jik_content" id="jik_content" 
     			rows="10" 	class="form-control"></textarea>
     </div>	
     <div class="form-group">
       <label for="jik_file">파일 첨부</label>
       <label for="upfile">
       	  <img src="../resources/image/chang/attach.png" alt="파일첨부">
       </label>
       <input type="file" id="upfile" name="uploadfile">
       <span id="filevalue"></span>
     </div>	
     <div class="form-group">
     	<button type=submit class="btn btn-primary">등록</button>
     	<button type=reset  class="btn btn-danger">취소</button>
     </div>
     <input type="hidden" name="jik_id" id="jik_id" value="${id}">
   </form>
  </div>
</body>
</html>