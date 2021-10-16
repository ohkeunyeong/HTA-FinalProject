<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="com.hta.project.controller.CalendarController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/calendar.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/calendar.css"></link>

<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>

</head>
<%
	//달력의 날짜를 바꾸기 위해 전달된 year와 month 파라미터를 받는다.
    String paramYear=request.getParameter("year");
    String paramMonth=request.getParameter("month");
    
    
    Calendar cal = Calendar.getInstance(); //new (X)
    int year=cal.get(Calendar.YEAR);//현재 년도를 구함
    int month=cal.get(Calendar.MONTH)+1;//현재 월을 구함 (0월~11월)
    
    if(paramYear !=null) {
    	year = Integer.parseInt(paramYear);
    }    
    if(paramMonth !=null) {
    	month = Integer.parseInt(paramMonth);
    }
    //월이 증가하다 12보다 커지면(13,14...)넘어가는 현상을 처리
    if(month>12) {
    	month=1;//1월로 변경
    	year++;//년도는 다음해로 넘어가니깐 년도+1증가시키기
    }
    //감소의 경우 처리
    if(month<1) {
    	month=12;
    	year--;
    }        
    //현재 월의 1일에 대한 요일 구하기: 1~7 -->1(일요일), 2(월), 3()......7(토)
    // set(y, month-1, 1) --> month-1 : calendar기준 0~11, 우리기준 (1~12)
    cal.set(year, month-1, 1); //원하는 날짜로 넣어준다
    int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
    
    //현재 월의 마지막 날 구하기
    int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    
    //해당 달의 일정 받기
    List<MyCalendar> clist=(List<MyCalendar>)request.getAttribute("clist");
%>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<input type="hidden" id="id" value="${id}" name="id">
<div class="wrapper">
  <main>
    <div class="toolbar">
      <div class="caption" style="color:black; font-size:18px;">
        <a href="calendar?name=${name}&year=<%=year-1%>&month=<%=month%>"><img id="arrowy" src="${pageContext.request.contextPath}/resources/image/oky/by.png" alt="by"/></a>
        <a href="calendar?name=${name}&year=<%=year%>&month=<%=month-1%>"><img id="arrowm" src="${pageContext.request.contextPath}/resources/image/oky/bm.png" alt="bm"/></a>
        <span class="y">
        <%=year%>
        </span>년
        <span class="m">
        <%=month%>
        </span>월 
        <a href="calendar?name=${name}&year=<%=year%>&month=<%=month+1%>"><img id="arrowm" src="${pageContext.request.contextPath}/resources/image/oky/fm.png" alt="fm"/></a>
        <a href="calendar?name=${name}&year=<%=year+1%>&month=<%=month%>"><img id="arrowy" src="${pageContext.request.contextPath}/resources/image/oky/fy.png" alt="fy"/></a>   
	</div>
    </div>
    <div class="calendar">
      <div class="calendar__header" style="color: #A8B2B9;">
        <div>일</div>
        <div>월</div>
        <div>화</div>
        <div>수</div>
        <div>목</div>
        <div>금</div>
        <div>토</div>
      </div>
      <div class="calendar__week">
        <%
        	//달력에서 시작하는 공백을 출력한다.
                    //공백 출력하는 for문
                    for(int i=0; i<dayOfWeek-1; i++){
                    	out.print("<div class='calendar__day day'></div>");
                    }
                    //날짜 출력하는 for문
                    for(int i=1; i<=lastDay; i++){
        %>      
       <div class="calendar__day day">
            	     <a class="countView" style="color:<%=CalendarController.fontColor(dayOfWeek, i)%>; text-decoration: none;" href="calboardlist?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
            	     <a href="insertcalform?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>">
            	     <c:if test="${level ==1}">
            	     		<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="일정추가"/>
            	     </c:if>
            	     </a>
             	     <%=getCalViewList(i, clist) %> 
      </div> 
            	<%
            	//행을 바꿔주기---> 현재일(i)이 토요일인지 확인: (공백수+현재날짜)한 값이 7로 나눠 떨어지면 7배수
            	if((dayOfWeek-1 + i)%7==0){
            		out.print("</div><div class='calendar__week'>");
            	}
            }
            //나머지 공백 출력하는 for문
            int countNbsp=(7-(dayOfWeek-1 + lastDay)%7)%7; //모듈러스 연산자
            for(int i=0; i<countNbsp; i++) {
            	out.print("<div class='calendar__day day'></div>");
            }
        %>          
        </div>     
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
      <a class="menu__item menu__item--active" 
      href="${pageContext.request.contextPath}/calprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/calendar.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">캘린더</span>
      </a> <a class="menu__item"
				href="${pageContext.request.contextPath}/accprocess?id=${id}"> <img
				id="sideicon"
				src="${pageContext.request.contextPath}/resources/image/oky/accounting.png"
				alt="by" /> <span style="padding: 0px 0px 0px 17px;"
				class="menu__text">가계부</span>
			</a> <a class="menu__item" href="${pageContext.request.contextPath}/nongprocess?id=${id}">
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
 <%!public String getCalViewList(int i, List<MyCalendar> clist){
	   String d=CalendarController.isTwo(i+""); // mdate--> "05"
	   String cList="";//달력에 출력해줄 일정제목을 저장할 변수
	   for(MyCalendar cal: clist){
		   if(cal.getMdate().substring(6, 8).equals(d)){
			   cList+="<a style='text-decoration: none; text-align:left;' href='caldetailmain?name=" + cal.getName()+ "&seq=" + cal.getSeq() +"'><p style='margin-bottom: 0.3rem;'>"
		+(cal.getTitle().length() > 20 ? cal.getTitle().substring(0, 20) + "..." : cal.getTitle())
					+"</p></a>";
		   }
	   }
	   return cList; //결과: "<p>title</p><p>title</p>"
}%> 
<jsp:include page="../../main/footer.jsp" />
</body>
</html>
