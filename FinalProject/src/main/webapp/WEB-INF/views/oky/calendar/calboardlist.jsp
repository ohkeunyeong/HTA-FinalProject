<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정목록보기</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/list.css"></link>
<script>
  function allSel(val){
	  
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].checked=val;
	  }
	  
  }
  
  $(function(){
	  $("form").submit(function(){
		  var bool=true;
		  var count=$(this).find("input[name=seq]:checked").length;
		  if(count==0){
			  alert('하나 이상 체크하세요');
			  bool=false;			  
		  }else if(confirm("삭제하시겠습니까?")){
			  bool=true;
		  }else{
			  bool=false;
		  }
		  return bool;
	  });
	  
	  //체크박스 처리: 전체선택 체크박스 체크/해제를 자동으로 하는 기능
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].onclick = function(){//체크박스 클릭 이벤트 시
			  var checkedObjs=document.querySelectorAll("input[name=seq]:checked");
		  	  if(checkedObjs.length==chks.length){
		  		document.getElementsByName("all")[0].checked=true;//체크해줌
		  	  }else{
		  		document.getElementsByName("all")[0].checked=false;//체크해줌  
		  	  }			  
		   }
		}
  })
</script>
<style>
    #pen{
    width: 15px; height: 15px;
    } /* 연필그림 사이즈*/
    
    #arrowy{ /* 연표시 화살표*/
    width: 15px; height: 15px;
    }
    #arrowm{ /* 달표시 화살표*/
    width: 20px; height: 21px;
    }
    #sideicon{ /* 사이드바 아이콘 */
    width: 15px; height: 15px;
    }    
     a> p{
         font-size: 11px;
         background-color: #28a745;
         color: white;        
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
<%
    List<MyCalendar> list = (List<MyCalendar>)request.getAttribute("list");
%>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<div class="wrapper">
<main>
<input type="hidden" id="id" value="${id}" name="id">
<form action="calmuldel" method="post">
<input type="hidden" name="name" value="${name}"/>
<input type="hidden" name="year" value="${param.year}">
<input type="hidden" name="month" value="${param.month}">
<input type="hidden" name="date" value="${param.date}">

<div class="container1" role="main">
      <div class="page-title">
        <div class="container2">         
            <h1>일정목록</h1>
         </div>
         </div>
      <div id="board-search">
         <div class="container2">
         </div>
      </div>
         
     <c:if test="${level ==1 && list.size() != 0}"> <!--접속자가 관리자이며 목록이 한개 이상 있을 경우 -->
            <div id="board-list">
            	<div class="container">
            		<table class="board-table">
               <thead>              
                  <tr>
                     <th scope="col" class="th-num"><input type="checkbox" name="all" onclick="allSel(this.checked)" /></th>
                     <th style="font-size:20px;" scope="col" class="th-date">제목</th>
                     <th style="font-size:20px;" scope="col" class="th-date">일정 시간</th>
                     <th style="font-size:20px;" scope="col" class="th-date">작성일</th>
                  </tr>
               </thead>
               <tbody>
        		<tr>
        <%            
        	for(MyCalendar dao:list) {
        		%>
        		    <td><input type="checkbox" name="seq" value="<%=dao.getSeq()%>"/></td>
        		    <td><div><a href="caldetail?name=${name}&seq=<%=dao.getSeq()%>"><%=dao.getTitle()%></a></div></td>
        		    <td><div><%=toDates(dao.getMdate())%></div></td>
        		    <td><div><fmt:formatDate pattern="yyyy-MM-dd" value="<%=dao.getRegdate()%>"/></div></td>
        		</tr>
        		<% 
        	}        
     %>
     </tbody>
  </table>
   <br>
   <div class="center-block">	
      <div class="btn-wrap">   
       <button type="submit" style="background-color:red;" class="btn">삭제</button>  
       <button type="button" onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'" class="btn">돌아가기</button>  
      </div>
		</div>
	</div>
   </div>
     </c:if>
     <c:if test="${level !=1 && list.size() != 0}"> <!--접속자가 일반멤버이며 목록이 한개 이상 있을 경우 -->
       <div id="board-list">
       	<div class="container">
       		<table class="board-table">
          <thead>              
             <tr>                
                <th style="font-size:20px;" scope="col" class="th-date">제목</th>
                <th style="font-size:20px;" scope="col" class="th-date">일정</th>
                <th style="font-size:20px;" scope="col" class="th-date">작성일</th>
             </tr>
          </thead>
          <tbody>
   		<tr>
   <%            
   	for(MyCalendar dao:list) {
   		%>
   		    <td><div><a href="caldetail?name=${name}&seq=<%=dao.getSeq()%>"><%=dao.getTitle()%></a></div></td>
   		    <td><div><%=toDates(dao.getMdate())%></div></td>
   		    <td><div><fmt:formatDate pattern="yyyy-MM-dd" value="<%=dao.getRegdate()%>"/></div></td>
   		</tr>
   		<% 
   	}        
%>
   </tbody>
</table>
 <br>
 <div class="center-block">	
    <div class="btn-wrap">    
     <button type="button" onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'" class="btn">돌아가기</button>
     </div>
	</div>
</div>
  </div>
    </c:if>
    <c:if test="${list.size() == 0}"> <!-- 접속자가 관리자이며 달력이 없을 경우 -->
    <div class="container">
<font size=5>등록된 글이 없습니다.</font>
<div class="btn-wrap">   
       <button type="button" onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'" class="btn">돌아가기</button>
      </div>
</div>
     </c:if>
 </div>    
</form>		
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
      <a class="menu__item menu__item--active" href="${pageContext.request.contextPath}/calprocess?id=${id}">
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
<%!
	public String toDates(String mdate){
	
		//문자열--->date타입으로 변환--> 문자열을 데이트패턴으로 수정 --> 데이트다입으로 변환
		
		//날짜형식: yyyy-MM-dd hh:mm:ss
		String m=mdate.substring(0, 4)  + "-"
		  		+mdate.substring(4, 6)  + "-"
		  		+mdate.substring(6, 8)  + " "		  		
		  		+mdate.substring(8, 10)  + ":"	
		  		+mdate.substring(10)  + ":00";	
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		Timestamp tm=Timestamp.valueOf(m);//문자열을 Date타입으로 변환
	  	return sdf.format(tm);
}
%>
</html>