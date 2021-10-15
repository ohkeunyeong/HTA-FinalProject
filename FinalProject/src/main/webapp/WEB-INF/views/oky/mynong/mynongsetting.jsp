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
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
 <script>
  var result="${result}";
  if(result =='updateSuccess') {
	  alert("수정 완료 되었습니니다.")
  }
 </script>
<style>
    #sideicon{ /* 사이드바 아이콘 */
    width: 15px; height: 15px;
    }   

/**
 * ALL the UI design credit goes to:
 * https://www.sketchappsources.com/free-source/2676-calendar-template-sketch-freebie-resource.html
 */


/* WRAPPER */

.wrapper {
  display: grid;
  grid-template-rows: 70px 1fr 70px;
  grid-template-columns: 1fr;
  grid-template-areas: "sidebar"
                       "content";
  width: 100vw; /* unnecessary, but let's keep things consistent */
  height: 100vh;
}

@media screen and (min-width: 850px) {
  .wrapper {
    grid-template-columns: 200px 5fr;
    grid-template-rows: 1fr;
    grid-template-areas: "sidebar content";
  }
}



/* SIDEBAR */

main {
  grid-area: content;
  padding: 48px;
}

sidebar {
  grid-area: sidebar;
  display: grid;
  grid-template-columns: 1fr 3fr 1fr;
  grid-template-rows: 3fr 1fr;
  grid-template-areas: "logo menu avatar"
                       "copyright menu avatar";
  color: #A8B2B9; 
}
.logo {
  display: flex;
  align-items: center;
  justify-content: center;
}
.copyright {
  text-align: center;
}
.avatar {
  grid-area: avatar;
  display: flex;
  align-items: center;
  flex-direction: row-reverse;
}
.avatar__name {
  flex: 1;
  text-align: right;
  margin-right: 1em;
}
.avatar__img > img {
  display: block;
}

.copyright {
  grid-area: copyright;
}
.menu {
  grid-area: menu;
  display: flex;
  align-items: center;
  justify-content: space-evenly;
}
.logo {
  grid-area: logo;
}
.menu__text {
  display: none;
}

@media screen and (min-width: 850px) {
  sidebar {
    grid-template-areas: "logo"
                         "avatar"
                         "menu"
                         "copyright";
    grid-template-columns: 1fr;
    grid-template-rows: 50px auto 1fr 50px;
  }
  
  .menu {
    flex-direction: column;
    align-items: normal;
    justify-content: flex-start;
  }
  .menu__text {
    display: inline-block;
  }
  .avatar {
    flex-direction: column;
  }
  .avatar__name {
    margin: 1em 0;
  }
  .avatar__img > img {
    border-radius: 50%;
  }
}




/* MAIN */

.toolbar{
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.calendar{}

.calendar__week,
.calendar__header {
  display: grid;
  grid-template-columns: repeat(7, 1fr);  
}
.calendar__week {
  grid-auto-rows: 100px;
  text-align: right;
}

.calendar__header {
  grid-auto-rows: 50px;
  align-items: center;
  text-align: center;
}

.calendar__day {
  padding: 16px;
}




/* COSMETIC STYLING */

:root {
  --red: #ED5454;
}

.wrapper {
/*   font-family: Montserrat; 
  font-weight: 100;  */
} 

sidebar {
  background-color: white;
  box-shadow: 5px 0px 20px rgba(0, 0, 0, 0.2);
}

main {
  background-color: #FCFBFC;
}

.avatar__name {
  font-size: 0.8rem;
}

.menu__item {
  text-transform: uppercase;
  font-size: 0.7rem;
  font-weight: 500;
  padding: 16px 16px 16px 14px;
  border-left: 4px solid transparent;
  color: inherit;
  text-decoration: none;
  transition: color ease 0.3s;
}

.menu__item--active .menu__icon {
  color: var(--red);
}
.menu__item--active .menu__text {
  color: black;
}

.menu__item:hover {
  color: black;
}


.menu__icon {
  font-size: 1.3rem;
}

@media screen and (min-width: 850px) {
  .menu__icon {
    font-size: 0.9rem;
    padding-right: 16px;
  }
  .menu__item--active {
    border-left: 4px solid var(--red);
    box-shadow: inset 10px 0px 17px -13px var(--red);
  }
}

.copyright {
  font-size: 0.7rem;
  font-weight: 400;
}

.calendar {
  background-color: white;
  border: 1px solid #e1e1e1;
}

.calendar__header > div {
  text-transform: uppercase;
  font-size: 0.8em;
  font-weight: bold;
}

.calendar__day {
  border-right: 1px solid #e1e1e1;
  border-top: 1px solid #e1e1e1;
}

.calendar__day:last-child {
  border-right: 0;
}

.toggle{
  display: grid;
  grid-template-columns: 1fr 1fr;

  text-align: center;
  font-size: 0.9em;
}
.toggle__option{
  padding: 16px;
  border: 1px solid #e1e1e1;
  border-radius: 8px;
  text-transform: capitalize;
  cursor: pointer;
}
.toggle__option:first-child {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}
.toggle__option:last-child {
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
.toggle__option--selected{
  border-color: white;
  background-color: white;
  color: var(--red);
  font-weight: 500;
  box-shadow: 1px 2px 30px -5px var(--red);
}
</style>
</head>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<div class="wrapper">
<main>
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
</main> 
<sidebar>
   <!--  <div class="logo">logo</div> -->
    <div class="avatar">
      <div class="avatar__img">
        <img src="https://picsum.photos/70" alt="avatar">
      </div>
      <div class="avatar__name">John Smith</div>
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