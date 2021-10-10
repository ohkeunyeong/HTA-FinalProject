<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head> 
     <title>멤버게시판 수정</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/oky/modify.js"></script>
     <style>
     h1{font-size: 1.5rem; text-align:center; color:#1a92b9}
     .container{width:60%}
     label{font-weight: bold}
     #upfile{display: none}
     .remove{width: 20px;}
     </style>
     
<script>
  if('${result}'== 'passFail') {
	  alert("비밀번호가 다릅니다.")
  }
</script>
</head>
<body>
<br><br><br>
   <%-- 게시판 수정 --%>
  <div class="container">
   <form action="nongmodifyAction" 
          method="post" name="modifyform" enctype="multipart/form-data">
        <input type="hidden" id="name" value="${name}" name="name">
        <input type="hidden" name="nong_num"       value="${boarddata.nong_num}">
        <input type="hidden" name="nong_file"      value="${boarddata.nong_file}">
        <input type="hidden" name="before_file"     value="${boarddata.nong_file}">
     <h1>멤버 게시판 - 수정</h1>
     <div class="form-group">
        <label for="board_name">글쓴이</label><input value="${boarddata.id}" 
        readOnly name="id" type="text" class="form-control">
     </div>
     
     <div class="form-group">
       <label for="board_subject">제목</label>
       <textarea name="nong_sub" id="board_subject" rows="1" 
              class="form-control"   maxlength="100">${boarddata.nong_sub}</textarea>
     </div>   
     
     <div class="form-group">
       <label for="board_content">내용</label>
       <textarea name="nong_con" id="board_content" 
              rows="15"    class="form-control">${boarddata.nong_con}</textarea>
     </div>   
     <%-- 원문글인 경우에만 파일 첨부 수정 가능합니다. --%>
     <c:if test="${boarddata.nong_re_lev==0 }">
       <div class="form-group read">
         <label for="board_file">파일 첨부</label>
         <label for="upfile">
             <img src="${pageContext.request.contextPath}/resources/image/oky/attach.png" alt="파일첨부" width="20px">
         </label>
         <input type="file" id="upfile" name="uploadfile">
         <span id="filevalue">${boarddata.nong_ori}</span>
        <img src="${pageContext.request.contextPath}/resources/image/oky/remove.png" alt="파일삭제" width="10px" class="remove">
       </div>
     </c:if>
       
     <div class="form-group">
       <label for="board_pass">비밀번호</label>
        <input name="nong_pass" 
              id="board_pass" type="password" size="10" maxlength="30"
              class="form-control"   placeholder="Enter board_pass" value="">
     </div>   
     <div class="form-group">
        <button type=submit class="btn btn-primary">수정</button>
        <button type=reset  class="btn btn-danger"
              onClick="history.go(-1)">취소</button>
     </div>
   </form>
  </div>
<jsp:include page="../../main/footer.jsp" />   
</body>
</html>