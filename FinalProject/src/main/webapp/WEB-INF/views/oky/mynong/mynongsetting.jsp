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
 <script>
  var result="${result}";
  if(result =='updateSuccess') {
	  alert("수정 완료 되었습니니다.")
  }
 </script>
</head>
<body>
<br><br><br>
<input type="hidden" id="id" value="${id}" name="id">
<h1>내 농장 관리</h1>
<div>농장명 : ${mynong_name}<br>
     관리자 아이디 : ${id}
</div>
<div>회원 추가 
<a href="#" data-toggle="modal" data-target="#idsearch">검색</a>
</div>
<div><a href="#" onClick="deletecheck('${mynong_name}','${id}')">농장 삭제 </a></div>

<div class="container">
 <c:if test="${listcount > 0}"> <%-- 회원이 있는 경우 --%>
   <table class="table table-striped">
    <thead>
      <tr>
        <th colspan="3">농장 멤버 list</th>
        <th>
            <font size=4>회원 수 : ${listcount}</font>
        </th>
      </tr>
      <tr>
        <td>아이디</td><td>닉네임</td><td>등급</td><td>삭제</td>
      </tr>
     </thead>
     <tbody>
       <c:forEach var="m" items="${memberlist}">
         <tr>
           <td>
               <a href="info?id=${m.id}">${m.id}</a>
           </td>
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
          <td><a href="deletenongmem?id=${m.id}">삭제</a></td>
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
     </div> 
   </c:if>    
</div>

<%-- 회원이 없는 경우 --%>
 <c:if test="${listcount == 0}">
   <h1> 회원이 없습니다.</h1>
 </c:if>


  <!-- 회원 추가 modal -->
  <div class="modal fade" id="idsearch" role="dialog"> 

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <h4 class="modal-title" align="center">회원 아이디 검색</h4> 
          <button type="button" class="close" data-dismiss="modal" >×</button>
        </div>
        <div class="modal-body">
                   <form id="my-form" action="${pageContext.request.contextPath}/okyaddid" method="post">
                   <input type="hidden" id="MYNONG_NAME" value="${mynong_name}" name="mynong_name">
                   <input type="hidden" id="admin" value="${id}" name="admin">
                   <input type ="text" name="id" id="idck" value="${m.id}">            
                   <button type="button" id="search" class="searchid" >검색</button><br>
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
                   <button type="submit" id="search" class="searchid" >수정</button>
                   </form>
        </div>
        </div>
      </div>
    </div>     
<jsp:include page="../../main/footer.jsp" /> 
</body>
</html>