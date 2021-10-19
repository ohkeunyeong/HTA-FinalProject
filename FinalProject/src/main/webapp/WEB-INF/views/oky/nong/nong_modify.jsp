<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head> 
     <title>멤버게시판 수정</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/oky/nong_modify.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/nong_modify.css"></link>
     <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<script>
  if('${result}'== 'passFail') {
	  alert("비밀번호가 다릅니다.")
  }
</script>
</head>
<body style="overflow-x:hidden; overflow-y:hidden;">
<br><br>
<div class="wrapper">
<main>
   <%-- 게시판 수정 --%>
  <div class="container">
   <form action="nongmodifyAction" 
          method="post" name="modifyform" enctype="multipart/form-data">
        <input type="hidden" id="name" value="${name}" name="name">
        <input type="hidden" name="nong_num"       value="${boarddata.nong_num}">
        <input type="hidden" name="nong_file"      value="${boarddata.nong_file}">
        <input type="hidden" name="before_file"     value="${boarddata.nong_file}">
     <h1>수정하기</h1>
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
</main>
<sidebar>
   <!--  <div class="logo">logo</div> -->
    <div class="avatar">
      <div class="avatar__img">
        <img width="25" class="display" src="pdisplay?fileName=${user.original}">
      </div>
      <div class="avatar__name" style="color:black;">${user.nick} 님</div>
    </div>
    <nav class="menu">
      <a class="menu__item" href="${pageContext.request.contextPath}/calprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/calendar.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">캘린더</span>
      </a>
      <a class="menu__item" href="${pageContext.request.contextPath}/accprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/accounting.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">가계부</span>
      </a>    
      <a class="menu__item menu__item--active" href="${pageContext.request.contextPath}/nongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/bbs.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">멤버게시판</span>
      </a>
      <a class="menu__item" href="${pageContext.request.contextPath}/mynongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/setting.png" alt="by"/>
        <!-- <i class="menu__icon fa fa-envelope"></i> -->
      <span style="padding:0px 0px 0px 17px;" class="menu__text">농장관리</span>
      </a>
      <span id="outmynong">
      <a class="menu__item" href="${pageContext.request.contextPath}/outmynong?id=${id}"><span class="menu__text">농장탈퇴</span></a>
      </span>
    </nav>
  </sidebar>
  </div>                     
</body>
</html>