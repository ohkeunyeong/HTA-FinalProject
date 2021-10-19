<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 상세보기</title>
<jsp:include page="../../main/header.jsp" /> 
<jsp:useBean id="util" class="com.hta.project.controller.CalendarController" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/caldetail.css"></link>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<script>
function page_back(){
	history.go(-1);
}
$(document).ready(function () {  
	
	$("#outmynong").click(function(){
		if(confirm("농장에서 탈퇴 하시겠습니까?")){
		}else {
			return false
		}	
	})
	});
</script>
</head>
<body style="overflow-x: hidden; overflow-y: auto;">
	<br>
	<br>
	<div class="wrapper">
		<main>
		<div class="container1" role="main">
			<div class="page-title">
				<div class="container2">
					<h1>상세일정</h1>
				</div>
			</div>
			<div id="board-list">
				<div class="container">
					<table class="board-table">
						<tbody>
							<tr>
								<th>제목</th>
								<td style="text-align: left;">${calendar.title}</td>
							</tr>
							<tr>
								<th>일정시간</th>
								<td style="text-align: left;"><jsp:setProperty
										value="${calendar.mdate}" property="toDates" name="util" /> <jsp:getProperty
										property="toDates" name="util" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea style="resize: none; margin-left: -97px;"
										rows="6" cols="60" readonly="readonly">${calendar.content}</textarea></td>
							</tr>
							<tr>
								<td colspan="2">
								<a onclick="page_back();">
										<button class="btn btn-secondary">돌아가기</button> </a> 
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
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