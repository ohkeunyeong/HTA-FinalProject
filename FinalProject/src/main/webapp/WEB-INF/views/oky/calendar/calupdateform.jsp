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
<script>
  $(document).ready(function () { 
	$("form").submit(function () {
		
		if ($.trim($("#title").val()) == "") {
			alert("제목을 입력하세요");
			$("#title").focus();
			return false;
		}		
		if ($.trim($("#content").val()) == "") {
			alert("내용을 입력하세요");
			$("#content").focus();
			return false;
		}	
	});//submit end
  });// ready()end
</script>
<style>
#sideicon { /* 사이드바 아이콘 */
	width: 15px;
	height: 15px;
}

/*     table td,th {
    border-top:1px solid black;
    border-bottom:1px solid black;
    border-collapse: collapse;
    text-align: center;
    padding: 10px;
}

table{
    width: 40%;
    border-collapse: collapse;
    line-height: 24px;
} */
h1 {
	margin-left: -0.8em;
	border: 5px solid currentColor;
	border-left-width: 20px;
	border-radius: 4px;
	padding: 0.4em 0.6em 0.4em 0.25em;
	color: #28A745;
	font-size: 38px;
	font-weight: 700;
	line-height: 1;
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
	grid-template-areas: "sidebar" "content";
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
	grid-template-areas: "logo menu avatar" "copyright menu avatar";
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

.avatar__img>img {
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
		grid-template-areas: "logo" "avatar" "menu" "copyright";
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
	.avatar__img>img {
		border-radius: 50%;
	}
}

/* MAIN */
.toolbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
}

.calendar {
	
}

.calendar__week, .calendar__header {
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
:root { -
	-red: #ED5454;
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
	color: var(- -red);
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
		border-left: 4px solid var(- -red);
		box-shadow: inset 10px 0px 17px -13px var(- -red);
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

.calendar__header>div {
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

.toggle {
	display: grid;
	grid-template-columns: 1fr 1fr;
	text-align: center;
	font-size: 0.9em;
}

.toggle__option {
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

.toggle__option--selected {
	border-color: white;
	background-color: white;
	color: var(- -red);
	font-weight: 500;
	box-shadow: 1px 2px 30px -5px var(- -red);
}
</style>
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
			 <button class="btn btn-secondary">목록</button> </a>
             <a onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'">
			 <button class="btn btn-info">달력</button></a> 
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
				<img src="https://picsum.photos/70" alt="avatar">
			</div>
			<div class="avatar__name">John Smith</div>
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
		</nav>
		</sidebar>
	</div>
<jsp:include page="../../main/footer.jsp" /> 
</body>
</html>