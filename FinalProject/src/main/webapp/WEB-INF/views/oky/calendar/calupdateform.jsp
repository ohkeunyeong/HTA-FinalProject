<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정수정</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/caldetail.css"></link>
<script src="${pageContext.request.contextPath}/resources/js/oky/calupdateform.js"></script>
</head>
<body style="overflow-x: hidden; overflow-y: auto;">
<br><br>
<div class="wrapper">
<main>
<form action="calupdate" method="post">
<input type="hidden" name="seq" value="${calendar.seq}"/>
<input type="hidden" name="name" value="${name}"/>
<div class="container1" role="main">
		<div class="container1" role="main">
			<div class="page-title">
				<div class="container2">
					<h1>일정수정</h1>
				</div>
			</div>
						<div id="board-list">
				<div class="container">
					<table class="board-table">
						<tbody>
        <tr>
         <th>일정</th>
         <td>
          <select name="year" style="margin-left: -266px; width : 63px;">
           			  <c:set var="year" value="${fn:substring(calendar.mdate, 0, 4)}"/>
                      <c:forEach var="i"  begin="${year-5}"   end="${year+5}"   step="1">
                             <option ${year==i?"selected":""} value="${i}">${i}</option>
                      </c:forEach>                    
                  </select>년
                  <select name="month">
           			  <c:set var="month" value="${fn:substring(calendar.mdate, 4, 6)}"/>
                      <c:forEach var="i"  begin="1"   end="12"   step="1">
                             <option ${month==i?"selected":""} value="${i}">${i}</option>
                      </c:forEach>
                  </select>월
                  <select name="date">
           			  <c:set var="date" value="${fn:substring(calendar.mdate, 6, 8)}"/>
                      <c:forEach var="i"  begin="1"   end="31"   step="1">
                             <option ${date==i?"selected":""} value="${i}">${i}</option>
                      </c:forEach>                
                  </select>일
                  <select name="hour">
           			  <c:set var="hour" value="${fn:substring(calendar.mdate, 8, 10)}"/>
                      <c:forEach var="i"  begin="0"   end="23"   step="1">
                             <option ${hour==i?"selected":""} value="${i}">${i}</option>
                      </c:forEach>                    
                  </select>시
                  <select name="min">
           			  <c:set var="min" value="${fn:substring(calendar.mdate, 10, 12)}"/>
                      <c:forEach var="i"  begin="0"   end="59"   step="1">
                             <option ${min==i?"selected":""} value="${i}">${i}</option>
                      </c:forEach>                    
                  </select>분
         </td>
    </tr>    
    <tr>
         <th>제목</th>
         <td><input style="margin-left: -98px; width : 517px;" type="text" name="title" id="title" value="${calendar.title}"/></td>
    </tr>    
    <tr>
         <th>내용</th>
         <td><textarea style="resize: none; margin-left: -97px;" rows="6" cols="60" name="content" id="content">${calendar.content}</textarea></td>
    </tr> 
    <tr>
         <td colspan="2">
             <button type="submit" class="btn btn-warning">수정</button>
             <a onclick="location.href='calboardlist?name=${name}'">
			 <button type="button" class="btn btn-secondary">목록</button> </a>
             <a onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'">
			 <button type="button" class="btn btn-info">달력</button></a> 
         </td>
    </tr>
            </tbody>  
</table>
</div>
</div>
</div>
</div>
</form>
</main>
		<sidebar> <!--  <div class="logo">logo</div> -->
    <div class="avatar">
      <div class="avatar__img">
        <img width="25" class="display" src="pdisplay?fileName=${user.original}">
      </div>
      <div class="avatar__name" style="color:black;">${user.nick} 님</div>
    </div>
		<nav class="menu">
			<a class="menu__item menu__item--active"
				href="${pageContext.request.contextPath}/calprocess?id=${id}"> <img
				id="sideicon"
				src="${pageContext.request.contextPath}/resources/image/oky/calendar.png"
				alt="by" /> <span style="padding: 0px 0px 0px 17px;"
				class="menu__text">캘린더</span>
			</a> <a class="menu__item"
				href="${pageContext.request.contextPath}/accprocess?id=${id}"> <img
				id="sideicon"
				src="${pageContext.request.contextPath}/resources/image/oky/accounting.png"
				alt="by" /> <span style="padding: 0px 0px 0px 17px;"
				class="menu__text">가계부</span>
			</a> <a class="menu__item"
				href="${pageContext.request.contextPath}/nongprocess?id=${id}">
				<img id="sideicon"
				src="${pageContext.request.contextPath}/resources/image/oky/bbs.png"
				alt="by" /> <span style="padding: 0px 0px 0px 17px;"
				class="menu__text">멤버게시판</span>
			</a> <a class="menu__item"
				href="${pageContext.request.contextPath}/mynongprocess?id=${id}">
				<img id="sideicon"
				src="${pageContext.request.contextPath}/resources/image/oky/setting.png"
				alt="by" /> <!-- <i class="menu__icon fa fa-envelope"></i> --> <span
				style="padding: 0px 0px 0px 17px;" class="menu__text">농장관리</span>
			</a>
      <span id="outmynong">
      <a class="menu__item" href="${pageContext.request.contextPath}/outmynong?id=${id}"><span class="menu__text">농장탈퇴</span></a>
      </span>
		</nav>
		</sidebar>
	</div>
</body>
</html>