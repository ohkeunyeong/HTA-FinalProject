<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
     <title>멤버게시판 답글쓰기</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/oky/reply.js"></script>
     <style>
     h1{font-size: 1.5rem; text-align:center; color:#1a92b9}
     .container{width:60%}
     label{font-weight: bold}
     </style>
</head>
<body>
 <div class="container">
   <form action = "replyAction" method="post" name="boardform">
     <input type="hidden" name="nong_re_ref" value="${boarddata.nong_re_ref}">
     <input type="hidden" name="nong_re_lev" value="${boarddata.nong_re_lev}">
     <input type="hidden" name="nong_re_seq" value="${boarddata.nong_re_seq}">
     <h1>멤버게시판 답글쓰기</h1>
     <div class="form-group">
       <label for="board_name">글쓴이</label>
       <input name="id" id="board_name" value="${id}"   readOnly
              type="text"      class="form-control">           
      </div>
      <div class="form-group">
       <label for="board_subject">제목</label>
       <textarea name="nong_sub" id="board_subject" rows="1" 
        maxlength="100" class="form-control" >Re:${boarddata.nong_sub}</textarea>                 
      </div>       
      
      <div class="form-group">
       <label for="board_content">내용</label>
       <textarea name="nong_con" id="board_content"  rows="10"  
          class="form-control" ></textarea>                
      </div>       
      
      <div class="form-group">
       <label for="board_pass">비밀번호</label>
       <input name="nong_pass" id="board_pass"  
              type="password"   class="form-control">                      
      </div>
 
      <div class="form-group">
        <input type=submit class="btn btn-primary" value="등록">
        <input type=button class="btn btn-danger" value="취소"
                onClick="history.go(-1)">
      </div>           
   </form>
 </div>
</body>
</html>