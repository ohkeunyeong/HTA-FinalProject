<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정추가</title>
<jsp:include page="../../main/header.jsp" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/caldetail.css"></link>
<%
	int year=Integer.parseInt(request.getParameter("year"));
 	int month=Integer.parseInt(request.getParameter("month"));
 	int date=Integer.parseInt(request.getParameter("date"));
 	
 	//현재시간구하기
 	Calendar cal = Calendar.getInstance();
 	int hour = cal.get(Calendar.HOUR_OF_DAY);
 	int min = cal.get(Calendar.MINUTE);
%>
<script>
function calendar() {
	location.href = "calendar?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=date%>";
}
$(document).ready(function() {
	$("form").submit(function() {

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
	});// submit end
});// ready()end
</script>
</head>
<body style="overflow-x: hidden; overflow-y: auto;">
<br><br>
<div class="wrapper">
<main>
<form action="insertcalboard" method="post">
<input type="hidden" name="name" value="${name}"/>
<div class="container1" role="main">
		<div class="container1" role="main">
			<div class="page-title">
				<div class="container2">
					<h1>일정추가</h1>
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
                      <%
                          for(int i= year-5; i< year+5; i++){
                        	  %>
                        	  <option <%=year==i?"selected":""%> value="<%=i%>"><%=i%></option>
                        	  <%
                          }
                      %>                     
                  </select>년
                  <select name="month">
                      <%
                          for(int i= 1; i<= 12; i++){
                        	  %>
                        	  <option <%=month==i?"selected":""%> value="<%=i%>"><%=i%></option>
                        	  <%
                          }
                      %>    
                  </select>월
                  <select name="date">
                      <%
                          for(int i= 1; i<=31; i++){
                        	  %>
                        	  <option <%=date==i?"selected":""%> value="<%=i%>"><%=i%></option>
                        	  <%
                          }
                      %>                     
                  </select>일
                  <select name="hour">
                       <%
                          for(int i= 0; i<24; i++){
                        	  %>
                        	  <option <%=hour==i?"selected":""%> value="<%=i%>"><%=i%></option>
                        	  <%
                          }
                      %>                    
                  </select>시
                  <select name="min">
                      <%
                          for(int i= 0; i<60; i++){
                        	  %>
                        	  <option <%=min==i?"selected":""%> value="<%=i%>"><%=i%></option>
                        	  <%
                          }
                      %>                     
                  </select>분
             </td>
        </tr>
        <tr>
             <th>제목</th>
             <td><input style="margin-left: -98px; width : 517px;" type="text" name="title" id="title" /></td>
        </tr>
        <tr>
             <th>내용</th>
             <td><textarea style="resize: none; margin-left: -97px;" rows="6" cols="60" name="content" id="content"></textarea></td>
        </tr>
        <tr>            
             <td colspan="2">            								    
				   <button type="submit" class="btn btn-info">일정작성</button>
				   <button type="button" class="btn btn-secondary" onclick="calendar()" >돌아가기</button>  
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
		</nav>
		</sidebar>
	</div>
<jsp:include page="../../main/footer.jsp" /> 
</body>
</html>