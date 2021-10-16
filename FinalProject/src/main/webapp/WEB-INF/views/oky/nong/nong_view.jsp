<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>멤버게시판 view</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/nong_view.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/nong_view.css"></link>
<script>
    var result="${result}";
    if(result == 'passFail') {
    	alert("비밀번호가 일치하지 않습니다.")
    }
   $(function() {
	   $("form[action=delete]").submit(function(){
		   if ($("#board_pass").val() == '') {
			   alert("비밀번호를 입력하세요");
			   $("#board_pass").focus();
			   return false;
		   }
	   })
   })

</script>
</head>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<div class="wrapper">
<main>
<input type="hidden" id="id" value="${id}" name="id">
<input type="hidden" id="nongname" value="${name}" name="name">
<input type="hidden" id="path" value="${pageContext.request.contextPath}" name="path">
 <div class="container">
   <table class="table" id="bbstable" >
     <tr id="bbstr">
         <td id="bbstd"><div>글쓴이</div></td>
         <td><div>${boarddata.id}</div></td>
     </tr>
     <tr id="bbstr">
         <td id="bbstd"><div>제목</div></td>
         <td><c:out value="${boarddata.nong_sub}" /></td>
     </tr>     
     <tr id="bbstr">
         <td id="bbstd"><div>내용</div></td>
         <td style="padding-right:0px"><textarea class="form-control" rows="5" style=" background-color:transparent;"
               readOnly >${boarddata.nong_con}</textarea></td>
     </tr>     
     
   <c:if test="${boarddata.nong_re_lev==0}"><%--원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%>
    <tr id="bbstr">
      <td id="bbstd"><div>첨부파일</div></td>
     <c:if test="${!empty boarddata.nong_file}"><%-- 파일첨부한 경우 --%>
      <td><img src="${pageContext.request.contextPath}/resources/image/oky/down.png" width="10px">
          <form method="post" action="down">
            <input type="hidden" value="${boarddata.nong_file}" name="filename">
            <input type="hidden" value="${boarddata.nong_ori}" name="original">
            <input type="submit" value="${boarddata.nong_ori}">          
          </form>
      </td>
      </c:if>
      <c:if test= "${empty boarddata.nong_file}"><%-- 파일첨부하지 않은 경우 --%>
          <td></td>
      </c:if>
      </tr>
   </c:if>
     
     <tr>
         <td colspan="2" class="center">
           <button class="btn btn-primary start">댓글</button>
            <span id="count">${count}</span>          
           <c:if test="${boarddata.id == id || level == 1 }">
            <a href="nongmodifyView?name=${name}&num=${boarddata.nong_num}">
              <button class="btn btn-warning">수정</button>
            </a>
            <%-- href의 주소를 #으로 설정합니다. --%>
            <a href="#">
            <button class="btn btn-danger" data-toggle="modal"
                   data-target="#myModal">삭제</button>
            </a>
           </c:if>
           
           <a href="nongreplyView?name=${name}&num=${boarddata.nong_num}">
               <button class="btn btn-info">답변</button>
           </a>
           
           
           <a href="nong?name=${name}">
              <button class="btn btn-secondary">목록</button>
           </a>
         </td>
      </tr>              
   </table>
          <%-- 게시판 수정 end --%>

             <%-- modal 시작 --%>
             <div class="modal" id="myModal">
              <div class="modal-dialog">
               <div class="modal-content">
                 <%-- Modal body --%>
                 <div class="modal-body">
                  <form name="deleteForm" action="nongdelete" method="post">
                    <%-- http://localhost:8888/myhome6/detail?num=22
                                                 주소를 보면 num을 파라미터로 넘기고 있습니다.
                                                 이 값을 가져와서 ${param.num}를 사용
                                                 또는 ${boarddata.BOARD_NUM}
                     --%>
                     <input type="hidden" name="num" value="${param.num}" id="board_num">
                     <input type="hidden" id="nongname" value="${name}" name="name">
                     <div class="form-group">
                        <label for="pwd">비밀번호</label>
                        <input type="password"
                               class="form-control" placeholder="Enter password"
                               name="nong_pass" id="board_pass">
                     </div>
                     <button type="submit" class="btn btn-primary">전송</button>
                     <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                  </form>
                 </div><!-- class="modal-body" -->
               </div><!-- class="modal-content" -->
              </div><!-- class="modal-dialog" -->
             </div>
             <!-- class="modal" -->
             
             <div id="comment">
             	<input type="hidden" id="loginid" value="${id}" name="loginid">
                <button class="btn btn-info float-left">총 50자 까지 가능합니다.</button>
                <button id="write" class="btn btn-info float-right">등록</button>
                <textarea rows=3 class="form-control"
                          id="content" maxLength="50"></textarea>
                <table class="table table-striped">
                  <thead>
                    <tr><td>아이디</td><td>내용</td><td>날짜</td></tr>
                  </thead>
                  <tbody>
                  
                  </tbody>
                </table>
                  <div id="message"></div>           
             </div><!-- comment end -->
          </div><!-- container end -->
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
    </nav>
  </sidebar>
  </div>                   
<jsp:include page="../../main/footer.jsp" />           
</body>
</html>