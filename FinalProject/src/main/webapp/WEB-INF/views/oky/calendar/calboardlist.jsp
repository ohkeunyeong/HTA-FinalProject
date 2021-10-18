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
<script src="${pageContext.request.contextPath}/resources/js/oky/calboardlist.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/calboardlist.css"></link>
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
        <img width="25" class="display" src="pdisplay?fileName=${user.original}">
      </div>
      <div class="avatar__name" style="color:black;">${user.nick} 님</div>
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
      <span id="outmynong">
      <a class="menu__item" href="${pageContext.request.contextPath}/outmynong?id=${id}"><span class="menu__text">농장탈퇴</span></a>
      </span>
    </nav>
  </sidebar>
</div>
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