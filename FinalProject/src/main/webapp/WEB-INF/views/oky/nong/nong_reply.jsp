<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
     <title>멤버게시판 답글쓰기</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <script src="${pageContext.request.contextPath}/resources/js/oky/nong_reply.js"></script>
     <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/nong_reply.css"></link> 
</head>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<div class="wrapper">
<main>
 <div class="container">
   <form action = "nongreplyAction" method="post" name="boardform">
     <input type="hidden" id="name" value="${name}" name="name">
     <input type="hidden" name="nong_re_ref" value="${boarddata.nong_re_ref}">
     <input type="hidden" name="nong_re_lev" value="${boarddata.nong_re_lev}">
     <input type="hidden" name="nong_re_seq" value="${boarddata.nong_re_seq}">
     <h1>답글쓰기</h1>
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