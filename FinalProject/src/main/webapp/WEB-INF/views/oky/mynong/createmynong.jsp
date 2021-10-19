<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 농장 생성</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/createmynong.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/list.css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/createmynong.css"></link>
<style>
#sideicon { /* 사이드바 아이콘 */
	width: 15px;
	height: 15px;
}

.display { /*프로필사진 사이즈*/
	width: auto;
	height: auto;
	max-width: 150px;
	max-height: 150px;
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

#bbstable {
	border: solid;
	color: #28a745;
}
</style>
</head>
<body style="overflow-x:hidden; overflow-y:hidden;" >
<br><br>
<div class="wrapper">
<main>
<div class="container">
 <form name="createform" action="createProcess" method="post">
<input type="hidden" id="id" value="${id}" name="id">
      <div class="page-title">
        <div class="container2">         
            <h1>농장생성</h1>
         </div>
         </div>
<table class="table" id="bbstable">
<tr >
<td ><div>농장명은 영문자 숫자로 최대 10글자까지 가능합니다</div></td>
     <tr >
         <td >
<div>농장명    
<input type="text" name="mynong_name" id="name" placeholder="입력해주세요" required maxLength="10">
<span id="message"></span>
<button type="submit" class="submitbtn btn-success">농장생성</button>                 
</div>
         </td>
     </tr>    
     </table> 
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
</body>
</html>