<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버게시판 글쓰기</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/writeform.js"></script>
     <style>
     h1{font-size: 1.5rem; text-align:center; color:#1a92b9}
     .container{width:60%}
     label{font-weight: bold}
     #upfile{display: none}
     #attach{width: 20px;}
     </style>
</head>
<body>
<br><br><br>
<input type="hidden" id="id" value="${id}" name="id">
 <div class="container">
   <form action = "add" method="post" enctype="multipart/form-data"
       name="boardform">
     <input type="hidden" id="name" value="${name}" name="name">
     <h1>멤버게시판 글쓰기</h1>
     <div class="form-group">
       <label for="board_name">글쓴이</label>
       <input name="id" id="board_name" value="${id}"   readOnly
              type="text"   size="10"   class="form-control"
              placeholder="Enter board_name">           
      </div>
      
      <div class="form-group">
       <label for="board_pass">비밀번호</label>
       <input name="nong_pass" id="nong_pass"  type="password"  maxlength="30"
          class="form-control" placeholder="Enter board_pass">                      
      </div>

      <div class="form-group">
       <label for="board_subject">제목</label>
       <input name="nong_sub" id="nong_sub"  type="text"  maxlength="100"
          class="form-control" placeholder="Enter board_subject">                      
      </div>       
      
      <div class="form-group">
       <label for="board_content">내용</label>
       <textarea name="nong_con" id="nong_con"  rows="10"  
          class="form-control" ></textarea>                
      </div>       
      
      <div class="form-group">
       <label for="board_file">파일 첨부</label>
       <label for="upfile">
         <img id="attach" src="${pageContext.request.contextPath}/resources/image/oky/attach.png" alt="파일첨부">
       </label>
       <input type="file" id="upfile"  name="uploadfile"> 
       <span id="filevalue"></span>                
      </div> 
      <div class="form-group">
        <button type=submit class="btn btn-primary">등록</button>
        <button type=button  class="btn btn-danger" onclick="page_back();">취소</button>
      </div>           
   </form>
 </div>
</body>
</html>