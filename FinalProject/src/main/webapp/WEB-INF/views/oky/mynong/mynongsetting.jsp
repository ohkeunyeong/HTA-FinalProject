<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 농장 관리</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/mynongsetting.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/list2.css"></link>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/mynongsetting.css"></link>
 <script>
  var result="${result}";
  if(result =='updateSuccess') {
	  alert("수정 완료 되었습니니다.")
  }
 </script>
</head>
<body style="overflow-x:hidden; overflow-y:hidden;">
<br><br>
<div class="wrapper">
<main>
<input type="hidden" id="id" value="${id}" name="id">
      <div class="page-title">
      

         <div class="container2">
         
            <h1>"${mynong_name}" 농장 관리</h1>
         </div>
         </div>
<div class="container">
 <c:if test="${listcount > 0}"> <%-- 회원이 있는 경우 --%>
   <table class="table table-striped">
    <thead>
      <tr>
        <th colspan="2">농장 멤버 list</th>
        <th>
            <font size=3>회원 수 : ${listcount}</font>
        </th>
        <th>
        <a href="#" data-toggle="modal" data-target="#idsearch">회원추가</a>
        </th>
      </tr>
      <tr>
        <td>아이디</td><td>닉네임</td><td>등급</td><td>삭제</td>
      </tr>
     </thead>
     <tbody>
       <c:forEach var="m" items="${memberlist}">
         <tr>
          <td>${m.id}</td>
          <td>${m.nick}</td>
          <c:if test="${m.my_farm ==1}">
          <td>
          <a href="#" onClick="checkTarget('${m.id}')" data-toggle="modal" data-target="#option">
                    관리자
          </a>
          </td>
          </c:if> 
          <c:if test="${m.my_farm ==2}">
          <td>
          <a href="#" onClick="checkTarget('${m.id}')" data-toggle="modal" data-target="#option" >
          <input type="hidden"id="memid" value="${m.id}" name="id">
                    멤버
          </a>
          </td>
          </c:if>
          <c:if test="${m.my_farm ==3}">
          <td>대기</td>
          </c:if>                    
          <td onClick="deletemem('${m.id}')"><a href="#">삭제</a></td>
          </tr>
         </c:forEach>         
     </tbody>
  </table>
  <div>
      <ul class="pagination justify-content-center">
        <c:if test="${page <= 1 }">
            <li class="page-item">
              <a class="page-link current" href="#">이전&nbsp;</a>
            </li>
        </c:if>
        <c:if test="${page > 1 }">
             <li class="page-item">
        <a href="mynong?page=${page-1}&name=${mynong_name}&id=${id}"
               class="page-link">이전</a>&nbsp;
          </li>
       </c:if>
       
       <c:forEach var="a" begin="${startpage}" end="${endpage}">
           <c:if test="${a == page }">
               <li class="page-item">
                   <a class="page-link current" href="#" >${a}</a>
               </li>
           </c:if>
           <c:if test="${a != page }">
               <li class="page-item">
        <a href="mynong?page=${a}&name=${mynong_name}&id=${id}"
               class="page-link">${a}</a>       
              </li>
           </c:if>
       </c:forEach>        
       
      <c:if test="${page >= maxpage }">
          <li class="page-item">
              <a class="page-link current" href="#">&nbsp;다음</a>
          </li>
      </c:if>
      <c:if test ="${page < maxpage}">
         <li class="page-item">    
        <a href="mynong?page=${page+1}&name=${mynong_name}&id=${id}"
               class="page-link">&nbsp;다음</a>    
        </li>
       </c:if>  
      </ul>
      <div style="float: right;">
      <button type="submit" onClick="deletecheck('${mynong_name}','${id}')" class="submitbtn btn btn-danger">농장삭제</button>                 
      </div>
     </div> 
   </c:if>    
</div>

<%-- 회원이 없는 경우 --%>
 <c:if test="${listcount == 0}">
   <h2> 회원이 없습니다.</h2>
   <button  class="btn btn-success" data-toggle="modal" data-target="#idsearch">회원추가</button> 
   <button type="submit" onClick="deletecheck('${mynong_name}','${id}')" class="submitbtn btn btn-danger">농장삭제</button>                 
 </c:if>
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
      <a class="menu__item" href="${pageContext.request.contextPath}/nongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/bbs.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">멤버게시판</span>
      </a>
      <a class="menu__item menu__item--active" href="${pageContext.request.contextPath}/mynongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/setting.png" alt="by"/>
        <!-- <i class="menu__icon fa fa-envelope"></i> -->
      <span style="padding:0px 0px 0px 17px;" class="menu__text">농장관리</span>
      </a>
    </nav>
  </sidebar>
  </div>         

  <!-- 회원 추가 modal -->
  <div class="modal fade" id="idsearch" role="dialog"> 

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <h4 class="modal-title" align="center">회원 아이디 검색</h4> 
          <button type="button" class="close " data-dismiss="modal" >×</button>
        </div>
        <div class="modal-body">
                   <form id="my-form" action="${pageContext.request.contextPath}/okyaddid" method="post">
                   <input type="hidden" id="MYNONG_NAME" value="${mynong_name}" name="mynong_name">
                   <input type="hidden" id="admin" value="${id}" name="admin">
                   <input type ="text" name="id" id="idck" value="${m.id}">            
                   <button type="button" id="search" class="searchid btn-info" >검색</button><br>
                   <span id="message2"></span><span id="message3"></span>
                   </form>
        </div>
        </div>
      </div>
    </div> 
    
  <!-- 권한관리 modal -->
  <div class="modal fade" id="option" role="dialog"> 

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <h4 class="modal-title" align="center">회원 권한 관리</h4> 
          <button type="button" class="close" data-dismiss="modal" >×</button>
        </div>
        <div class="modal-body">
                   <form id="my-form" action="${pageContext.request.contextPath}/nongoption" method="post">
                   <input type="hidden" id="MYNONG_NAME" value="${mynong_name}" name="name">
                   <input type="hidden" id="admin" value="${id}" name="id" >
                   <input type="hidden" id="usersetid"  name="userid" >
                   <span>유저 아이디 :</span><span id="userid"></span><br>
                   <select name="optiontype" id="optiontype">
                   <option value="1">관리자</option>
				   <option value="2" selected>멤버</option>
                   </select>
                   <button type="submit" id="search" class="searchid btn-success" >수정</button>
                   </form>
        </div>
        </div>
      </div>
    </div>         
</body>
</html>